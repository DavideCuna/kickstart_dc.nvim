return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-buffer",       -- completamenti da buffer
    "hrsh7th/cmp-path",         -- completamenti file/path
    "hrsh7th/cmp-nvim-lsp",     -- completamenti da LSP
    "hrsh7th/cmp-nvim-lua",     -- completamenti Lua/Neovim
    "L3MON4D3/LuaSnip",         -- snippets
    "saadparwaiz1/cmp_luasnip", -- integra snippets con cmp
    "octaltree/cmp-look",       -- opzionale: completamenti da dizionario
  },
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")

    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = {
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.confirm({ select = true }) -- conferma la prima suggestion
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<C-p>"] = cmp.mapping.select_prev_item(),
      },
      sources = cmp.config.sources({
        { name = "nvim_lsp" },   -- utile per LaTeX (es. texlab)
        { name = "luasnip" },    -- snippets per LaTeX/Markdown
        { name = "buffer" },     -- buffer attuale
        { name = "path" },       -- completamenti path
      }),
      experimental = {
        ghost_text = true,       -- mostra preview testo completamento inline
      },
    })

    -- Config specifica per filetype
    cmp.setup.filetype("markdown", {
      sources = cmp.config.sources({
        { name = "luasnip" },
        { name = "buffer" },
        { name = "path" },
      })
    })

    cmp.setup.filetype("tex", {
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "buffer" },
        { name = "path" },
      })
    })
  end,
}
