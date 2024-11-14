#!/bin/bash

# Ruta a las plantillas
TEMPLATE_PATH="$HOME/.cli-template"

# Función para mostrar ayuda
mostrar_ayuda() {
  echo "Uso: $0 [nombre] --type [component|hook|service|context] [--no-folder]"
  echo
  echo "Genera un componente, hook, service o context."
  echo
  echo "  nombre         El nombre del componente, hook, service o context a generar."
  echo "  --type         El tipo de estructura a generar: component, hook, service o context."
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
TEMP_DIR=$(mktemp -d)

# Comprobar si la opción --no-folder fue proporcionada
if [[ "$*" == *"--no-folder"* ]]; then
  NO_FOLDER=true
fi

# Función para copiar plantillas, renombrar y mover
copiar_plantilla() {
  local TIPO=$1
  local DESTINO=$2

  # Copiar archivos de la plantilla al directorio temporal
  cp -r "$TEMPLATE_PATH/$TIPO/." "$TEMP_DIR"
  
  # Reemplazar el nombre dentro de los archivos y renombrarlos sin duplicar
  for file in $(find "$TEMP_DIR" -type f); do
    # Reemplazar el contenido dentro del archivo
    sed -i "s/\$FILE_NAME/$NAME/g" "$file"
    
    # Renombrar archivo según el tipo
    if [[ "$TYPE" = "context" && "$file" =~ (Provider|Context) ]]; then
      # Para Context.tsx, se convierte en UserContext.tsx
      new_file_name="${file//Context/${NAME}Context}"
      # Para ContextProvider.tsx, se convierte en UserProvider.tsx
      new_file_name="${new_file_name//Provider/${NAME}Provider}"
    elif [[ "$TYPE" = "hook" && "$file" =~ (Hook) ]]; then
      # Para Hook.ts, agregar "use" delante del nombre, como useUser.ts
      new_file_name="${file//Hook/use$NAME}"
    elif [[ "$file" =~ (Component|Service) ]]; then
      # Para otros tipos, se renombra usando el nombre pasado como argumento
      new_file_name="${file//Component/$NAME}"
      new_file_name="${new_file_name//Service/$NAME}"
    else
      new_file_name="$file"
    fi

    # Evitar sobrescritura si el archivo de destino ya existe
    counter=1
    while [ -e "$new_file_name" ]; do
      new_file_name="${file%.*}_$counter.${file##*.}"
      ((counter++))
    done

    mv "$file" "$new_file_name"
  done

  # Mover archivos del directorio temporal al destino
  mv "$TEMP_DIR"/* "$DESTINO"
}

if [ "$TYPE" = "component" ]; then
  echo "Creando componente..."
elif [ "$TYPE" = "hook" ]; then
  echo "Creando hook..."
elif [ "$TYPE" = "service" ]; then
  echo "Creando service..."
elif [ "$TYPE" = "context" ]; then
  echo "Creando context..."
else
  echo "Error: Tipo desconocido. Usa 'component', 'hook', 'service' o 'context'."
  mostrar_ayuda
  exit 1
fi

# Crear estructura según el tipo
if [ "$NO_FOLDER" = true ]; then
  DEST_PATH="$CURRENT_DIR"
else
  DEST_PATH="$CURRENT_DIR/$NAME"
  mkdir -p "$DEST_PATH"
fi

# Copiar y mover archivos al destino
copiar_plantilla "$TYPE" "$DEST_PATH"

# Limpiar el directorio temporal
rm -rf "$TEMP_DIR"

echo "$TYPE $NAME generado exitosamente en $DEST_PATH"
