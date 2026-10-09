-- 1. Installazione
vim.pack.add {
  gh 'vague-theme/vague.nvim',
}

-- 2. Configurazione e caricamento
require('vague').setup {
  -- Inserisci qui le tue opzioni personalizzate, se ne hai
}
vim.cmd 'colorscheme vague'
