#!/bin/bash

# SisGest GitHub Pages Setup Script
# Este script configura el repositorio git y sube el dashboard a GitHub Pages

set -e

PROJECT_DIR="$HOME/stock hospital"
REPO_NAME="sisgest-hospital"
GITHUB_USERNAME="belenhirschfeld"
GITHUB_TOKEN="REDACTED_TOKEN"

echo "🚀 Iniciando configuración de GitHub Pages para SisGest"
echo "📁 Directorio del proyecto: $PROJECT_DIR"
echo ""

# Verificar que el archivo existe
if [ ! -f "$PROJECT_DIR/index.html" ]; then
    echo "❌ Error: No se encontró el archivo index.html"
    exit 1
fi

cd "$PROJECT_DIR"

# Inicializar git si no está inicializado
if [ ! -d ".git" ]; then
    echo "📝 Inicializando repositorio git..."
    git init
    git config user.name "Belén Hirschfeld"
    git config user.email "belenhirschfeld31@gmail.com"
else
    echo "✅ El repositorio git ya existe"
fi

# Crear .gitignore
echo "📋 Creando .gitignore..."
cat > .gitignore << 'EOF'
.DS_Store
.idea/
.vscode/
*.swp
*.swo
*~
node_modules/
.env
.env.local
EOF

# Agregar archivos
echo "📦 Agregando archivos al repositorio..."
git add .

# Crear commit
echo "💾 Creando commit inicial..."
git commit -m "feat: Initial SisGest hospital dashboard deployment

- Add complete hospital inventory management system
- Implement 3-level hierarchical categorization
- Configure dynamic filters by product type and status
- Enable category view with organized product display
- Set up history tracking for all inventory movements
- Ready for GitHub Pages deployment

Credentials:
- Demo username: demo
- Demo password: demo123" || echo "⚠️  No hay cambios nuevos para hacer commit"

# Agregar remote de GitHub
echo "🔗 Configurando GitHub remote..."
REMOTE_URL="https://${GITHUB_USERNAME}:${GITHUB_TOKEN}@github.com/${GITHUB_USERNAME}/${REPO_NAME}.git"

# Remover remote si existe
git remote remove origin 2>/dev/null || true

# Agregar nuevo remote
git remote add origin "$REMOTE_URL"

# Hacer push al main branch
echo "📤 Haciendo push a GitHub..."
git branch -M main
git push -u origin main

echo ""
echo "✅ ¡Configuración completada!"
echo ""
echo "📱 Tu dashboard estará disponible en:"
echo "🌐 https://belenhirschfeld.github.io/sisgest-hospital/"
echo ""
echo "⚠️  Nota: GitHub Pages tarda entre 1-2 minutos en activarse"
echo "📍 Si el link aún no funciona, espera un momento y recarga."
echo ""
echo "Para habilitar GitHub Pages (si no está habilitado):"
echo "1. Ve a: https://github.com/belenhirschfeld/sisgest-hospital/settings/pages"
echo "2. En 'Source', selecciona: Deploy from a branch"
echo "3. Branch: main, Folder: / (root)"
echo "4. Click en 'Save'"
