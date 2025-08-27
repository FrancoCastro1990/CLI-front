#!/bin/bash

# Path to templates
TEMPLATE_PATH="$HOME/.cli-template"

# Function to show help
show_help() {
  echo "Usage: $0 [name] --type [component|hook|service|context] [--no-folder]"
  echo
  echo "Generates a component, hook, service or context."
  echo
  echo "  name           The name of the component, hook, service or context to generate."
  echo "  --type         The type of structure to generate: component, hook, service or context."
  echo "  --no-folder    (Optional) Generate the file without creating a folder."
}

# Check if a name was provided
if [ -z "$1" ]; then
  echo "Error: No name was provided."
  show_help
  exit 1
fi

# Check if type was provided
if [ -z "$3" ]; then
  echo "Error: No type was provided."
  show_help
  exit 1
fi

# Variables
NAME=$1
TYPE=$3
NO_FOLDER=false
CURRENT_DIR=$(pwd)
TEMP_DIR=$(mktemp -d)

# Check if --no-folder option was provided
if [[ "$*" == *"--no-folder"* ]]; then
  NO_FOLDER=true
fi

# Function to copy templates, rename and move
copy_template() {
  local TYPE_PARAM=$1
  local DESTINATION=$2

  # Copy template files to temporary directory
  cp -r "$TEMPLATE_PATH/$TYPE_PARAM/." "$TEMP_DIR"
  
  # Replace name within files and rename them without duplicating
  for file in $(find "$TEMP_DIR" -type f); do
    # Replace content within the file
    sed -i "s/\$FILE_NAME/$NAME/g" "$file"
    
    # Rename file according to type
    if [[ "$TYPE" = "context" && "$file" =~ (Provider|Context) ]]; then
      # For Context.tsx, it becomes UserContext.tsx
      new_file_name="${file//Context/${NAME}Context}"
      # For ContextProvider.tsx, it becomes UserProvider.tsx
      new_file_name="${new_file_name//Provider/${NAME}Provider}"
    elif [[ "$TYPE" = "hook" && "$file" =~ (Hook) ]]; then
      # For Hook.ts, add "use" before the name, like useUser.ts
      new_file_name="${file//Hook/use$NAME}"
    elif [[ "$file" =~ (Component|Service) ]]; then
      # For other types, rename using the name passed as argument
      new_file_name="${file//Component/$NAME}"
      new_file_name="${new_file_name//Service/$NAME}"
    else
      new_file_name="$file"
    fi

    # Avoid overwriting if destination file already exists
    counter=1
    while [ -e "$new_file_name" ]; do
      new_file_name="${file%.*}_$counter.${file##*.}"
      ((counter++))
    done

    mv "$file" "$new_file_name"
  done

  # Move files from temporary directory to destination
  mv "$TEMP_DIR"/* "$DESTINATION"
}

if [ "$TYPE" = "component" ]; then
  echo "Creating component..."
elif [ "$TYPE" = "hook" ]; then
  echo "Creating hook..."
elif [ "$TYPE" = "service" ]; then
  echo "Creating service..."
elif [ "$TYPE" = "context" ]; then
  echo "Creating context..."
else
  echo "Error: Unknown type. Use 'component', 'hook', 'service' or 'context'."
  show_help
  exit 1
fi

# Create structure according to type
if [ "$NO_FOLDER" = true ]; then
  DEST_PATH="$CURRENT_DIR"
else
  DEST_PATH="$CURRENT_DIR/$NAME"
  mkdir -p "$DEST_PATH"
fi

# Copy and move files to destination
copy_template "$TYPE" "$DEST_PATH"

# Clean temporary directory
rm -rf "$TEMP_DIR"

echo "$TYPE $NAME generated successfully in $DEST_PATH"
