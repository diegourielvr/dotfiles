# Dotfiles

Este repositorio contiene las configuraciones de mi entorno (Neovim, scripts, etc.) utilizando un sistema de **Repositorio Bare** y **Git Worktrees**. 

---

## Conceptos Clave

- **Bare Repository:** Una base de datos de Git ubicada en `~/.dotfiles` que no tiene una "carpeta de trabajo" propia.
- **Worktrees:** "Túneles" que conectan ramas específicas del repo con carpetas reales en el disco duro.

---

## Configuración Inicial

### 1. Crear el motor (Bare Repo)

```bash
git init --bare ~/.dotfiles
cd ~/.dotfiles
```

Y conectamos el repositorio remoto

```bash
# Usando ssh
git remote add origin git@github.com:diegourielvr/dotfiles.git
```

### 2. Worktree Main

Creamos un espacio dedicado para la rama principal:

```bash
# Esto saca la rama 'main' de la base de datos y la pone en una carpeta visible
git worktree add ~/dotfiles-main main

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

### Agregar una nueva configuración (Ejemplo: Zsh)

1. **Crear rama:**
```bash
# crear la rama "huérfana" (sin historial previo)
cd ~/.dotfiles

git switch --orphan zsh-config
```

2. **Commit vacio:** 

Necesitamos al menos un commit para crear un worktree de la nueva rama

```bash
git commit --allow-empty -m "Init zsh"
```

3. **Vincular carpeta:**

```bash
# No debe existir o debe estar completamente vacia la nueva carpeta a vincular
git worktree add ~/.config/zsh zsh-config
```
4. **Agregar archivos:**

```bash
cd ~/.config/zsh
# (Crear o editar archivos)
git add .
git commit -m "Add zsh files"
```

5. **Subir:**

Usamos el siguiente comando para subir cambios por primera vez al repositorio remoto

```bash
git push -u origin zsh-config
```

---

## Uso Multiplataforma (Windows ↔ Linux)

### En una máquina nueva:

1. **Clonar el repo bare:**

   ```bash
   git clone --bare git@github.com:diegourielvr/dotfiles.git ~/.dotfiles
   cd ~/dotfiles
   ```

3. **Descargar las ramas necesarias:**

   ```bash
   # Git creará la carpeta automáticamente y pondrá los archivos (no debe existir la carpeta o debe estar vacia)
   git worktree add ~/.config/nvim nvim-config
   git worktree add ~/AppData/Local/nvim nvim-config
   ```

### Listar worktrees

```bash
cd ~/.dotfiles
git worktree list
```

### Eliminar un worktree

```bash
git worktree remove ~/.config/nvim

# Si tienes cambios sin guardar (pero ya no te importan)
git worktree remove ~/AppData/Local/nvim --force
```

#### ¿Qué pasa si ya borré la carpeta manualmente?

Si eliminaste la carpeta del worktree directamente usando el explorador de archivos o el comando `rm -rf`, debes limpiar los residuos que quedaron en la base de datos de Git:

```bash
git worktree prune
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
