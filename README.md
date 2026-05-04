# Dotfiles

Este repositorio contiene las configuraciones de mi entorno (Neovim, scripts, etc.) utilizando un sistema de **Repositorio Bare** y **Git Worktrees**. 

---

## Conceptos Clave

- **Bare Repository:** Una base de datos de Git ubicada en `~/.dotfiles` que no tiene una "carpeta de trabajo" propia.
- **Alias `dots`:** Comando personalizado para interactuar con el repo bare desde cualquier lugar.
- **Worktrees:** "Túneles" que conectan ramas específicas del repo con carpetas reales en el disco duro.

---

## Configuración Inicial

### 1. Crear el motor (Bare Repo)

```bash
git init --bare $HOME/.dotfiles
```

### 2. Configurar el Alias (en .zshrc / .bashrc / PowerShell)

Para gestionar el repo sin movernos de carpeta:

En .zshrc, .bashrc:

```bash
alias dots='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
```

En Powershell:

```bash
function dots {
    & git --git-dir="$HOME\.dotfiles\" --work-tree="$HOME" @args
}
```

Como el "directorio de trabajo" es todo `$HOME`, le decimos a Git que no muestre todos los archivos de la PC como "pendientes":

```bash
dots config --local status.showUntrackedFiles no
```

Y conectamos el remoto usando ese alias:

```bash
# Usando ssh
dots remote add origin git@github.com:diegourielvro/dotfiles.git
```

### 3. Separación de la documentación (Worktree Main)

Para evitar que el archivo `README.md` y otros archivos globales se mezclen con las carpetas personales del `$HOME`, creamos un espacio dedicado para la rama principal:

```bash
# Esto saca la rama 'main' de la base de datos y la pone en una carpeta visible
dots worktree add ~/dotfiles-main main

cd ~/dotfiles-main
# (Crear y editar el archivo README.md)
git add README.md
git commit -m "Explicación de worktree main añadida"
git push -u origin main
```

---

## Estructura de Ramas y Worktrees

Cada configuración importante vive en su propia rama y se "materializa" en una carpeta específica:



| Rama | Carpeta (Windows) | Carpeta (Linux) | Descripción |
| :--- | :--- | :--- | :--- |
| `main` | `~/dotfiles-main` | `~/dotfiles-main` | Documentación y README |
| `nvim-config` | `~/AppData/Local/nvim` | `~/.config/nvim` | Configuración de Neovim |

### Cómo agregar una nueva configuración (Ejemplo: Zsh)

1. **Crear rama:**
```bash
# crear la rama "huérfana" (sin historial previo)
dots checkout --orphan zsh-config
```
2. **Limpiar rama:** 
```bash
dots rm -rf .
dots commit --allow-empty -m "Init zsh"
```
3. **Vincular carpeta:**
```bash
dots worktree add ~/.config/zsh zsh-config
```
4. **Agregar archivos:**
```bash
cd ~/.config/zsh
# (Crear o editar archivos)
git add .
git commit -m "Add zsh files"
```
5. **Subir:**
```bash
git push -u origin zsh-config
```

---

## Uso Multiplataforma (Windows ↔ Linux)

### En una máquina nueva:

1. **Clonar el repo bare:**
   ```bash
   git clone --bare git@github.com:diegourielvr/dotfiles.git $HOME/.dotfiles
   ```
2. **Configurar el alias `dots`** en la terminal.
3. **Descargar las ramas necesarias:**
   ```bash
   # Git creará la carpeta automáticamente y pondrá los archivos
   dots worktree add ~/.config/nvim nvim-config
   ```

---

## Flujo de Trabajo Diario

### Subir cambios:

Entra a la carpeta del componente modificado:

```bash
cd ~/AppData/Local/nvim
git add .
git commit -m "Update theme"
git push
```

### Bajar cambios (Sync):

Si modificamos algo en otra PC:

```bash
cd ~/AppData/Local/nvim
git pull
```

---

## Notas Importantes

- **No mezclar ramas:** No intentar hacer `checkout` de la misma rama en dos carpetas distintas.
- **Ignorar archivos:** Si Neovim genera archivos temporales, crear un `.gitignore` **dentro** de la rama `nvim-config`.