-- 自动安装 Packer.nvim
-- 插件安装目录
-- ~/.local/share/nvim/site/pack/packer/
local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
local paccker_bootstrap
if fn.empty(fn.glob(install_path)) > 0 then
  vim.notify("正在安装Pakcer.nvim，请稍后...")
  paccker_bootstrap = fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    -- "https://gitcode.net/mirrors/wbthomason/packer.nvim",
    install_path,
  })

  -- https://github.com/wbthomason/packer.nvim/issues/750
  local rtp_addition = vim.fn.stdpath("data") .. "/site/pack/*/start/*"
  if not string.find(vim.o.runtimepath, rtp_addition) then
    vim.o.runtimepath = rtp_addition .. "," .. vim.o.runtimepath
  end
  vim.notify("Pakcer.nvim 安装完毕")
end

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  vim.notify("没有安装 packer.nvim")
  return
end

packer.startup({
  function(use)
    -- Packer 可以升级自己
    use("wbthomason/packer.nvim")
    -------------------------- plugins -------------------------------------------
    -- use("lewis6991/impatient.nvim")
    -- use("nathom/filetype.nvim")

    -- nvim-notify
    use({
      "rcarriga/nvim-notify",
      config = function()
        require("plugin-config.nvim-notify")
      end,
    })
    -- nvim-tree
    use({
      "kyazdani42/nvim-tree.lua",
      requires = "kyazdani42/nvim-web-devicons",
      config = function()
        require("plugin-config.nvim-tree")
      end,
    })

    -- bufferline
    use({
      "akinsho/bufferline.nvim",
      requires = { "kyazdani42/nvim-web-devicons", "moll/vim-bbye" },
      config = function()
        require("plugin-config.bufferline")
      end,
    })

    -- lualine
    use({
      "nvim-lualine/lualine.nvim",
      requires = { "kyazdani42/nvim-web-devicons" },
      config = function()
        require("plugin-config.lualine")
      end,
    })

    -- telescope
    use({
      "nvim-telescope/telescope.nvim",
      -- opt = true,
      -- cmd = "Telescope",
      requires = {
        -- telescope extensions
        { "LinArcX/telescope-env.nvim" },
        { "nvim-telescope/telescope-ui-select.nvim" },
      },
      config = function()
        require("plugin-config.telescope")
      end,
    })

    -- dashboard-nvim
    use({
      "glepnir/dashboard-nvim",
      config = function()
        require("plugin-config.dashboard")
      end,
    })

    -- project
    use({
      "ahmedkhalf/project.nvim",
      config = function()
        require("plugin-config.project")
      end,
    })

    -- treesitter
    use({
      "nvim-treesitter/nvim-treesitter",
      run = function()
        -- require("nvim-treesitter.install").update({ with_sync = true })
      end,
      requires = {
        { "p00f/nvim-ts-rainbow" },
        { "JoosepAlviste/nvim-ts-context-commentstring" },
        { "windwp/nvim-ts-autotag" },
        { "nvim-treesitter/nvim-treesitter-refactor" },
        { "nvim-treesitter/nvim-treesitter-textobjects" },
      },
      config = function()
        require("plugin-config.nvim-treesitter")
      end,
    })

    -- indent-blankline
    -- 注释掉 
    -- 1. 大工程影响速度
    -- 2. 影响代码复制
    -- use({
    --   "lukas-reineke/indent-blankline.nvim",
    --   config = function()
    --     require("plugin-config.indent-blankline")
    --   end,
    -- })

    -- toggleterm
    use({
      "akinsho/toggleterm.nvim",
      config = function()
        require("plugin-config.toggleterm")
      end,
    })

    -- surround
    -- use({
    --   "ur4ltz/surround.nvim",
    --   config = function()
    --     require("plugin-config.surround")
    --   end,
    -- })

    -- nvim-surround
    use({
      "kylechui/nvim-surround",
      config = function()
        require("plugin-config.nvim-surround")
      end,
    })

    -- Comment
    use({
      "numToStr/Comment.nvim",
      config = function()
        require("plugin-config.comment")
      end,
    })

    -- nvim-autopairs
    use({
      "windwp/nvim-autopairs",
      config = function()
        require("plugin-config.nvim-autopairs")
      end,
    })

    -- fidget.nvim
    use({
      "j-hui/fidget.nvim",
      config = function()
        require("plugin-config.fidget")
      end,
    })

    -- todo-comments.nvim
    use({
      "folke/todo-comments.nvim",
      requires = "nvim-lua/plenary.nvim",
      config = function()
        require("plugin-config.todo-comments")
      end,
    })

    -- mkdnflow.nvim
    use({
      "jakewvincent/mkdnflow.nvim",
      ft = { "markdown" },
      commit = "739b8b93530adbd5dfb2d3abff66752637442d41",
      config = function()
        require("plugin-config.mkdnflow")
      end,
    })

    -- venn 画图
    use({
      "jbyuki/venn.nvim",
      config = function()
        require("plugin-config.venn")
      end,
    })

    -- zen mode
    use({
      "folke/zen-mode.nvim",
      config = function()
        require("plugin-config.zen-mode")
      end,
    })
    --------------------- LSP --------------------
    -- installer
    use({ "williamboman/mason.nvim" })
    use({ "williamboman/mason-lspconfig.nvim" })
    -- Lspconfig
    use({ "neovim/nvim-lspconfig" })
    -- 补全引擎
    use("hrsh7th/nvim-cmp")
    -- Snippet 引擎
    use("L3MON4D3/LuaSnip")
    use("saadparwaiz1/cmp_luasnip")
    -- 补全源
    use("hrsh7th/cmp-vsnip")
    use("hrsh7th/cmp-nvim-lsp") -- { name = nvim_lsp }
    use("hrsh7th/cmp-buffer") -- { name = 'buffer' },
    use("hrsh7th/cmp-path") -- { name = 'path' }
    use("hrsh7th/cmp-cmdline") -- { name = 'cmdline' }
    use("hrsh7th/cmp-nvim-lsp-signature-help") -- { name = 'nvim_lsp_signature_help' }
    -- 常见编程语言代码段
    use("rafamadriz/friendly-snippets")
    -- UI 增强
    use("onsails/lspkind-nvim")
    use("tami5/lspsaga.nvim")
    -- 代码格式化
    use("mhartington/formatter.nvim")
    use({ "jose-elias-alvarez/null-ls.nvim", requires = "nvim-lua/plenary.nvim" })
    -- TypeScript 增强
    use({ "jose-elias-alvarez/nvim-lsp-ts-utils", requires = "nvim-lua/plenary.nvim" })
    use("jose-elias-alvarez/typescript.nvim")

    -- Lua 增强
    use("folke/neodev.nvim")
    -- JSON 增强
    use("b0o/schemastore.nvim")
    -- Rust 增强
    use("simrat39/rust-tools.nvim")
    --------------------- colorschemes --------------------
    -- tokyonight
    use({
      "folke/tokyonight.nvim",
      config = function()
        require("plugin-config.tokyonight")
      end,
    })

    -- vim-one
    use("rakr/vim-one")

    -- OceanicNext
    use({"mhartington/oceanic-next", event = "VimEnter"})

    -- gruvbox
    use({
       "ellisonleao/gruvbox.nvim",
       requires = { "rktjmp/lush.nvim" },
    })

    -- zephyr
    use("glepnir/zephyr-nvim")

    -- nord
    use("shaunsingh/nord.nvim")

    -- onedark 
    use("ful1e5/onedark.nvim")

    -- nightfox
    use("EdenEast/nightfox.nvim")

    -------------------------------------------------------
    -- git
    use({
      "lewis6991/gitsigns.nvim",
      config = function()
        require("plugin-config.gitsigns")
      end,
    })
    -- vimspector
    use({
      "puremourning/vimspector",
      cmd = { "VimspectorInstall", "VimspectorUpdate" },
      fn = { "vimspector#Launch()", "vimspector#ToggleBreakpoint", "vimspector#Continue" },
      config = function()
        require("dap.vimspector")
      end,
    })
    ----------------------------------------------
    -- nvim-dap
    use("mfussenegger/nvim-dap")
    use("theHamsta/nvim-dap-virtual-text")
    use("rcarriga/nvim-dap-ui")

    -- node
    use({
      "mxsdev/nvim-dap-vscode-js",
      requires = { "mfussenegger/nvim-dap" },
      config = function()
        require("dap.nvim-dap.config.vscode-js")
      end,
    })

    -- go
    use("leoluz/nvim-dap-go")

    use {
      'nvim-telescope/telescope-fzf-native.nvim',
      run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
    }

    -- Show undo history visually
    use { "simnalamburt/vim-mundo", cmd = { "MundoToggle", "MundoShow" } }

    -- show file tags in vim window
    use { "liuchengxu/vista.vim", cmd = "Vista" }


    -- >>> Visual-Mark
    -- 
    -- 安装 visualmark.vim 后，如果是在 Ubuntu 下做标记，会报一个“E197 不能设定语言为
    -- "en_US""的错误，但是在 Windows 下却不会。在网上找了一下，发现修复方法。
    -- 只要将exec ":lan mes en_US" 修改为 exec ":lan POSIX" 即可，为了能够在两个系统
    -- 中都能使用，于是修改了一下 visualmark.vim 源码，就是在 exec 外加了一个判断系统
    -- 的语句。本来还想直接上传一份供大家下载使用，才发现 Iteye 居然只能上传图像....
    -- 这里就提供具体修改方法：
    -- 使用文本编辑器打开 visualmark.vim
    -- 定位到
    -- exec ":lan mes en_US"
    -- 修改为
    -- if has("win32") || has("win95") || has("win64") || has("win16")
    --    exec ":lan mes en_US"
    -- else
    --    exec ":lan POSIX"
    -- endif
    -- 保存即可。
    -- 
    -- If you do not like the highlighting scheme, you could change "SignColor" in
    -- the script.  
    -- >>>>
    use ("vim-scripts/Visual-Mark")
    use ("vim-scripts/Mark")
    use ("Lokaltog/vim-easymotion")
    -- github copilot 
    use("github/copilot.vim")

    -- cscope支持
    use({
            "dhananjaylatkar/cscope_maps.nvim",
            requires = {
                {"folke/which-key.nvim"},
                {"nvim-telescope/telescope.nvim"},
                {"ibhagwan/fzf-lua"},
                {"nvim-tree/nvim-web-devicons"}
            },
            config = function()
                require("plugin-config.cscope_maps")
            end,
	})


    -- 熟练的使用ctags仅需记住下面七条命令：
    -- 1．$ctags –R * ($为Linux系统Shell提示符,这个命令上面已经有所介绍)
    -- 2. $ vi –t tag (请把tag替换为您欲查找的变量或函数名)
    -- 3．:ts(ts助记字：tagslist, “:”开头的命令为VI中命令行模式命令)
    -- 4．:tp(tp助记字：tagspreview)---此命令不常用，可以不用记
    -- 5．:tn(tn助记字：tagsnext) ---此命令不常用，可以不用记
    -- 6．Ctrl+ ]跳到光标所在函数或者结构体的定义处
    -- 7．Ctrl+ T返回查找或跳转
    -- “$vi –t tag” ：在运行vim的时候加上“-t”参数，例如：[/usr/src]$vim
    -- -t main这个命令将打开定义“main”（变量或函数或其它）的文件，并把光标定位
    -- 到这一行。如果这个变量或函数有多处定义，
    -- 在VI命令行模式 “：ts”命令就能列出一个列表供用户选择。
    -- “：tp”为上一个tag标记文件，
    -- “：tn”为下一个tag标记文件。
    -- 当然，若当前tags文件中用户所查找的变量或函数名只有一个，“:tp,:tn”命令不可用。
    -- （最方便的方法是把光标移到变量名或函数名上，然后按下“Ctrl+]”，这样就能
    -- 直接跳到这个变量或函数定义的源文件中，并把光标定位到这一行。用“Ctrl+T”
    -- 可以退回原来的地方。即使用户使用了N次“Ctrl+]”查找了N个变量，按N次
    -- “Ctrl+t”也能回到最初打开的文件，它会按原路返回
    -- 注意：运行vim的时候，必须在“tags”文件所在的目录下运行。
    -- 否则，运行vim的时候还要用“:set tags=”命令设定“tags”文件的路径，
    -- 这样vim才能找到“tags”文件。在完成编码时，可以手工删掉tags文件
    -- 
    -- 这个插件会自动创建tags文件，在大工程中会很慢，所以不用
    -- use("ludovicchabant/vim-gutentags")

    --[[ not work

    use({
      "mfussenegger/nvim-dap-python",
      requires = { "mfussenegger/nvim-dap" },
      config = function()
        require("dap-python").setup("/Users/nn/.local/share/nvim/mason/bin/debugpy")
      end,
    })

    --]]

    -- use("jbyuki/one-small-step-for-vimkind")
    --[[ use("dstein64/vim-startuptime") ]]

    if paccker_bootstrap then
      packer.sync()
    end
  end,
  config = {
    -- 锁定插件版本在snapshots目录
    snapshot_path = require("packer.util").join_paths(vim.fn.stdpath("config"), "snapshots"),
    -- 这里锁定插件版本在v1，不会继续更新插件
    -- snapshot = require("packer.util").join_paths(vim.fn.stdpath("config"), "snapshots") .. "/v1",
    -- snapshot = "v1",

    -- 最大并发数
    max_jobs = 10,
    -- 自定义源
    git = {
      -- default_url_format = "https://hub.fastgit.xyz/%s",
      -- default_url_format = "https://mirror.ghproxy.com/https://github.com/%s",
      -- default_url_format = "https://gitcode.net/mirrors/%s",
      -- default_url_format = "https://gitclone.com/github.com/%s",
    },
    -- display = {
    -- 使用浮动窗口显示
    --   open_fn = function()
    --     return require("packer.util").float({ border = "single" })
    --   end,
    -- },
  },
})
