-- lua/plugins/cmp.lua
local cmp = require("cmp")
local ls = require("luasnip")

-- Load snippets from friendly-snippets
require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({
    snippet = {
        expand = function(args)
            ls.lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ["<CR>"] = cmp.mapping.confirm({ select = false }),
        ["<Tab>"] = cmp.mapping.confirm({ select = false }),
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-c>"] = cmp.mapping.abort(),
    }),
    sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "orgmode" },
        { name = "buffer" },
        { name = "path" },
        { name = "crates" },
    }),
    window = {
        completion = cmp.config.window.bordered({
            border = "rounded",
        }),
        documentation = cmp.config.window.bordered({
            border = "rounded",
        }),
    },
})

cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline({
        ['<C-n>'] = { c = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }) },
        ['<C-p>'] = { c = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }) },
    }),
    sources = cmp.config.sources({
        { name = 'path' },
        { name = 'cmdline' }
    }),
})

cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline({
        ['<C-n>'] = { c = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }) },
        ['<C-p>'] = { c = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }) },
    }),
    sources = {
        { name = 'buffer' }
    },
})
