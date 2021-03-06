
func! sneak#hl#removehl() "remove highlighting
  silent! call matchdelete(w:sneak_hl_id)
  silent! call matchdelete(w:sneak_sc_hl)
endf

" gets the 'links to' value of the specified highlight group, if any.
"   https://github.com/osyo-manga/vim-over/blob/d8819448fc4074342abd5cb6cb2f0fff47b7aa22/autoload/over/command_line.vim#L225
func! sneak#hl#links_to(hlgroup)
  redir => hl | exec 'silent highlight '.a:hlgroup | redir END
  let s = substitute(matchstr(hl, 'links to \zs.*'), '\s', '', 'g')
  return empty(s) ? 'NONE' : s
endf

func! sneak#hl#is_valid(hlgroup) "avoid junk like 'Cursor xxx cleared'
  redir => hl | exec 'silent highlight '.a:hlgroup | redir END
  return !empty(matchstr(hl, '\%(.*xxx\)\?\%(.*cleared\)\?\s*\zs.*'))
endf

if 0 == hlID("SneakPluginTarget")
  highlight SneakPluginTarget guifg=white guibg=magenta ctermfg=white ctermbg=magenta
endif

if 0 == hlID("SneakStreakMask")
  highlight SneakStreakMask guifg=magenta guibg=magenta ctermfg=magenta ctermbg=magenta
endif

if 0 == hlID("SneakPluginScope")
  if &background ==# 'dark'
    highlight SneakPluginScope guifg=black guibg=white ctermfg=black ctermbg=white
  else
    highlight SneakPluginScope guifg=white guibg=black ctermfg=white ctermbg=black
  endif
endif

if 0 == hlID("SneakStreakTarget")
  highlight SneakStreakTarget guibg=magenta guifg=white gui=bold ctermbg=magenta ctermfg=white cterm=bold
endif

if 0 == hlID("SneakStreakStatusLine")
  highlight link SneakStreakStatusLine SneakStreakTarget
endif

if sneak#hl#is_valid('Cursor')
  highlight link SneakStreakCursor Cursor
else
  highlight link SneakStreakCursor SneakPluginScope
endif
