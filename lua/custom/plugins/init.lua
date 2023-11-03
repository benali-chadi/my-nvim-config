-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information

local function my_on_attach(bufnr)
	local api = require "nvim-tree.api"

	local function opts(desc)
		return {
			desc = "nvim-tree: " .. desc,
			buffer = bufnr,
			noremap = true,
			silent = true,
			nowait = true
		}
	end

	api.config.mappings.default_on_attach(bufnr)

	vim.keymap.set('n', '?', api.tree.toggle_help, opts('Help'))
end
return {
	-- Nerd Tree
	{
		'nvim-tree/nvim-tree.lua',
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("nvim-tree").setup {
				on_attach = my_on_attach,
				sort_by = "case_sensitive",
				view = {
					width = 30,
				},
				git = {
					enable = true,
				},
				renderer = {
					group_empty = true,
					highlight_git = true,
					icons = {
						show = {
							git = true,
						},
					},

				},
				filters = {
					dotfiles = true,
				},
			}
		end,
	},
	-- Prettier
	{
		'MunifTanjim/prettier.nvim',
		config = function()
			require("prettier").setup {
				bin = 'prettier', -- or `'prettierd'` (v0.23.3+)
				filetypes = {
					"css",
					"graphql",
					"html",
					"javascript",
					"javascriptreact",
					"json",
					"less",
					"markdown",
					"scss",
					"typescript",
					"typescriptreact",
					"yaml",
					"vue"
				},
			}
		end
	},
	-- Codeium
	{
		"Exafunction/codeium.vim",
		lazy = false,
		config = function()
			-- Change '<C-g>' here to any keycode you like.
			vim.keymap.set("i", "<C-g>", function()
				return vim.fn["codeium#Accept"]()
			end, { expr = true })
			vim.keymap.set("i", "<C-;>", function()
				return vim.fn["codeium#CycleCompletions"](1)
			end, { expr = true })
			vim.keymap.set("i", "<C-,>", function()
				return vim.fn["codeium#CycleCompletions"](-1)
			end, { expr = true })
			vim.keymap.set("i", "<C-x>", function()
				return vim.fn["codeium#Clear"]()
			end, { expr = true })
		end,
	},
	-- Scope (for tabs)
	{
		"tiagovla/scope.nvim",
		config = function() require("scope").setup({}) end
	},
	-- mini surrond
	{
		'echasnovski/mini.surround',
		version = false,
		config = function()
			require(
				'mini.surround').setup()
		end
	},
	-- mini animate
	{
		'echasnovski/mini.animate',
		version = false,
		config = function() require('mini.animate').setup() end
	},
	-- colorizer
	{
		'norcalli/nvim-colorizer.lua',
		config = function()
			require('colorizer').setup()
		end
	},
	-- Themes

	{
		"EdenEast/nightfox.nvim",
		config = function()
			require("nightfox").setup({
				options = {
					styles = {
						comments = "italic",
						keywords = "bold",
						strings = "bold",
						constants = "bold",
						functions = "bold",
						operators = "italic",
					}
				}
			})
			-- vim.cmd.colorscheme 'nightfox'
		end
	},
	{
		'Shatur/neovim-ayu',
		config = function()
			vim.cmd.colorscheme 'ayu-dark'
		end,
	},
}
