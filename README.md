# CLI Frontend Generator

Un generador de línea de comandos avanzado para crear componentes React, hooks personalizados, servicios y contextos con sistema de configuración modular.

## ✨ Características

- 🔧 **Sistema de configuración flexible** con archivos `.conf` 
- 🎨 **Templates modulares** fáciles de personalizar y extender
- 📁 **Generación inteligente** de estructuras de archivos
- 🎯 **Soporte completo** para TypeScript y SCSS
- 🧪 **Templates de pruebas** incluidos
- ⚡ **Configuración por proyecto** personalizable
- 🚀 **Fácil instalación** con script automatizado

## 🚀 Instalación Rápida

```bash
# Clonar el repositorio
git clone https://github.com/FrancoCastro1990/CLI-front.git
cd CLI-front

# Ejecutar instalación
chmod +x install.sh
./install.sh

# Reiniciar terminal o recargar profile
source ~/.bashrc  # o ~/.zshrc
```

## 📋 Uso

### Comandos Básicos

```bash
# Generar con configuración por defecto (tipo por defecto: component)
cli-frontend Button

# Especificar tipo de template
cli-frontend Button --type component
cli-frontend useAuth --type hook
cli-frontend AuthService --type service
cli-frontend UserContext --type context
cli-frontend HomePage --type page

# Generar sin crear carpeta contenedora
cli-frontend Modal --type component --no-folder

# Usar configuración personalizada
cli-frontend LoginPage --config ./my-config.conf
```

### Opciones Disponibles

| Opción | Descripción | Ejemplo |
|--------|-------------|---------|
| `--type` | Tipo de template (component, hook, service, context, page) | `--type component` |
| `--no-folder` | Generar archivos sin carpeta contenedora | `--no-folder` |
| `--config` | Usar archivo de configuración personalizado | `--config ./custom.conf` |
| `--help` | Mostrar ayuda y templates disponibles | `--help` |

## ⚙️ Configuración

### Archivo de Configuración Global

El archivo `~/.cli-frontend.conf` controla el comportamiento por defecto:

```ini
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
```

### Configuración por Proyecto

Crea un archivo de configuración específico para tu proyecto:

```bash
# proyecto-config.conf
default_type=component
create_folder=false
templates_dir=./custom-templates
output_dir=./app/components
```

Úsalo con:
```bash
cli-frontend MyComponent --config ./proyecto-config.conf
```

## 📂 Estructura de Templates

Los templates siguen una estructura modular:

```
~/.cli-template/
├── component/
│   ├── $FILE_NAME.tsx
│   ├── $FILE_NAME.module.scss
│   └── $FILE_NAME.spec.tsx
├── hook/
│   ├── use$FILE_NAME.ts
│   └── use$FILE_NAME.test.ts
├── service/
│   └── $FILE_NAME.ts
├── context/
│   ├── $FILE_NAMEContext.tsx
│   └── $FILE_NAMEProvider.tsx
├── page/
│   ├── $FILE_NAMEPage.tsx
│   ├── $FILE_NAME.module.scss
│   └── $FILE_NAMEPage.spec.tsx
└── custom-template/  # ¡Añade tus propios templates!
    ├── $FILE_NAME.tsx
    └── $FILE_NAME.css
```

### Variables de Template

- `$FILE_NAME`: Se reemplaza con el nombre proporcionado
- Los nombres de archivos también usan `$FILE_NAME` para renombrado automático

## 🎨 Templates Incluidos

### 📦 Component
Genera un componente React completo con:
- Archivo TypeScript (.tsx)
- Estilos SCSS modulares
- Archivo de pruebas con Jest/Testing Library
- Props interface bien estructurada
- Documentación JSDoc

```bash
cli-frontend Button --type component
```

Genera:
```
src/Button/
├── Button.tsx
├── Button.module.scss
└── Button.spec.tsx
```

### 🪝 Hook
Crea un hook personalizado con:
- Lógica de hook base
- Archivo de pruebas con renderHook
- Documentación TypeScript

```bash
cli-frontend useAuth --type hook
```

Genera:
```
src/useAuth/
├── useAuth.ts
└── useAuth.test.ts
```

### 🔧 Service
Genera una clase de servicio con:
- Interface de contrato
- Implementación de clase
- Métodos de ejemplo comentados
- Patrón singleton opcional

