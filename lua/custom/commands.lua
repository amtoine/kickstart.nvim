vim.cmd([[
  autocmd TermOpen * startinsert
]])

vim.cmd([[
  set hlsearch
]])

vim.cmd([[
  " Tell Vim which characters to show for expanded TABs,
  " trailing whitespace, and end-of-lines. VERY useful!
  set listchars=tab:>\·,trail:\ ,extends:>,precedes:<,nbsp:+

  " Show problematic characters.
  set list

  " Also highlight all tabs and trailing whitespace characters.
  highlight ExtraWhitespace ctermbg=darkred guibg=darkred
  match ExtraWhitespace /\s\+$\|\t/
]])
