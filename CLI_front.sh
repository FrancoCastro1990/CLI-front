#!/bin/bash

# Procesar argumentos

# CLI Frontend Generator - Improved Version with Configuration SystemNAME=\

# Supports modular templates and flexible configuration

# Cargar configuración
load_config() {
    local config_file="${1:-$HOME/.cli-frontend.conf}"
    
    if [ -f "$config_file" ]; then
        while IFS='=' read -r key value; do
            # Ignorar comentarios y líneas vacías
            [[ $key =~ ^# ]] || [[ -z $key ]] && continue
            
            # Eliminar espacios y comillas
            key=$(echo "$key" | tr -d '[:space:]')
            value=$(echo "$value" | tr -d '[:space:]' | sed -e 's/^"//' -e 's/"$//' -e "s/^'//" -e "s/'$//")
            
            # Asignar valores a variables
            case "$key" in
                "default_type") DEFAULT_TYPE="$value" ;;
                "create_folder") CREATE_FOLDER="$value" ;;
                "enable_hooks") ENABLE_HOOKS="$value" ;;
                "templates_dir") TEMPLATES_DIR=$(eval echo "$value") ;;
                "output_dir") OUTPUT_DIR="$value" ;;
            esac
        done < "$config_file"
    fi
}

# Configuración por defecto
DEFAULT_TYPE="component"
CREATE_FOLDER=true
ENABLE_HOOKS=true
TEMPLATES_DIR="$HOME/.cli-template"
OUTPUT_DIR="./src"

# Cargar configuración
load_config

# Función para mostrar ayuda
show_help() {
  echo "Usage: $0 [name] [--type component|hook|service|context|page] [--no-folder] [--config path/to/config.conf]"
  echo
  echo "Generates a component, hook, service, context or page."
  echo
  echo "  name           The name of the component, hook, service, context or page to generate."
  echo "  --type         The type of structure to generate: component, hook, service, context, page."
  echo "  --no-folder    (Optional) Generate the file without creating a folder."
  echo "  --config       (Optional) Path to custom configuration file."
  echo "  --help         Show this help message."
  echo
  echo "Available templates:"
  if [ -d "$TEMPLATES_DIR" ]; then
    ls -1 "$TEMPLATES_DIR" 2>/dev/null | grep -v "^\." || echo "  No templates found"
  else
    echo "  Template directory not found: $TEMPLATES_DIR"
  fi
  echo
  echo "Examples:"
  echo "  $0 Button --type component"
  echo "  $0 useAuth --type hook" 
  echo "  $0 ApiService --type service"
  echo "  $0 UserContext --type context"
  echo "  $0 HomePage --type page"
  echo "  $0 Modal --type component --no-folder"
  echo "  $0 Login --config ./my-config.conf"
  echo
  echo "Configuration file: ${1:-$HOME/.cli-frontend.conf}"
}

# Procesar argumentos
NAME=""
TYPE=""
NO_FOLDER=false
CUSTOM_CONFIG=""

while [[ $# -gt 0 ]]; do
    case "$1" in
        --type)
            TYPE="$2"
            shift 2
            ;;
        --no-folder)
            NO_FOLDER=true
            shift
            ;;
        --config)
            CUSTOM_CONFIG="$2"
            shift 2
            ;;
        --help)
            show_help "$CUSTOM_CONFIG"
            exit 0
            ;;
        -*)
            echo "Error: Unknown option $1"
            show_help
            exit 1
            ;;
        *)
            if [ -z "$NAME" ]; then
                NAME="$1"
            else
                echo "Error: Too many arguments"
                show_help
                exit 1
            fi
            shift
            ;;
    esac
done

# Cargar configuración personalizada si se especificó
if [ -n "$CUSTOM_CONFIG" ]; then
    load_config "$CUSTOM_CONFIG"
fi

# Usar tipo por defecto si no se especificó
if [ -z "$TYPE" ]; then
    TYPE="$DEFAULT_TYPE"
fi

