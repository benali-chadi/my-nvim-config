local set = vim.keymap.set

local function clean_buffers()
	local output = vim.api.nvim_command_output "ls"
	local buffers_table = {}
	-- split output into lines
	for i in vim.gsplit(output, "\n") do
		local splits = vim.split(i, '"*"')
		local filename = splits[2]
		local trimmed = vim.trim(splits[1])
		local id = vim.split(trimmed, " ")
		table.insert(buffers_table, { id[1], filename })
	end

	for _, name in ipairs(buffers_table) do
		if name[2] == "[No Name]" then
			vim.api.nvim_buf_delete(tonumber(name[1]), { force = true })
		end
	end
end

-- Save folds state
vim.api.nvim_exec(
  [[
augroup AutoSaveFolds
  autocmd!
  au BufWinLeave ?* mkview 1
  au BufWinEnter ?* silent! loadview 1
augroup END
]],
  false
)

-- relative number
set('n', '<leader>nr', '<cmd>set rnu!<CR>', {desc = '[N]umber [Relative'})

-- save
set('n', '<C-s>', '<cmd>w<CR>')

-- NvimTree Toggle Mappings
set('n', '<C-n>', '<cmd>NvimTreeToggle<CR>')

-- Window Mappings
set('n', '<C-q>', '<cmd>q<CR>') -- close window
set('n', '<C-l>', '<C-w>l')     -- move right
set('n', '<C-h>', '<C-w>h')     -- move left
set('n', '<C-j>', '<C-w>j')     -- move down
set('n', '<C-k>', '<C-w>k')     -- move up

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
set('n', '<PageUp>', '<cmd>tabprevious<CR>')
set('n', '<PageDown>', '<cmd>tabnext<CR>')
-- move tabs
set('n', '<S-PageUp>', function()
	-- Get Current buffer info
	local buf_name = vim.api.nvim_buf_get_name(0)
	local coordinates = vim.api.nvim_win_get_cursor(0)

	-- Get Current tab's number
	local tabpage_num = vim.api.nvim_tabpage_get_number(0)

	if buf_name ~= "" and tabpage_num > 1 then
		-- Close The current buffer
		require("nvchad_ui.tabufline").close_buffer()

		-- Go to the previous tab and create a new buffer
		vim.api.nvim_command(
			"tabprevious | e " ..
			buf_name .. " | normal " .. "G" .. coordinates[1] .. "gg" .. coordinates[2] .. "l"
		)
	end
	clean_buffers()
end)
set('n', '<S-PageDown', function()
	-- Get Current buffer info
	local buf_name = vim.api.nvim_buf_get_name(0)
	local coordinates = vim.api.nvim_win_get_cursor(0)

	-- Get tab pages count and current tab's number
	local tabpages = vim.api.nvim_list_tabpages()
	local tabpages_count = #tabpages
	local tabpage_num = vim.api.nvim_tabpage_get_number(0)

	if buf_name ~= "" then
		-- Close The current buffer
		require("nvchad_ui.tabufline").close_buffer()

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
	clean_buffers()
end)
