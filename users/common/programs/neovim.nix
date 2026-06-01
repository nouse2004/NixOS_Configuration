{ config, pkgs, inputs, ... }: {
	imports = [
		inputs.nixvim.homeModules.nixvim
	];

	programs.nixvim = {
		enable = true;
		nixpkgs.source = inputs.nixpkgs;
		version.enableNixpkgsReleaseCheck = false;

		colorschemes.catppuccin.enable = true;

		opts = {
			number = true;
			relativenumber = true;
			shiftwidth = 2;
			tabstop = 2;
			expandtab = true;
			mouse = "a";
			clipboard = "unnamedplus";
			termguicolors = true;
			syntax = "on";
			wrap = false;
			scrolloff = 8;
			signcolumn = "yes";
			updatetime = 250;
			timeoutlen = 300;
			completeopt = "menuone,noselect";
		};

		keymaps = [
			{
				mode = "n";
				key = "<leader>w";
				action = "<cmd>w<CR>";
				options.desc = "Save file";
			}
			{
				mode = "n";
				key = "<leader>q";
				action = "<cmd>q<CR>";
				options.desc = "Close window";
			}
			{
				mode = "n";
				key = "<leader>e";
				action = "<cmd>Oil<CR>";
				options.desc = "Open file explorer";
			}
			{
				mode = "n";
				key = "<leader>ff";
				action = "<cmd>Telescope find_files<CR>";
				options.desc = "Find files";
			}
			{
				mode = "n";
				key = "<leader>fg";
				action = "<cmd>Telescope live_grep<CR>";
				options.desc = "Live grep";
			}
			{
				mode = "n";
				key = "<leader>fb";
				action = "<cmd>Telescope buffers<CR>";
				options.desc = "Find buffers";
			}
			{
				mode = "n";
				key = "<leader>fh";
				action = "<cmd>Telescope help_tags<CR>";
				options.desc = "Help tags";
			}
			{
				mode = "n";
				key = "<leader>gd";
				action = "<cmd>Telescope lsp_definitions<CR>";
				options.desc = "Go to definition";
			}
			{
				mode = "n";
				key = "<leader>gr";
				action = "<cmd>Telescope lsp_references<CR>";
				options.desc = "Find references";
			}
			{
				mode = "n";
				key = "<leader>ca";
				action = "<cmd>Telescope lsp_code_actions<CR>";
				options.desc = "Code actions";
			}
			{
				mode = "n";
				key = "K";
				action = "<cmd>lua vim.lsp.buf.hover()<CR>";
				options.desc = "LSP hover";
			}
			{
				mode = "n";
				key = "<leader>rn";
				action = "<cmd>lua vim.lsp.buf.rename()<CR>";
				options.desc = "LSP rename";
			}
			{
				mode = "n";
				key = "[d";
				action = "<cmd>lua vim.diagnostic.goto_prev()<CR>";
				options.desc = "Previous diagnostic";
			}
			{
				mode = "n";
				key = "]d";
				action = "<cmd>lua vim.diagnostic.goto_next()<CR>";
				options.desc = "Next diagnostic";
			}
		];

		plugins = {
			lualine = {
				enable = true;
				settings.options = {
					theme = "catppuccin";
					component_separators = "|";
					section_separators = "";
				};
			};

			telescope = {
				enable = true;
				settings.defaults = {
					mappings = {
						i = {
							"<C-j>" = { action = "move_selection_next"; };
							"<C-k>" = { action = "move_selection_previous"; };
						};
					};
				};
				extensions.fzf-native.enable = true;
			};

			treesitter = {
				enable = true;
				settings = {
					ensure_installed = [
						"c"
						"cpp"
						"rust"
						"nix"
						"lua"
						"python"
						"bash"
						"json"
						"yaml"
						"toml"
						"markdown"
						"html"
						"css"
						"javascript"
						"typescript"
					];
					auto_install = true;
					highlight.enable = true;
					indent.enable = true;
				};
			};

			lsp = {
				enable = true;
				keymaps = {
					lazy = true;
					silent = true;
				};
				servers = {
					nil_ls.enable = true;
					rust_analyzer = {
						enable = true;
						installCargo = false;
						installRustc = false;
					};
					lua_ls.enable = true;
					pyright.enable = true;
					texlab.enable = true;
				};
			};

			cmp = {
				enable = true;
				settings.sources = [
					{ name = "nvim_lsp"; }
					{ name = "path"; }
					{ name = "buffer"; }
				];
				settings.mapping = {
					"<C-b>" = "cmp.mapping.scroll_docs(-4)";
					"<C-f>" = "cmp.mapping.scroll_docs(4)";
					"<C-Space>" = "cmp.mapping.complete()";
					"<C-e>" = "cmp.mapping.abort()";
					"<CR>" = "cmp.mapping.confirm({ select = true })";
					"<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i','s'})";
					"<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i','s'})";
				};
			};

			cmp_nvim_lsp.enable = true;
			cmp_path.enable = true;
			cmp_buffer.enable = true;

			which_key = {
				enable = true;
				settings.spec = [
					{
						__unkeyed-1 = "<leader>";
						mode = "n";
						group = "+prefix";
					}
				];
			};

			gitsigns = {
				enable = true;
				settings.signs = {
					add.text = "+";
					change.text = "~";
					delete.text = "_";
					topdelete.text = "‾";
					changedelete.text = "~";
				};
			};

			comment.enable = true;

			autopairs.enable = true;

			oil = {
				enable = true;
				settings = {
					default_file_explorer = true;
					skip_confirm_for_simple_edits = true;
					view_options.show_hidden = true;
				};
			};

			web-devicons.enable = true;
		};
	};
}
