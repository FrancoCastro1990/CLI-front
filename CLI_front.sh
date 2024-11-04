#!/bin/bash

# Ruta a las plantillas
TEMPLATE_PATH="$HOME/.cli-template"

# Función para mostrar ayuda
mostrar_ayuda() {
  echo "Uso: $0 [nombre] --type [component|hook|service] [--no-folder]"
  echo
  echo "Genera un componente, hook o service."
  echo
  echo "  nombre         El nombre del componente, hook o service a generar."
  echo "  --type         El tipo de estructura a generar: component, hook o service."
  echo "  --no-folder    (Opcional) Genera el archivo sin crear una carpeta."
}

# Verificar si se proporcionó un nombre
if [ -z "$1" ]; then
  echo "Error: No se proporcionó un nombre."
  mostrar_ayuda
  exit 1
fi

# Verificar si se proporcionó el tipo
if [ -z "$3" ]; then
  echo "Error: No se proporcionó el tipo."
  mostrar_ayuda
  exit 1
fi

# Variables
NAME=$1
TYPE=$3
NO_FOLDER=false
CURRENT_DIR=$(pwd)

# Comprobar si la opción --no-folder fue proporcionada
if [[ "$*" == *"--no-folder"* ]]; then
  NO_FOLDER=true
fi

# Función para copiar plantillas y renombrar
copiar_plantilla() {
  local TIPO=$1
  local DESTINO=$2

  # Copiar archivos de la plantilla al destino
  cp -r "$TEMPLATE_PATH/$TIPO/." "$DESTINO"
  
  # Reemplazar el nombre dentro de los archivos y renombrarlos
  for file in $(find "$DESTINO" -type f); do
    # Reemplazar el contenido dentro del archivo
    sed -i "s/\$FILE_NAME/$NAME/g" "$file"
    
    # Renombrar archivo si contiene Component, Hook o Service en el nombre
    new_file_name=$(echo "$file" | sed -E "s/(Component|Hook|Service)/$NAME/")
    if [ "$file" != "$new_file_name" ]; then
      mv "$file" "$new_file_name"
    fi
  done
}

# Crear estructura según el tipo
case $TYPE in
  component)
    if [ "$NO_FOLDER" = true ]; then
      DEST_PATH="$CURRENT_DIR"
    else
      DEST_PATH="$CURRENT_DIR/$NAME"
      mkdir -p "$DEST_PATH"
    fi
    copiar_plantilla "component" "$DEST_PATH"
    ;;
  hook)
    if [ "$NO_FOLDER" = true ]; then
      DEST_PATH="$CURRENT_DIR"
    else
      DEST_PATH="$CURRENT_DIR/$NAME"
      mkdir -p "$DEST_PATH"
    fi
    copiar_plantilla "hook" "$DEST_PATH"
    ;;
  service)
    DEST_PATH="$CURRENT_DIR"
    copiar_plantilla "service" "$DEST_PATH"
    ;;
  *)
    echo "Error: Tipo desconocido. Usa 'component', 'hook' o 'service'."
    mostrar_ayuda
    exit 1
    ;;
esac

echo "$TYPE $NAME generado exitosamente en $DEST_PATH"
