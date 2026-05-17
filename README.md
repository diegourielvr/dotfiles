# Neovim Config

## Requirements

- `tree-sitter-cli` (nvim-treesitter)
- C complier (ej. gcc) (tree-sitter-cli)

## Config for Windows

Crear variable de entorno `CC` para indicar el compilador que debe usar treesitter, en este caso usamos `gcc`:

```bash
[Environment]::SetEnvironmentVariable("CC", "gcc", "User")
``` 
