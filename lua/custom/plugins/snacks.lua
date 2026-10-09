vim.pack.add {
  'https://github.com/folke/snacks.nvim.git',
  'https://github.com/nvim-mini/mini.icons.git',
}

-- 2. Configurazione (Dashbord pulito senza lazy.nvim)
require('snacks').setup({
  bigfile = { enabled = true },
  dashboard = {
    enabled = true,
    sections = {
      { section = "header" },
      -- Configurazione esplicita per evitare che cerchi lazy.nvim
      {
        section = "keys",
        gap = 1,
        padding = 1,
        keys = {
          { icon = " ", title = "Keymaps", section = "keys", indent = 2, padding = 1 },
          { icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
          { icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
        },
      },
    },
  },
  indent = { enabled = true },
  input = { enabled = true },
  git = { enabled = true },
  picker = { enabled = true },
  notifier = { enabled = true },
  quickfile = { enabled = true },
  scroll = { enabled = false },
  statuscolumn = { enabled = true },
  words = { enabled = true },
})

-- 3. Mappature
local map = vim.keymap.set
map('n', '<leader>sf', function() Snacks.scratch() end, { desc = "Toggle Scratch Buffer" })
map('n', '<leader>S',  function() Snacks.scratch.select() end, { desc = "Select Scratch Buffer" })
map('n', '<leader>gl', function() Snacks.lazygit.log_file() end, { desc = "Lazygit Log (cwd)" })
map('n', '<leader>lg', function() Snacks.lazygit() end, { desc = "Lazygit" })
map('n', '<C-p>',      function() Snacks.picker.pick("files") end, { desc = "Find Files" })
map('n', '<leader><leader>', function() Snacks.picker.recent() end, { desc = "Recent Files" })
map('n', '<leader>fb', function() Snacks.picker.buffers() end, { desc = "Buffers" })
map('n', '<leader>fg', function() Snacks.picker.grep() end, { desc = "Grep Files" })
map('n', '<C-n>',      function() Snacks.explorer() end, { desc = "Explorer" })
