# CLI Frontend Generator

A command-line tool for quickly generating React components, hooks, services, and contexts with predefined templates.

## Features

- 🚀 **Fast Generation**: Create React components, hooks, services, and contexts in seconds
- 📁 **Flexible Structure**: Generate files with or without folder structure
- 🎨 **Customizable Templates**: Modify templates to match your project's conventions
- 🔧 **TypeScript Support**: Built-in TypeScript templates with proper typing
- 🧪 **Test Files Included**: Automatically generates test files for components and hooks
- 📦 **SCSS Support**: Includes SCSS module files for components

## Installation

### Quick Install

```bash
curl -fsSL https://raw.githubusercontent.com/yourusername/CLI-front/main/install.sh | bash
```

### Manual Install

1. Clone this repository:
```bash
git clone https://github.com/FrancoCastro1990/CLI-front.git
cd CLI-front
```

2. Run the installation script:
```bash
chmod +x install.sh
./install.sh
```

3. Restart your terminal or source your shell configuration:
```bash
source ~/.bashrc  # or ~/.zshrc
```

## Usage

### Basic Syntax

```bash
cli-frontend [name] --type [component|hook|service|context] [--no-folder]
```

### Parameters

- `name`: The name of the component, hook, service, or context to generate
- `--type`: The type of structure to generate (required)
  - `component`: React functional component with TypeScript
  - `hook`: Custom React hook
  - `service`: Service class with interface
  - `context`: React context with provider
- `--no-folder`: (Optional) Generate files without creating a folder

### Examples

#### Generate a Component
```bash
# Creates a Button component in ./Button/ folder
cli-frontend Button --type component

# Creates component files directly in current directory
cli-frontend Modal --type component --no-folder
```

#### Generate a Hook
```bash
# Creates a useAuth hook in ./useAuth/ folder
cli-frontend Auth --type hook

# Creates hook file directly in current directory
cli-frontend Counter --type hook --no-folder
```

#### Generate a Service
```bash
# Creates an API service in ./ApiService/ folder
cli-frontend Api --type service
```

#### Generate a Context
```bash
# Creates UserContext with provider in ./User/ folder
cli-frontend User --type context
```

## Generated File Structure

### Component
```
Button/
├── Button.tsx          # Main component file
├── Button.module.scss  # SCSS module for styling
└── Button.spec.tsx     # Test file
```

### Hook
```
useAuth/
├── useAuth.ts          # Hook implementation
└── useAuth.test.ts     # Hook tests
```

### Service
```
ApiService/
└── ApiService.ts       # Service class with interface
```

### Context
```
User/
├── UserContext.tsx     # Context definition
└── UserProvider.tsx    # Context provider
```

## Template Files

The generator uses templates located in `~/.cli-template/`. You can customize these templates to match your project's conventions:

- `component/`: React component templates
- `hook/`: Custom hook templates  
- `service/`: Service class templates
- `context/`: React context templates

### Customizing Templates

1. Navigate to the template directory:
```bash
cd ~/.cli-template
```

2. Edit the template files as needed. Use `$FILE_NAME` as a placeholder for the generated name.

3. The generator will automatically replace `$FILE_NAME` with your specified name.

## Template Variables

- `$FILE_NAME`: Replaced with the name you provide to the CLI

## File Naming Conventions

- **Components**: `ComponentName.tsx`
- **Hooks**: `useHookName.ts`  
- **Services**: `ServiceName.ts`
- **Contexts**: `ContextName.tsx` and `ContextNameProvider.tsx`

## Requirements

- Bash shell (Linux, macOS, WSL on Windows)
- Node.js and npm (for React projects)

## Troubleshooting

### Command Not Found
If you get a "command not found" error:
1. Ensure `~/.local/bin` is in your PATH
2. Restart your terminal
3. Try running: `source ~/.bashrc` (or `~/.zshrc`)

### Permission Denied
If you get permission errors:
```bash
chmod +x ~/.local/bin/cli-frontend
```

### Templates Not Found
If templates are missing:
1. Check if `~/.cli-template` directory exists
2. Re-run the installation script
3. Manually copy templates from the project directory

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Support

If you encounter any issues or have questions:

1. Check the [Issues](https://github.com/FrancoCastro1990/CLI-front.git/issues) page
2. Create a new issue if your problem isn't already reported
3. Provide details about your environment and the error you're experiencing

---

**Happy coding! 🚀**