```bash
cli-frontend AuthService --type service
```

Genera:
```
src/AuthService/
└── AuthService.ts
```

### 🌐 Context
Crea un contexto React con:
- Definición de contexto
- Provider component
- Hook personalizado incluido
- TypeScript interfaces

```bash
cli-frontend UserContext --type context
```

Genera:
```
src/UserContext/
├── UserContextContext.tsx
└── UserContextProvider.tsx
```

### 📄 Page
Genera una página completa con:
- Componente de página estructurado
- Layout con header, main y footer
- Estilos SCSS modulares
- Archivo de pruebas incluido
- Props interface para configuración

```bash
cli-frontend HomePage --type page
```

Genera:
```
src/HomePage/
├── HomePage.tsx
├── HomePage.module.scss
└── HomePage.spec.tsx
```

## 🔧 Personalización Avanzada

### Añadir Nuevos Templates

1. Crear directorio en `~/.cli-template/`:
```bash
mkdir ~/.cli-template/page
```

2. Añadir archivos de template:
```bash
# ~/.cli-template/page/$FILE_NAME.tsx
import React from 'react';

export const $FILE_NAME: React.FC = () => {
  return (
    <div>
      <h1>$FILE_NAME Page</h1>
    </div>
  );
};
```

3. Usar el nuevo template:
```bash
cli-frontend HomePage --type page
```

### Configuración Múltiple

```bash
# Desarrollo
cli-frontend Component --config ./dev.conf

# Producción  
cli-frontend Component --config ./prod.conf

# Testing
cli-frontend Component --config ./test.conf
```

## 📖 Ejemplos de Uso

### Desarrollo de Componentes
```bash
# Componente principal
cli-frontend Header --type component

# Modal sin carpeta
cli-frontend Modal --type component --no-folder

# Componente con configuración personalizada
cli-frontend Card --type component --config ./ui-config.conf
```

### Hooks y Lógica
```bash
# Hook de autenticación
cli-frontend useAuth --type hook

# Hook para API
cli-frontend useApi --type hook

# Hook de estado local
cli-frontend useLocalStorage --type hook
```

### Servicios y Utilidades
```bash
# Servicio de API
cli-frontend ApiService --type service

# Utilidades de validación
cli-frontend ValidationService --type service
```

### Gestión de Estado
```bash
# Contexto de usuario
cli-frontend UserContext --type context

# Contexto de tema
cli-frontend ThemeContext --type context
```

### Páginas y Layouts
```bash
# Página principal
cli-frontend HomePage --type page

# Página de configuración
cli-frontend SettingsPage --type page

# Página con configuración personalizada
cli-frontend AboutPage --type page --config ./pages-config.conf
```

## 🛠️ Solución de Problemas

### Template no encontrado
```bash
# Verificar templates disponibles
cli-frontend --help

# Verificar directorio de templates
ls ~/.cli-template/
```

### Problema de permisos
```bash
# Dar permisos al script
chmod +x ~/.local/bin/cli-frontend

# Verificar PATH
echo $PATH | grep ".local/bin"
```

### Configuración no funciona
```bash
# Verificar archivo de configuración
cat ~/.cli-frontend.conf

# Usar ruta absoluta
cli-frontend Component --config /path/to/config.conf
```

## 🤝 Contribución

1. Fork el proyecto
2. Crea una rama para tu feature (`git checkout -b feature/amazing-feature`)
3. Commit tus cambios (`git commit -m 'Add amazing feature'`)
4. Push a la rama (`git push origin feature/amazing-feature`)
5. Abre un Pull Request

## 📄 Licencia

Este proyecto está bajo la Licencia MIT - ver el archivo [LICENSE](LICENSE) para más detalles.

## �️ Roadmap

### 📅 Versión Actual (v1.0) ✅
- [x] Sistema de configuración modular con archivos `.conf`
- [x] Templates base: Component, Hook, Service, Context, Page
- [x] Reemplazo inteligente de variables (`$FILE_NAME`)
- [x] Generación con/sin carpetas contenedoras
- [x] Configuración por proyecto personalizable
- [x] Scripts de instalación automatizada
- [x] Soporte completo para TypeScript y SCSS
- [x] Templates de pruebas incluidos
- [x] Validación de templates y directorios
- [x] Documentación completa