# Verificar que se proporcionó un nombre
if [ -z "$NAME" ]; then
    echo "Error: No name was provided."
    show_help "$CUSTOM_CONFIG"
    exit 1
fi

# Verificar que el directorio de templates existe
if [ ! -d "$TEMPLATES_DIR" ]; then
    echo "Error: Templates directory not found: $TEMPLATES_DIR"
    echo "Please run the installation script first or check your configuration."
    exit 1
fi

# Verificar que el tipo es válido
if [ ! -d "$TEMPLATES_DIR/$TYPE" ]; then
    echo "Error: Unknown type '$TYPE'. Available types:"
    ls -1 "$TEMPLATES_DIR" 2>/dev/null | grep -v "^\." || echo "  No templates found"
    exit 1
fi

# Variables restantes
CURRENT_DIR=$(pwd)
TEMP_DIR=$(mktemp -d)

# Crear directorio de salida si no existe
mkdir -p "$OUTPUT_DIR"

# Función para copiar y procesar templates
copy_template() {
    local TYPE_PARAM=$1
    local DESTINATION=$2

    # Copiar plantillas a directorio temporal
    cp -r "$TEMPLATES_DIR/$TYPE_PARAM/." "$TEMP_DIR"
    
    # Reemplazar nombre en archivos y renombrarlos
    for file in $(find "$TEMP_DIR" -type f); do
        # Reemplazar contenido del archivo
        if command -v sed >/dev/null 2>&1; then
            # Usar sed si está disponible
            sed -i.bak "s/\$FILE_NAME/$NAME/g" "$file" 2>/dev/null || {
                # Si sed -i falla, usar método alternativo
                sed "s/\$FILE_NAME/$NAME/g" "$file" > "$file.tmp" && mv "$file.tmp" "$file"
            }
            # Limpiar archivos de backup de sed si existen
            [ -f "$file.bak" ] && rm -f "$file.bak"
        else
            # Método alternativo usando awk si sed no está disponible
            awk "{gsub(/\\\$FILE_NAME/, \"$NAME\"); print}" "$file" > "$file.tmp" && mv "$file.tmp" "$file"
        fi
        
        # Renombrar archivo
        local filename=$(basename "$file")
        local dirname=$(dirname "$file")
        local new_filename="${filename//\$FILE_NAME/$NAME}"
        
        if [ "$filename" != "$new_filename" ]; then
            mv "$file" "$dirname/$new_filename"
        fi
    done

    # Mover archivos al destino
    if [ "$(ls -A "$TEMP_DIR" 2>/dev/null)" ]; then
        mv "$TEMP_DIR"/* "$DESTINATION" 2>/dev/null
    fi
}

# Determinar si crear carpeta basado en configuración y parámetros
CREATE_FOLDER_FINAL="$CREATE_FOLDER"
if [ "$NO_FOLDER" = true ]; then
    CREATE_FOLDER_FINAL=false
fi

# Crear estructura según el tipo
if [ "$CREATE_FOLDER_FINAL" = false ]; then
    DEST_PATH="$OUTPUT_DIR"
else
    DEST_PATH="$OUTPUT_DIR/$NAME"
    mkdir -p "$DEST_PATH"
fi

# Verificar que el directorio de destino es válido
if [ ! -d "$DEST_PATH" ]; then
    echo "Error: Cannot create destination directory: $DEST_PATH"
    rm -rf "$TEMP_DIR"
    exit 1
fi

echo "Generating $TYPE '$NAME'..."

# Copiar y mover archivos al destino
copy_template "$TYPE" "$DEST_PATH"

# Limpiar directorio temporal
rm -rf "$TEMP_DIR"

echo "✅ $TYPE '$NAME' generated successfully in $DEST_PATH"

# Mostrar archivos generados
if [ -d "$DEST_PATH" ]; then
    echo "Files created:"
    find "$DEST_PATH" -maxdepth 1 -type f -exec basename {} \; | sed 's/^/  - /'
fi