set number

set tabstop=2
set softtabstop=2
set shiftwidth=2

" diffsplit vertical
" https://stackoverflow.com/questions/5682759/how-do-i-toggle-between-a-vertical-and-a-horizontal-split-in-vimdiff
set diffopt+=vertical

map <silent><F4> :set relativenumber!<CR>

" Automatically remove trailing spaces
autocmd BufWritePre * :%s/\s\+$//e

let mapleader= ","

" https://blog.twofei.com/610/
" https://vim.fandom.com/wiki/Search_for_visually_selected_text
vnoremap // y/<c-r>"<cr>
"vnoremap / y/<c-r>"

vnoremap Rg y:Rg <c-r>"<cr>

call plug#begin('~/.vim/plugged')

" Use release branch (Recommend)
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" colorscheme
Plug 'morhetz/gruvbox'

" A tree explorer plugin for vim
Plug 'preservim/nerdtree'
map <silent><F8> :NERDTree<CR>


if has('mac') && system('arch') == "arm64"
	set rtp+=/opt/homebrew/opt/fzf
elseif has('mac')
	set rtp+=/usr/local/opt/fzf
elseif has('unix')
	set rtp+=/usr/bin/fzf
endif

Plug 'junegunn/fzf.vim'
map <c-o> :Buffers<CR>
map <c-p> :Files<CR>

" quickly move cursor, try ,,w
Plug 'Lokaltog/vim-easymotion'

" .editorconfig
Plug 'editorconfig/editorconfig-vim'

Plug 'vim-airline/vim-airline'
let g:airline_powerline_fonts = 1

" :Renamer
Plug 'vim-scripts/renamer.vim'

" markdown toc
" :GenTocGFM
" :GenTocRedcarpet
Plug 'mzlogin/vim-markdown-toc'
let g:vmt_auto_update_on_save = 0

" Vim syntax highlighting for Vue components.
Plug 'posva/vim-vue'
au BufNewFile,BufRead *.vue setf vue

" slim
Plug 'slim-template/vim-slim'

" indent guides
let g:indent_guides_guide_size = 1
Plug 'nathanaelkane/vim-indent-guides'
" indent guides shortcut
map <silent><F7>  <leader>ig

" tsx
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'

" Vim syntax for TOML
Plug 'cespare/vim-toml'

" nginx syntax highlighting
Plug 'chr4/nginx.vim'

" markdown support
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
let g:vim_markdown_folding_disabled = 1
" markdown preview
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

Plug 'APZelos/blamer.nvim'
map <silent><F9> :BlamerToggle<CR>

" Plug 'ianding1/leetcode.vim'
"let g:leetcode_china = 1
"let g:leetcode_solution_filetype = 'golang'
"let g:leetcode_browser = 'firefox'
" let g:leetcode_browser = 'disable'
" let g:leetcode_browser = 'chrome'

"Plug 'ryanoasis/vim-devicons'
"let g:webdevicons_enable_nerdtree = 1
"let g:webdevicons_conceal_nerdtree_brackets = 1
"set guifont=DroidSansMono\ Nerd\ Font\ 11
call plug#end()

" === theme gruvbox ===
colorscheme gruvbox
" Setting dark mode
set background=dark

nnoremap <silent> [oh :call gruvbox#hls_show()<CR>
nnoremap <silent> ]oh :call gruvbox#hls_hide()<CR>
nnoremap <silent> coh :call gruvbox#hls_toggle()<CR>

nnoremap * :let @/ = ""<CR>:call gruvbox#hls_show()<CR>*
nnoremap / :let @/ = ""<CR>:call gruvbox#hls_show()<CR>/
nnoremap ? :let @/ = ""<CR>:call gruvbox#hls_show()<CR>?

" === theme gruvbox ===

"colorscheme molokai

" transparent background
hi Normal ctermfg=252 ctermbg=none

" Coc
let g:coc_global_extensions = ['coc-tabnine', 'coc-json', 'coc-css', 'coc-tsserver', 'coc-go', 'coc-toml', 'coc-python', 'coc-solargraph', 'coc-markdownlint', 'coc-rust-analyzer']

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file.
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1):
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current line.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Introduce function text object
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <TAB> for selections ranges.
" NOTE: Requires 'textDocument/selectionRange' support from the language server.
" coc-tsserver, coc-python are the examples of servers that support it.
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings using CoCList:
" Show all diagnostics.
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

