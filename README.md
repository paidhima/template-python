# Python Project Template

Created from [copilot-config](https://github.com/paidhima/copilot-config).

This is a minimal Python project scaffold with all standards pre-configured.

## Quick Start

### Option 1: From This Template (Recommended)
```bash
gh repo create my-project --template paidhima/template-python --clone --private
cd my-project
./setup.sh python
source .venv/bin/activate
pip install -e ".[dev]"
```

### Option 2: Minimal Setup
```bash
python3 -m venv .venv
source .venv/bin/activate
pip install -e ".[dev]"
```

## Project Structure

```
my-project/
├── src/
│   └── my_project/           # Main package
│       ├── __init__.py
│       └── core.py
├── tests/
│   ├── __init__.py
│   ├── conftest.py           # pytest fixtures
│   └── test_core.py
├── pyproject.toml            # Dependencies and tool config
├── .copilot-instructions.md  # Copilot standards
├── README.md
└── .gitignore
```

## Development Workflow

```bash
# Format code
black src/ tests/

# Type check
mypy src/ --strict

# Lint
ruff check src/ tests/ --fix

# Test
pytest tests/ -xvs --cov=src/

# All checks
black --check src/ tests/ && mypy src/ --strict && ruff check src/ tests/ && pytest tests/
```

## Standards

See [Development Standards](https://github.com/paidhima/copilot-config/blob/main/standards/conventions.md) for:
- Code style (Google docstrings, black, ruff)
- Testing requirements (pytest)
- Type checking (mypy --strict)
- Branching and PR workflow
- Release versioning

## Copilot Integration

The `.copilot-instructions.md` file tells GitHub Copilot about your project standards. It's automatically recognized by VS Code and Copilot Chat.

**Features**:
- Copilot generates code matching your style (Google docstrings, type hints, etc.)
- Copilot suggests fixes when reviewing code
- Copilot respects your testing and linting requirements

## Next Steps

1. Update `pyproject.toml` with your project name, description, and author
2. Update `__init__.py` with `__version__`
3. Create your first module in `src/my_project/`
4. Add tests in `tests/`
5. Follow [Copilot Config Bootstrap Checklist](https://github.com/paidhima/copilot-config/blob/main/checklists/new-project-bootstrap.md) for detailed guidance

## Support

Questions? See:
- [Copilot Config Repository](https://github.com/paidhima/copilot-config)
- [Quick Reference](https://github.com/paidhima/copilot-config/blob/main/docs/QUICK-REFERENCE.md)
- [Development Standards](https://github.com/paidhima/copilot-config/blob/main/standards/conventions.md)
