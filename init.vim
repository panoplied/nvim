" Description: init.vim + nvim-plug configuration
" Author: tigr aka panoplied <panoplied@yandex.ru>
" URL: https://github.com/panoplied/nvim
" Thanks: miripiruni

" Nvim >= 0.3.4 required, >= 4.0.0 best
" Recommended options for plugins marked with plugins name as [plug]


" EDITOR SETTINGS ============================================================

set fileformat=unix     " Add LF in the end of files
set number              " Turn on line numbers
set title               " Set title of the window to the filename
set mouse=a             " Enable mouse in all modes
set termguicolors       " True color support
set scrolloff=5         " Minimum number of lines to keep above and below the cursor
set list                " Display invisible characters
set listchars=tab:»\ ,trail:·,extends:>,precedes:<,nbsp:_
set smartindent         " Do smart indent when starting a new line
set expandtab           " Use spaces instead of tab for indentation
set softtabstop=4       " Number of spaces tab counts for editing operations
set shiftwidth=4        " Number of spaces used for indentation
set noshowmode          " [airline] Don't display mode in command line, it's already displayed by airline
set hidden              " [coc.nvim] Hide buffers instead of closing them
set nobackup            " [coc.nvim] Some language servers have issues with backup files
set nowritebackup
set cmdheight=2         " [coc.nvim] Better display for messages
set updatetime=25       " [coc.nvim] Better update time for diagnostic messages (bad on default's 4000)
set shortmess+=c        " [coc.nvim] Don't give ins-completion-menu messages
set signcolumn=yes      " [coc.nvim] Always show signcolumns

" Remap russian keys
set langmap=ёйцукенгшщзхъфывапролджэячсмитьбюЁЙЦУКЕHГШЩЗХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮ;`qwertyuiop[]asdfghjkl\\;'zxcvbnm\\,.~QWERTYUIOP{}ASDFGHJKL:\\"ZXCVBNM<>


" EDITOR CUSTOM SHORTCUTS ====================================================

" Navigate split with Ctrl + vimkeys
nnoremap <C-h> <C-W>h
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-l> <C-W>l


" VIM PLUG ===================================================================

" Manual: https://github.com/junegunn/vim-plug

" Set plugin path and initialize plugins
call plug#begin(stdpath('data') . '/plugged')

" Coc extension https://github.com/neoclide/coc.nvim/wiki/Using-coc-extensions
Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle'}
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-fugitive'

" Color schemes
Plug 'morhetz/gruvbox'

" Dev Icons (always must be loaded last)
Plug 'ryanoasis/vim-devicons'

call plug#end()


" PLUGIN SETTINGS ============================================================


" COC.NVIM

" Enable jsonc comments highlight for :CocConfig (and for all .jsonc btw)
autocmd FileType json syntax match Comment +\/\/.\+$+

" Don't forget about the extensions. Prefer to install them manually, not every machine needs all of the list.
" Install by :CocInstall <ExtensionName>
" Note that every extension has a github repo with docs for RTMF.

" coc-yank          - Yank highlight and persist yank history support
" coc-eslint        - Eslint extension for coc.nvim (requires setting up Eslint in the npm project)
" coc-git           - Git integration, but not fully impleneted so at the same vim-fugitive is a must to use
" coc-highlight     - Document highlight and document colors support
" coc-xml           - Fork of vscode-xml, provides support for creating and edinting XML files
" coc-snippets      - Snippets solution for coc.nvim, provides broad selection of snippet plugins
" coc-prettier      - Fork of prettier-vscode, formatter for JS/TS/CSS/JSON using Prettier
" coc-marketplace   - Markeplace to simplify search and installation of coc extenstions
" coc-emmet         - Fork of emmet from vscode, works just as there
" coc-pairs         - Auto pairs support, work as in vscode
" coc-markdownlint  - Markdown files linter
" coc-python        - Fork of vscode-python, still in work, see extension's repo for support
" coc-json          - JSON language extension, uses vscode-json-languageserver
" coc-tslint-pugin  - Fork of vscode-typescript-tslint-plugin
" coc-tsserver      - Most of the code is from typescript-language-features extension which is bundled with VSCode.
" coc-vetur         - Vue language server extension: completion, refactor, linting etc.
" coc-html          - HTML language server extension
" coc-css           - CSS language server extension

" Key mappings

" Use tab for trigger completion with characters ahead and navigate.
" Use ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <C-d> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <C-d> <Plug>(coc-range-select)
xmap <silent> <C-d> <Plug>(coc-range-select)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

" Use <CR> to confirm completion
" Also required for proper fomatting pairs and resetting cursor position
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"


" NERDTREE

" NERDTreeToggle on Ctrl+N
map <C-n> :NERDTreeToggle<CR>
" miripiruni: nnoremap <Bs> :<C-u>NERDTreeToggle<CR>

" Disable display of the 'Bookmarks' label and 'Press ? for help' text
let NERDTreeMinimalUI=1

" Use arrows instead of + ~ chars when displaying directories (overriden by devicons anyway)"
let NERDTreeDirArrows=1


" AIRLINE

" Set airline to use powerline font (to look nice) (https://github.com/powerline/fonts)
" Debian got this by the way: 'sudo apt install fonts-powerline'
let g:airline_powerline_fonts=1


" GRUVBOX

" https://github.com/morhetz/gruvbox
let g:gruvbox_contrast_dark='hard'
let g:gruvbox_bold=1
let g:gruvbox_underline=1
let g:gruvbox_termcolors=1
let g:gruvbox_improved_strings=1
let g:gruvbox_improved_warnings=1
set background=dark
colorscheme gruvbox


" TODO
" - Connect FZF for fuzzy file search, set up to work with ripgrep.
" - Set up C/C++ language server for coc.nvim
