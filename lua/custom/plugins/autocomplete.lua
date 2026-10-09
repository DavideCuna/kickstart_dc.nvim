-- lua/user/plugins.lua

-- Helper per semplificare la scrittura (usa quello che hai in init.lua)
local function gh(repo) return 'https://github.com/' .. repo end

-- 1. Installazione di tutti i pezzi necessari
local plugins = {
  gh 'hrsh7th/nvim-cmp',
  gh 'hrsh7th/cmp-buffer',
  gh 'hrsh7th/cmp-path',
  gh 'hrsh7th/cmp-nvim-lsp',
  gh 'hrsh7th/cmp-nvim-lua',
  gh 'L3MON4D3/LuaSnip',
  gh 'saadparwaiz1/cmp_luasnip',
  gh 'octaltree/cmp-look',
}

vim.pack.add(plugins)

-- 2. Configurazione (che rimane identica a quella che avevi)
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
        cmp.confirm({ select = true })
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
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "buffer" },
    { name = "path" },
  }),
  experimental = {
    ghost_text = true,
  },
})

-- Le tue configurazioni filetype restano valide
cmp.setup.filetype("markdown", {
  sources = cmp.config.sources({ { name = "luasnip" }, { name = "buffer" }, { name = "path" } })
})

cmp.setup.filetype("tex", {
  sources = cmp.config.sources({ { name = "nvim_lsp" }, { name = "luasnip" }, { name = "buffer" }, { name = "path" } })
})
