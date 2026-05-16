local keymap = vim.keymap.set

keymap('n', '<leader>w', '<CMD>w<CR>', { desc = 'Guardar cambios' })
keymap('n', '<leader>q', '<CMD>q<CR>', { desc = 'Cerrar ventana actual' })
keymap('n', 'U', '<C-r>', { desc = 'Redo' })

keymap('n', 'j', 'gj', { desc = 'Moverse una linea visual hacia abajo' })
keymap('n', 'k', 'gk', { desc = 'Moverse una linea visual hacia arriba' })

keymap('i', 'jk', '<ESC>', { desc = 'Salir del modo insertar' })
keymap('i', '<C-H>', '<C-W>', { desc = 'Borrar palabra antes del cursor' }) -- Ctrl + Backspace
keymap('i', '<C-Del>', '<C-O>dw', { desc = 'Borrar palabra después del cursor' })

keymap('v', '>', '>gv', { desc = 'Indentar' })
keymap('v', '<', '<gv', { desc = 'Desindentar' })

keymap('v', '<A-k>', ":m '<-2<CR>gv-gv", { desc = 'Mover bloque seleccionado hacia arriba' })
keymap('v', '<A-j>', ":m '>+1<CR>gv-gv", { desc = 'Mover bloque seleccionado hacia abajo' })

keymap('n', '<leader>sh', '<CMD>split<CR>', { desc = 'Dividir ventana horizonalmente' })
keymap('n', '<leader>sv', '<CMD>vsplit<CR>', { desc = 'Dividir ventana verticalmente' })

keymap('n', '<C-h>', '<C-w>h><ESC>', { desc = 'Mover cursor a la ventana izquierda' })
keymap('n', '<C-j>', '<C-w>j><ESC>', { desc = 'Mover cursor a la ventana de abajo' })
keymap('n', '<C-k>', '<C-w>k><ESC>', { desc = 'Mover cursor a la ventana de arribia' })
keymap('n', '<C-l>', '<C-w>l><ESC>', { desc = 'Mover cursor a la ventana de la d erecha' })

keymap('n', '<TAB>', '<CMD>bnext<CR>', { desc = 'Ir al siguiente buffer/ventana' })
keymap('n', '<S-TAB>', '<CMD>bprevious<CR>', { desc = 'Ir al buffer/ventana anterior' })

keymap('n', '<leader>nh', '<CMD>nohlsearch<CR>', { desc = 'Stop the highlighting' })
