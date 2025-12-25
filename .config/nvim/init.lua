-- numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- allows to save undos when exiting a file
vim.opt.undofile = true

-- window splitting makes sense
vim.opt.splitbelow = true
vim.opt.splitright = true

-- maps leader to space
vim.g.mapleader = " "

--  controversial tabspacing
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 0 -- set to 0 to default to tabstop value

-- 

-- lazyvim block -------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)
---- plugins block ----------
require("lazy").setup({
    --fzf
        {
        "https://github.com/junegunn/fzf.vim",
        dependencies = {
            "https://github.com/junegunn/fzf",
        },
        keys = {
            { "<Leader><Leader>", "<Cmd>Files<CR>", desc = "Find files" },
            { "<Leader>,", "<Cmd>Buffers<CR>", desc = "Find buffers" },
            { "<Leader>/", "<Cmd>Rg<CR>", desc = "Search project" },
        },
    },
    --oil
        {
        "https://github.com/stevearc/oil.nvim",
        config = function()
            require("oil").setup()
        end,
        keys = {
            { "-", "<Cmd>Oil<CR>", desc = "Browse files from here" },
        },
    },
    -- autoclose vrackets
        {
        "https://github.com/windwp/nvim-autopairs",
        event = "InsertEnter", -- Only load when you enter Insert mode
        config = function()
            require("nvim-autopairs").setup()
        end,
    },
    -- comment.nvim. "gc" to toggle comments
        {
        "https://github.com/numToStr/Comment.nvim",
        event = "VeryLazy", -- Special lazy.nvim event for things that can load later and are not important for the initial UI
        config = function()
            require("Comment").setup()
        end,
    },
    --treesitter
    { 'nvim-treesitter/nvim-treesitter',
        lazy = false,
        build = ':TSUpdate'
    },
    -- intellisense uzing lsp zerp, mason, lspconfig, cmp.
    -- ctrl-n next suggestion
    -- ctrl-p previous suggestion
    -- ctrl-y yes to suggestion
    -- ctrl-e exit to suggestion
    -- g-d go to definition
    -- g-i go to implementation
    {
        "https://github.com/VonHeikemen/lsp-zero.nvim",
        dependencies = {
            "https://github.com/williamboman/mason.nvim",
            "https://github.com/williamboman/mason-lspconfig.nvim",
            "https://github.com/neovim/nvim-lspconfig",
            "https://github.com/hrsh7th/cmp-nvim-lsp",
            "https://github.com/hrsh7th/nvim-cmp",
            "https://github.com/L3MON4D3/LuaSnip",
        },
        config = function()
            local lsp_zero = require('lsp-zero')

            lsp_zero.on_attach(function(client, bufnr)
                lsp_zero.default_keymaps({buffer = bufnr})
            end)

            require("mason").setup()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    -- See https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
                    "gopls", -- Go
                    "pyright", -- Python
                    "rust_analyzer", -- Rust
                },
                handlers = {
                    lsp_zero.default_setup,
                },
            })
        end,
    },
    -- THEMES ---------------------------------------------
    -- ayu (mirage)
    {
        "Shatur/neovim-ayu",
        lazy = false,    
        priority = 1000,
        config = function()
            require("ayu").setup({
                mirage = false, 
            })
            vim.cmd.colorscheme("ayu")
        end,
    },
})