### 🚧 Próxima Versión (v1.1) - En Planificación
- [ ] **Templates Adicionales**
  - [ ] Template para Layouts
  - [ ] Template para Custom Hooks avanzados
  - [ ] Template para Providers complejos
  - [ ] Template para Utilities/Helpers
  
- [ ] **Mejoras de CLI**
  - [ ] Modo interactivo con prompts
  - [ ] Autocompletado de comandos
  - [ ] Colores mejorados en output
  - [ ] Progress indicators para operaciones largas

- [ ] **Configuración Avanzada**
  - [ ] Múltiples configuraciones por ambiente
  - [ ] Variables de entorno en configuración
  - [ ] Validación de esquemas de configuración
  - [ ] Configuración global vs proyecto

### 🔮 Versión Futura (v1.2) - Visión a Largo Plazo
- [ ] **Integración con Frameworks**
  - [ ] Soporte para Next.js específico
  - [ ] Templates para Remix
  - [ ] Integración con Vite
  - [ ] Soporte para Astro

- [ ] **Templates Inteligentes**
  - [ ] Detección automática del tipo de proyecto
  - [ ] Sugerencias basadas en estructura existente
  - [ ] Templates adaptativos según dependencias
  - [ ] Integración con package.json

- [ ] **Herramientas de Desarrollo**
  - [ ] Validador de templates
  - [ ] Editor de templates visual
  - [ ] Marketplace de templates comunitarios
  - [ ] Exportación/importación de configuraciones

### 🌟 Versión Ambiciosa (v2.0) - Largo Plazo
- [ ] **CLI Multiplataforma**
  - [ ] Versión en Node.js nativa
  - [ ] Executable binario para Windows/Mac/Linux
  - [ ] Extensión para VS Code
  - [ ] Plugin para IDEs populares

- [ ] **Inteligencia Artificial**
  - [ ] Generación de templates con AI
  - [ ] Sugerencias inteligentes de código
  - [ ] Análisis de patrones de proyecto
  - [ ] Optimización automática de templates

- [ ] **Ecosystem y Comunidad**
  - [ ] Registry de templates públicos
  - [ ] Sistema de ratings y reviews
  - [ ] Contribuciones comunitarias
  - [ ] Templates certificados

### 🎯 Mejoras Continuas
- [ ] **Performance**
  - [ ] Optimización de tiempo de generación
  - [ ] Cache inteligente de templates
  - [ ] Generación paralela de archivos
  - [ ] Compresión de templates

- [ ] **Testing y Calidad**
  - [ ] Suite de tests automatizada
  - [ ] CI/CD pipeline completo
  - [ ] Cobertura de código 100%
  - [ ] Tests de integración multiplataforma

- [ ] **Documentación**
  - [ ] Sitio web interactivo
  - [ ] Video tutoriales
  - [ ] Documentación API completa
  - [ ] Guías de migración

### 💡 Ideas en Evaluación
- [ ] Generación de documentación automática
- [ ] Integración con Storybook
- [ ] Soporte para micro-frontends
- [ ] Templates para testing avanzado (E2E, Visual)
- [ ] Integración con herramientas de design systems
- [ ] Soporte para WebComponents
- [ ] Templates para PWA
- [ ] Generación de schemas GraphQL/REST

### 🤝 Contribuciones de la Comunidad
¿Tienes una idea genial? ¡Nos encantaría escucharla!

- 📧 Crea un issue con tu propuesta
- 🔧 Envía un PR con mejoras
- 💬 Únete a las discusiones
- ⭐ Comparte el proyecto

### 📊 Métricas de Desarrollo
- **Objetivo 2024**: Alcanzar 1000+ usuarios activos
- **Objetivo 2025**: Ecosystem completo con 50+ templates
- **Objetivo a largo plazo**: Herramienta estándar en desarrollo React

---

## �🙏 Agradecimientos

- Inspirado en las mejores prácticas de React y TypeScript
- Templates basados en patrones de la comunidad
- Sistema de configuración flexible para diferentes flujos de trabajo

---

**¡Feliz codificación! 🚀**

*"El mejor momento para plantar un árbol fue hace 20 años. El segundo mejor momento es ahora."* - Proverbio chino