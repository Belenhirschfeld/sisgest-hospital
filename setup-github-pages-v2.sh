#!/bin/bash

# SisGest GitHub Pages Setup Script - Versión Segura
# Este script configura el repositorio git y sube a GitHub Pages sin exponer credenciales

set -e

PROJECT_DIR="$HOME/stock hospital"
REPO_NAME="sisgest-hospital"
GITHUB_USERNAME="belenhirschfeld"

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
    # Asegurarse que la configuración local está correcta
    git config user.name "Belén Hirschfeld"
    git config user.email "belenhirschfeld31@gmail.com"
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
git add -A

# Crear commit (sin exponer credenciales)
echo "💾 Creando commit inicial..."
if git diff --cached --quiet; then
    echo "⚠️  No hay cambios nuevos para hacer commit"
else
    git commit -m "feat: Initial SisGest hospital dashboard deployment

- Add complete hospital inventory management system
- Implement 3-level hierarchical categorization (Tipo > Categoría > Subcategoría)
- Configure dynamic filters by product type and status
- Enable category view with organized product display
- Set up history tracking for all inventory movements
- Ready for GitHub Pages deployment

Demo Credentials:
- Username: demo
- Password: demo123

This dashboard provides real-time inventory tracking for hospital supplies
with automatic alerts for low stock and upcoming expiration dates."
fi

# Agregar remote de GitHub (usando HTTPS sin token en URL)
echo "🔗 Configurando GitHub remote..."
REMOTE_URL="https://github.com/${GITHUB_USERNAME}/${REPO_NAME}.git"

# Remover remote si existe
git remote remove origin 2>/dev/null || true

# Agregar nuevo remote
git remote add origin "$REMOTE_URL"

# Hacer push al main branch
echo "📤 Haciendo push a GitHub..."
echo "ℹ️  Si se pide credenciales, usa tu GitHub Personal Access Token"
git branch -M main
git push -u origin main

if [ $? -eq 0 ]; then
    echo ""
    echo "✅ ¡Configuración completada exitosamente!"
    echo ""
    echo "📱 Tu dashboard estará disponible en:"
    echo "🌐 https://${GITHUB_USERNAME}.github.io/${REPO_NAME}/"
    echo ""
    echo "⏰ Tarda 1-2 minutos en activarse la primera vez"
    echo ""
    echo "🔑 GitHub Pages debería activarse automáticamente"
    echo "   Si no funciona en 2 minutos, ve a:"
    echo "   https://github.com/${GITHUB_USERNAME}/${REPO_NAME}/settings/pages"
    echo ""
    echo "📋 Verifica que esté en: Deploy from a branch → main branch → / (root)"
else
    echo ""
    echo "⚠️  Hubo un problema con el push"
    echo "Verifica tu conexión a internet y tus credenciales de GitHub"
fi
