local set = vim.keymap.set

local function mysplit(inputstr, sep)
	if sep == nil then
		sep = "%s"
	end
	local t = {}
	for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
		table.insert(t, str)
	end
	return t
end

local function mytrim(s)
	return (s:gsub("^%s*(.-)%s*$", "%1"))
end
local function clean_buffers()
	local output = vim.api.nvim_command_output "ls"
	local buffers_table = {}
	-- split output into lines
	for i in vim.gsplit(output, "\n") do
		local splits = mysplit(i, '"*"')
		local filename = splits[2]
		local trimmed = mytrim(splits[1])
		local id = mysplit(trimmed, " ")
		table.insert(buffers_table, { id[1], filename })
	end


	for _, name in ipairs(buffers_table) do
		if name[2] == "[No Name]" then
			vim.api.nvim_buf_delete(tonumber(name[1]), { force = true })
			if #buffers_table == 1 then
				vim.api.nvim_command "q"
				return
			end
		end
	end
	-- if vim.gsplit(vim.api.nvim_command_output "ls", "\n") == 1 then
	-- 	vim.api.nvim_command "q"
	-- end
end

-- Save folds state
vim.cmd([[
augroup AutoSaveFolds
  autocmd!
  au BufWinLeave ?* mkview 1
  au BufWinEnter ?* silent! loadview 1
augroup END
]])

-- General
set('n', '<leader>nr', '<cmd>set rnu!<CR>', { desc = '[N]umber [R]elative' }) -- relative number
set('n', '<C-s>', '<cmd>w<CR>')                                               -- save
set('n', '<Esc>', '<cmd>noh<CR>')                                             -- no highlight

-- NvimTree Toggle Mappings
set('n', '<C-n>', '<cmd>NvimTreeFindFileToggle<CR>')

-- Buffers
set('n', '<C-x>', '<tab>')                            -- for the weird vim behaviour, to remap <C-i> to <C-n> before remapping <tab>
-- set('n', '<C-j>', '<C-o>')       -- jump back
set('n', '<C-c>', '<cmd>bp<bar>sp<bar>bn<bar>bd<CR>') -- close
set('n', '<tab>', '<cmd>bnext<CR>')
set('n', '<S-tab>', '<cmd>bprevious<CR>')

-- Window Mappings
set('n', '<C-q>', '<cmd>q<CR>') -- close window
set('n', '<C-l>', '<C-w>l')     -- move right
set('n', '<C-h>', '<C-w>h')     -- move left
set('n', '<C-j>', '<C-w>j')     -- move down
set('n', '<C-k>', '<C-w>k')     -- move up
-- resize windows
set('n', '<S-Right>', '<C-w>>')
set('n', '<S-Left>', '<C-w><')
set('n', '<S-Up>', '<C-w>+')
set('n', '<S-Down>', '<C-w>-')

-- Move Lines
-- normal mode
set('n', '<A-j>', ':m .+1<CR>==')
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

-- Tabs
set('n', 't', '<cmd>tabnew<CR>')
set('n', '<S-h>', '<cmd>tabprevious<CR>')
set('n', '<S-l>', '<cmd>tabnext<CR>')
-- move tabs
set('n', '<A-S-h>', function()
	-- Get Current buffer info
	local buf_name = vim.api.nvim_buf_get_name(0)
	local coordinates = vim.api.nvim_win_get_cursor(0)

	-- Get Current tab's number
	local tabpage_num = vim.api.nvim_tabpage_get_number(0)

	if buf_name ~= "" and tabpage_num > 1 then
		-- Close The current buffer
		vim.api.nvim_command('bp | sp | bn | bd')
		clean_buffers()
		-- Go to the previous tab and create a new buffer
		vim.api.nvim_command(
			"tabprevious | e " ..
			buf_name .. " | normal " .. "G" .. coordinates[1] .. "gg" .. coordinates[2] .. "l"
		)
	end
end)
set('n', '<A-S-l>', function()
	-- Get Current buffer info
	local buf_name = vim.api.nvim_buf_get_name(0)
	local coordinates = vim.api.nvim_win_get_cursor(0)

	-- Get tab pages count and current tab's number
	local tabpages = vim.api.nvim_list_tabpages()
	local tabpages_count = #tabpages
	local tabpage_num = vim.api.nvim_tabpage_get_number(0)

	if buf_name ~= "" and tabpages_count > 1 then
		-- Close The current buffer
		vim.api.nvim_command('bp | sp | bn | bd')
		clean_buffers()

		if tabpage_num < tabpages_count then
			-- Go to the next tab and create a new buffer
			vim.api.nvim_command(
				"tabnext | e " ..
				buf_name .. " | normal " .. "G" .. coordinates[1] .. "gg" .. coordinates[2] .. "l"
			)
		else
			-- Create a new tab and create a new buffer
			vim.api.nvim_command(
				"tabnew | e " ..
				buf_name .. " | normal " .. "G" .. coordinates[1] .. "gg" .. coordinates[2] .. "l"
			)
		end
	end
end)

-- Trouble plugin mappings
set('n', '<A-x>', '<cmd>TroubleToggle document_diagnostics<cr>')
set('n', '<A-S-x>', '<cmd>TroubleToggle workspace_diagnostics<cr>')

-- Execute current lua file
set('n', '<leader>l', '<cmd>luafile %<cr>', { desc = "Execute current lua file" })

-- Open Help Tags
set('n', '<leader>h', '<cmd>lua require("telescope.builtin").help_tags()<cr>', { desc = "Open Help Tags" })

-- Run Plenary test on current buffer
set('n', '<leader>t', '<cmd>PlenaryBustedFile %<cr>',
	{ desc = "Run Plenary test on current buffer" })

-- Open Lazy Git
set('n', '<leader>gg', '<cmd>LazyGit<cr>', { desc = "Open Lazy Git" })

-- swenv keymaps
set('n', '<leader>pe', '<cmd>lua require("swenv.api").pick_venv()<cr>', { desc = "Open swenv" })
