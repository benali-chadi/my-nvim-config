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

	-- -- my local vim-plug learning
	-- {
	-- 	dir = '/Users/benalioulhajchadi/vim-plug-learning/',
	-- },

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

	-- swenv, python virtual env manager
	{
		'AckslD/swenv.nvim'
	},

	{
		"vhyrro/luarocks.nvim",
		priority = 1000, -- We'd like this plugin to load first out of the rest
		config = true, -- This automatically runs `require("luarocks-nvim").setup()`
	},

	-- Neorg
	{
		"nvim-neorg/neorg",
		dependencies = { "luarocks.nvim" },
		-- put any other flags you wanted to pass to lazy here!
		config = function()
			require("neorg").setup({
				load = {
					["core.defaults"] = {}, -- Loads default behaviour
					["core.concealer"] = {},
					["core.dirman"] = { -- Manages Neorg workspaces
						config = {
							workspaces = {
								areas = "~/notes",
							},
							default_workspace = "areas",
						},
					},
					["core.export"] = {},
				}
			})
		end,
	},

	-- Auto session
	{
		'rmagatti/auto-session',
		lazy = false,
		dependencies = {
			'nvim-telescope/telescope.nvim', -- Only needed if you want to use session lens
		},

		---enables autocomplete for opts
		---@module "auto-session"
		---@type AutoSession.Config
		opts = {
			suppressed_dirs = { '~/', '~/Projects', '~/Downloads', '/' },
			-- log_level = 'debug',
		}
	},

	-- Pomodoro
	{
		"epwalsh/pomo.nvim",
		version = "*", -- Recommended, use latest release instead of latest commit
		lazy = true,
		cmd = { "TimerStart", "TimerRepeat", "TimerSession" },
		dependencies = {
			-- Optional, but highly recommended if you want to use the "Default" timer
			"rcarriga/nvim-notify",
		},
		opts = {
			sessions = {
				reading = {
					{ name = "Focus", duration = "25m" },
					{ name = "Break", duration = "5m" },
					{ name = "Focus", duration = "25m" },
				},
				work = {
					{ name = "Focus", duration = "25m" },
					{ name = "Break", duration = "5m" },
					{ name = "Focus", duration = "25m" },
					{ name = "Break", duration = "5m" },
					{ name = "Focus", duration = "25m" },
				},
				learning = {
					{ name = "Focus", duration = "45m" },
					{ name = "Break", duration = "15m" },
					{ name = "Focus", duration = "45m" },
				}
			}
		},
	},
	{
		"lervag/vimtex",
		lazy = false, -- we don't want to lazy load VimTeX
		-- tag = "v2.15", -- uncomment to pin to a specific release
		init = function()
			-- This is necessary for VimTeX to load properly. The "indent" is optional.
			-- Note: Most plugin managers will do this automatically!
			vim.cmd('filetype plugin indent on')

			-- This enables Vim's and Neovim's syntax-related features. Without this, some
			-- VimTeX features will not work (see ":help vimtex-requirements" for more info).
			-- Note: Most plugin managers will do this automatically!
			vim.cmd('syntax enable')

			-- Viewer options: One may configure the viewer either by specifying a built-in
			-- viewer method:
			vim.g.vimtex_view_method = 'zathura'
			vim.g.maplocalleader = '-'

			-- VimTeX uses latexmk as the default compiler backend. If you use it, which is
			-- strongly recommended, you probably don't need to configure anything. If you
			-- want another compiler backend, you can change it as follows. The list of
			-- supported backends and further explanation is provided in the documentation,
			-- see ":help vimtex-compiler".
			vim.g.vimtex_compiler_method = 'latexrun'

			vim.g.vimtex_view_general_options = '--unique file:@pdf\\#src:@line@tex'
		end
	},
	-- Tree-Sitter-Context
	{
		"nvim-treesitter/nvim-treesitter-context",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("treesitter-context").setup({
				enable = true
			})
		end
	},
	-- Code Companion
	{
		"olimorris/codecompanion.nvim", -- The KING of AI programming
		dependencies = {
			'nvim-lua/plenary.nvim',
			'nvim-treesitter/nvim-treesitter',
		},
		opts = {
			adapters = {
				ollama = function()
					return require("codecompanion.adapters").extend("ollama", {
						-- name = 'llama',
						schema = {
							model = {
								default = "deepseek-r1",
							},
							-- num_ctx = {
							-- 	default = 20000,
							-- },
						},
					})
				end,
			},
			strategies = {
				-- Change the default chat adapter
				chat = {
					adapter = 'ollama',
				},
				inline = {
					adapter = "ollama",
					keymaps = {
						accept_change = {
							modes = { n = "ga" },
							description = "Accept the suggested change",
						},
						reject_change = {
							modes = { n = "gr" },
							description = "Reject the suggested change",
						},
					},
				},
			},
		}
	},
}
