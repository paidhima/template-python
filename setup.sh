#!/bin/bash

# setup.sh - Post-clone setup script
# Usage: ./setup.sh [python|powershell|both]

set -e

PROJECT_NAME=$(basename "$(pwd)")
SETUP_TYPE=${1:-"both"}

echo "🚀 Setting up $PROJECT_NAME ($SETUP_TYPE)"

# Ensure .copilot-instructions.md exists
if [ ! -f ".copilot-instructions.md" ]; then
    echo "⚠️  .copilot-instructions.md not found. Creating default..."
    if [ "$SETUP_TYPE" = "python" ] || [ "$SETUP_TYPE" = "both" ]; then
        cat > .copilot-instructions.md << 'EOF'
# Project Context
This is a Python project using pytest, mypy (strict), black, and ruff.
See copilot-config/standards/conventions.md for full standards.

## Development Workflow
- Run tests: `pytest tests/ -xvs`
- Type check: `mypy src/ --strict`
- Format: `black src/ tests/`
- Lint: `ruff check src/ tests/`

## Completion Criteria
- [ ] All mypy --strict checks pass
- [ ] All tests pass
- [ ] Code formatted with black
- [ ] No ruff violations
- [ ] Docstrings in Google style
EOF
    fi
fi

# Create base directories if missing
echo "📁 Creating directory structure..."
if [ "$SETUP_TYPE" = "python" ] || [ "$SETUP_TYPE" = "both" ]; then
    mkdir -p src/"$PROJECT_NAME" tests
    touch src/"$PROJECT_NAME"/__init__.py tests/conftest.py 2>/dev/null || true
fi

if [ "$SETUP_TYPE" = "powershell" ] || [ "$SETUP_TYPE" = "both" ]; then
    mkdir -p "src/$PROJECT_NAME/Public" "src/$PROJECT_NAME/Private" tests/Public 2>/dev/null || true
fi

# Create/update .gitignore
echo "🔧 Updating .gitignore..."
if [ ! -f ".gitignore" ]; then
    cat > .gitignore << 'EOF'
# Python
__pycache__/
*.py[cod]
*.egg-info/
.venv/
venv/
.pytest_cache/
.coverage
htmlcov/

# PowerShell
*.psd1.bak
*.psm1.zip

# IDE
.vscode/
.idea/
*.swp

# OS
.DS_Store
Thumbs.db
EOF
fi

# Python setup
if [ "$SETUP_TYPE" = "python" ] || [ "$SETUP_TYPE" = "both" ]; then
    echo "🐍 Python environment setup..."
    if [ ! -d ".venv" ]; then
        python3 -m venv .venv
        echo "✅ Created .venv"
    fi
    
    # Suggest activation
    echo ""
    echo "📌 Activate virtual environment:"
    echo "   source .venv/bin/activate  # macOS/Linux"
    echo "   .venv\\Scripts\\Activate.ps1  # Windows PowerShell"
    echo ""
    echo "📌 Install dev dependencies:"
    echo "   pip install -e \".[dev]\" 2>/dev/null || pip install pytest mypy black ruff"
    echo ""
fi

# PowerShell setup
if [ "$SETUP_TYPE" = "powershell" ] || [ "$SETUP_TYPE" = "both" ]; then
    echo "🔷 PowerShell environment setup..."
    echo ""
    echo "📌 Install PSScriptAnalyzer and Pester:"
    echo "   Install-Module -Name PSScriptAnalyzer -Force"
    echo "   Install-Module -Name Pester -MinimumVersion 5.0 -Force"
    echo ""
fi

# Create GitHub Actions workflows
if [ ! -d ".github/workflows" ]; then
    echo "🔄 Setting up GitHub Actions..."
    mkdir -p .github/workflows
    cat > .github/workflows/validate-on-demand.yml << 'EOF'
name: Validate Project (On-Demand)
on:
  workflow_dispatch:
jobs:
  validate:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Check project setup
        run: echo "✅ Project structure initialized. See copilot-config for validation details."
EOF
fi

echo ""
echo "✅ Setup complete for $PROJECT_NAME!"
echo ""
echo "📖 Next steps:"
echo "1. Read copilot-config/standards/conventions.md"
echo "2. Copy .copilot-instructions.md from copilot-config/project-templates/"
echo "3. Update pyproject.toml or .psd1 with project details"
echo "4. Create README.md"
echo "5. Push to GitHub: git push origin main"
