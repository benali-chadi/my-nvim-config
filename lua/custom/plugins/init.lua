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
	-- {
	-- 	'MunifTanjim/prettier.nvim',
	-- 	config = function()
	-- 		require("prettier").setup {
	-- 			bin = 'prettier', -- or `'prettierd'` (v0.23.3+)
	-- 			filetypes = {
	-- 				"css",
	-- 				"graphql",
	-- 				"html",
	-- 				"javascript",
	-- 				"javascriptreact",
	-- 				"json",
	-- 				"less",
	-- 				"markdown",
	-- 				"scss",
	-- 				"typescript",
	-- 				"typescriptreact",
	-- 				"yaml",
	-- 				"vue"
	-- 			},
	-- 			cli_options = {
	-- 				arrow_parens = "always",
	-- 				bracket_spacing = true,
	-- 				bracket_same_line = false,
	-- 				embedded_language_formatting = "auto",
	-- 				end_of_line = "lf",
	-- 				html_whitespace_sensitivity = "css",
	-- 				-- jsx_bracket_same_line = false,
	-- 				jsx_single_quote = false,
	-- 				print_width = 80,
	-- 				prose_wrap = "preserve",
	-- 				quote_props = "as-needed",
	-- 				semi = true,
	-- 				single_attribute_per_line = false,
	-- 				single_quote = false,
	-- 				tab_width = 2,
	-- 				trailing_comma = "es5",
	-- 				use_tabs = false,
	-- 				vue_indent_script_and_style = false,
	-- 			},
	-- 		}
	-- 	end
	-- },
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
	-- {
	-- 	'echasnovski/mini.animate',
	-- 	version = false,
	-- 	config = function() require('mini.animate').setup() end
	-- },
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
		-- dressing (for select and input functions pretty ui)
		{
			'stevearc/dressing.nvim',
			event = 'VeryLazy',
		},
		-- Trouble for workspace diagnostics
		{
			"folke/trouble.nvim",
			dependencies = { "nvim-tree/nvim-web-devicons" },
			opts = {
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
			},
		},
	},
	-- autopairs
	{
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup {}
		end
	},

	-- my local vim-plug learning
	{
		dir = '/Users/benalioulhajchadi/vim-plug-learning/',
	},

	-- Plenary
	{
		"nvim-lua/plenary.nvim",
	},

	-- Markdown preview
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		build = "cd app && yarn install",
		init = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = { "markdown" },
	},
}
