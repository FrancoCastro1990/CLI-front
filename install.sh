#!/bin/bash

# CLI Frontend Generator - Installation Script
# This script installs the CLI tool for generating React components, hooks, services, and contexts

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
CLI_NAME="cli-frontend"
INSTALL_DIR="$HOME/.local/bin"
TEMPLATE_DIR="$HOME/.cli-template"
SCRIPT_NAME="CLI_front.sh"

echo -e "${BLUE}=== CLI Frontend Generator Installation ===${NC}"
echo

# Check if script exists
if [ ! -f "$SCRIPT_NAME" ]; then
    echo -e "${RED}Error: $SCRIPT_NAME not found in current directory${NC}"
    echo "Please run this script from the project directory"
    exit 1
fi

# Create directories if they don't exist
echo -e "${YELLOW}Creating directories...${NC}"
mkdir -p "$INSTALL_DIR"
mkdir -p "$TEMPLATE_DIR"

# Copy CLI script
echo -e "${YELLOW}Installing CLI script...${NC}"
cp "$SCRIPT_NAME" "$INSTALL_DIR/$CLI_NAME"
chmod +x "$INSTALL_DIR/$CLI_NAME"

# Copy templates
echo -e "${YELLOW}Installing templates...${NC}"
if [ -d "cli-template" ]; then
    cp -r cli-template/* "$TEMPLATE_DIR/"
    echo -e "${GREEN}Templates copied to $TEMPLATE_DIR${NC}"
else
    echo -e "${RED}Warning: cli-template directory not found${NC}"
fi

# Check if ~/.local/bin is in PATH
if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
    echo -e "${YELLOW}Adding $HOME/.local/bin to PATH...${NC}"
    
    # Add to .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
        echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.bashrc"
        echo -e "${GREEN}Added to ~/.bashrc${NC}"
    fi
    
    # Add to .zshrc if it exists
    if [ -f "$HOME/.zshrc" ]; then
        echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.zshrc"
        echo -e "${GREEN}Added to ~/.zshrc${NC}"
    fi
    
    # Add to .profile as fallback
    if [ -f "$HOME/.profile" ]; then
        echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.profile"
        echo -e "${GREEN}Added to ~/.profile${NC}"
    fi
    
    echo -e "${YELLOW}Please restart your terminal or run: source ~/.bashrc (or ~/.zshrc)${NC}"
else
    echo -e "${GREEN}PATH already includes $HOME/.local/bin${NC}"
fi

echo
echo -e "${GREEN}=== Installation Complete! ===${NC}"
echo -e "${BLUE}Usage:${NC}"
echo -e "  $CLI_NAME [name] --type [component|hook|service|context] [--no-folder]"
echo
echo -e "${BLUE}Examples:${NC}"
echo -e "  $CLI_NAME Button --type component"
echo -e "  $CLI_NAME useAuth --type hook"
echo -e "  $CLI_NAME AuthService --type service"
echo -e "  $CLI_NAME UserContext --type context"
echo -e "  $CLI_NAME Modal --type component --no-folder"
echo
echo -e "${BLUE}Files installed:${NC}"
echo -e "  CLI script: $INSTALL_DIR/$CLI_NAME"
echo -e "  Templates: $TEMPLATE_DIR"
echo