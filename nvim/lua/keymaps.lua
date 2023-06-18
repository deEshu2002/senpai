-- quick save
vim.keymap.set('n', '<leader>s', function() vim.cmd('w') end, { desc = 'Quick Save' })
vim.keymap.set({'i', 'n'}, '<C-s>', function() vim.cmd('w') end, { desc = 'Quick Save' })

-- toggles
vim.keymap.set('n', '<leader>w', function() vim.cmd('set wrap!') end, { desc = 'Toggle [w]rap' })
vim.keymap.set('n', '<leader>ln', function() vim.cmd('set rnu!') end, { desc = '[Line] [N]umbers'})

-- move selected lines
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

-- search terms keep in middle
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

-- colors
vim.keymap.set('n', '<leader>tc', vim.cmd.ColorizerToggle, { desc = '[C]olorizer'})

-- copy current working path
vim.keymap.set('n', '<leader>cp', ':let @+=expand("%:p")<CR>', {noremap = true, silent = true})

vim.keymap.set('n', '<Leader>do', ':lua require("utils").open_definition_file()<CR>', { noremap = true })

-- generate docs
vim.keymap.set('n', '<leader>dg', vim.cmd.DogeGenerate, { desc = 'Generate Docs'})


