local set = vim.keymap.set

set('n', '<C-s>', '<cmd>w<CR>')

-- NvimTree Toggle Mappings
set('n', '<C-n>', '<cmd>NvimTreeToggle<CR>')

-- Window Mappings
set('n', '<C-q>', '<cmd>q<CR>') -- close window
set('n', '<C-l>', '<C-w>l') -- move right
set('n', '<C-h>', '<C-w>h') -- move left
set('n', '<C-j>', '<C-w>j') -- move down
set('n', '<C-k>', '<C-w>k') -- move up

-- Move Lines
	-- normal mode
set('n', '<A-j>' ,':m .+1<CR>==')
set('n', '<A-k>', ':m .-2<CR>==')
	-- insert mode
set('i', '<A-j>', '<Esc>:m .+1<CR>==gi')
set('i', '<A-k>', '<Esc>:m .-2<CR>==gi')
	-- visual mode
set('v', '<A-j>', ":m '>+1<CR>gv=gv")
set('v', '<A-k>', ":m '<-2<CR>gv=gv")

-- Indent Lines
set('v', '<tab>', ":'<,'> ><CR>gv")
set('v', '<S-tab>', ":'<,'> <<CR>gv")
