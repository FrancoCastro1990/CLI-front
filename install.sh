#!/bin/bash

# CLI Frontend Generator - Enhanced Installation Script
# This script installs the CLI tool for generating React components, hooks, services, and contexts
# with improved configuration system and modular template support

# Colores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuración
CLI_NAME="cli-frontend"
INSTALL_DIR="$HOME/.local/bin"
TEMPLATE_DIR="$HOME/.cli-template"
SCRIPT_NAME="CLI_front.sh"
CONFIG_NAME="cli-frontend.conf"

echo -e "${BLUE}=== CLI Frontend Generator Installation ===${NC}"
echo

# Verificar si el script existe
if [ ! -f "$SCRIPT_NAME" ]; then
    echo -e "${RED}Error: $SCRIPT_NAME not found in current directory${NC}"
    echo "Please run this script from the project directory"
    exit 1
fi

# Crear directorios si no existen
echo -e "${YELLOW}Creating directories...${NC}"
mkdir -p "$INSTALL_DIR"
mkdir -p "$TEMPLATE_DIR"

# Copiar script CLI
echo -e "${YELLOW}Installing CLI script...${NC}"
cp "$SCRIPT_NAME" "$INSTALL_DIR/$CLI_NAME"
chmod +x "$INSTALL_DIR/$CLI_NAME"

# Crear archivo de configuración por defecto si no existe
if [ ! -f "$HOME/.$CONFIG_NAME" ]; then
    echo -e "${YELLOW}Creating default configuration...${NC}"
    cat > "$HOME/.$CONFIG_NAME" << EOL
# CLI Frontend Generator Configuration
# This file uses INI-like format for easy configuration

# General settings
default_type=component
create_folder=true
enable_hooks=true

# Paths configuration
templates_dir=~/.cli-template
output_dir=./src

# Available template types are determined by the directories in templates_dir
# You can add new templates by creating new directories in templates_dir
EOL
    echo -e "${GREEN}Configuration file created at $HOME/.$CONFIG_NAME${NC}"
else
    echo -e "${GREEN}Configuration file already exists at $HOME/.$CONFIG_NAME${NC}"
fi

# Copiar plantillas
echo -e "${YELLOW}Installing templates...${NC}"
if [ -d "cli-template" ]; then
    cp -r cli-template/* "$TEMPLATE_DIR/"
    echo -e "${GREEN}Templates copied to $TEMPLATE_DIR${NC}"
else
    echo -e "${RED}Warning: cli-template directory not found${NC}"
fi

# Verificar si ~/.local/bin está en PATH
if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
    echo -e "${YELLOW}Adding $HOME/.local/bin to PATH...${NC}"
    
    # Añadir a .bashrc si existe
    if [ -f "$HOME/.bashrc" ]; then
        echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.bashrc"
        echo -e "${GREEN}Added to ~/.bashrc${NC}"
    fi
    
    # Añadir a .zshrc si existe
    if [ -f "$HOME/.zshrc" ]; then
        echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.zshrc"
        echo -e "${GREEN}Added to ~/.zshrc${NC}"
    fi
    
    # Añadir a .profile como fallback
    if [ -f "$HOME/.profile" ]; then
        echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.profile"
        echo -e "${GREEN}Added to ~/.profile${NC}"
    fi
    
    echo -e "${YELLOW}Please restart your terminal or run: source ~/.bashrc (or ~/.zshrc)${NC}"
else
    echo -e "${GREEN}PATH already includes $HOME/.local/bin${NC}"
fi

# Mostrar templates disponibles
echo -e "${YELLOW}Available templates:${NC}"
if [ -d "$TEMPLATE_DIR" ] && [ "$(ls -A "$TEMPLATE_DIR" 2>/dev/null)" ]; then
    for template in "$TEMPLATE_DIR"/*; do
        if [ -d "$template" ]; then
            template_name=$(basename "$template")
            echo -e "${BLUE}  - $template_name${NC}"
        fi
    done
else
    echo -e "${RED}  No templates found${NC}"
fi

echo
echo -e "${GREEN}=== Installation Complete! ===${NC}"
echo -e "${BLUE}Usage:${NC}"
echo -e "  $CLI_NAME [name] --type [component|hook|service|context] [--no-folder] [--config path/to/config.conf]"
echo
echo -e "${BLUE}Examples:${NC}"
echo -e "  $CLI_NAME Button --type component"
echo -e "  $CLI_NAME useAuth --type hook"
echo -e "  $CLI_NAME AuthService --type service"
echo -e "  $CLI_NAME UserContext --type context"
echo -e "  $CLI_NAME Modal --type component --no-folder"
echo -e "  $CLI_NAME Modal --type component --config ./my-config.conf"
echo
echo -e "${BLUE}Advanced Usage:${NC}"
echo -e "  # Use default configuration (type defaults to 'component')"
echo -e "  $CLI_NAME Button"
echo -e "  "
echo -e "  # Custom project configuration"
echo -e "  $CLI_NAME LoginPage --config ./project-config.conf"
echo -e "  "
echo -e "  # Generate in current directory without folder"
echo -e "  $CLI_NAME Utils --type service --no-folder"
echo
echo -e "${BLUE}Files installed:${NC}"
echo -e "  CLI script: $INSTALL_DIR/$CLI_NAME"
echo -e "  Templates: $TEMPLATE_DIR"
echo -e "  Configuration: $HOME/.$CONFIG_NAME"
echo
echo -e "${YELLOW}Customization:${NC}"
echo -e "  • Edit $HOME/.$CONFIG_NAME to customize default behavior"
echo -e "  • Add new templates by creating directories in $TEMPLATE_DIR"
echo -e "  • Use \$FILE_NAME in template files as placeholder for the component name"
echo -e "  • Create project-specific configs for different setups"
echo
echo -e "${GREEN}🚀 Ready to generate your components, hooks, services, and contexts!${NC}"