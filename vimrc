"""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax on                " Enable syntax highlighting
set number               " Show line numbers
"set relativenumber       " Show relative line numbers
filetype plugin on       " Enable filetype plugins
set tabstop=4            " Number of spaces that a <Tab> in the file counts for
set softtabstop=4        " See above
set expandtab            " Converts tabs to spaces
set shiftwidth=4         " Width for autoindents
set smartindent          " Enable smart indent
set nocursorline         " Disable the cursor line
set noswapfile           " Disable swap file creation
set nobackup             " Disable backup file creation
set undodir=~/.vim/undodir " Set an undo directory
set undofile             " Enable undo file feature
set incsearch            " Make search more interactive
set hlsearch             " Highlight search results
set backspace=2          " Allow backspacing over everything in insert mode
let mapleader = ","

set nocompatible              " required
filetype off                  " required

set ruler
set ignorecase
set smartcase
"""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim Plug Setup
"""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin('~/.vim/plugged')

"""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'junegunn/fzf'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'preservim/nerdcommenter'
Plug 'vim-syntastic/syntastic'
Plug 'nvie/vim-flake8'
Plug 'mhinz/vim-grepper'
Plug 'tell-k/vim-autopep8'
Plug 'psf/black'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-vinegar'
Plug 'jlanzarotta/bufexplorer'
Plug 'github/copilot.vim'
Plug 'duff/vim-scratch'
Plug 'vim-airline/vim-airline'
" Paper Color theme is no longer managed as a plugin
" but rather as submodule in Dotfiles project, and 
" statically linked.
"Plug 'NLKNguyen/papercolor-theme'
Plug 'flazz/vim-colorschemes'
Plug 'vim-scripts/ScrollColors'
Plug 'tpope/vim-obsession'
Plug 'mhinz/vim-startify'
Plug 'tpope/vim-dadbod'

" Previous color schemes that have been discarded for now
"Plugin 'dracula/vim', { 'name': 'dracula' }
"Plugin 'jnurmine/Zenburn'

filetype plugin on

" All of your Plugins must be added before the following line
call plug#end()
filetype plugin indent on    " required
"""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""
" FZF (Fuzzy File Finder) settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <C-p> :<C-u>FZF<CR>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Grepper settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Configure ripgrep (rg) specific settings
let g:grepper       = {}
let g:grepper.tools = ['rg', 'grep']

" Configure ripgrep (rg) specific settings
let g:grepper.rg = {
            \ 'grepprg': 'rg --vimgrep -L'
            \ }

nnoremap <Leader>* :Grepper -cword -noprompt<CR>

" Normal mode mapping to search for yanked text
"nnoremap <Leader>g :Grepper -noprompt -query @"
" Visual mode mapping to search for selected text
"xnoremap <Leader>g :<C-u>Grepper -noprompt -query <C-r>x<CR>
"xnoremap <Leader>g :<C-u>Grepper -noprompt -query rg -H --no-heading --vimgrep><C-r>x<CR>
"noremap <Leader>g :<C-u>Grepper -noprompt -query><C-r>x<CR>

"xnoremap <Leader>g :<C-u>Grepper -noprompt -query <C-r><C-o>"<CR>

" Search for the current selection
"nmap gs <plug>(GrepperOperator)
"xmap gs <plug>(GrepperOperator)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""
" coc settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

nmap <leader>rn <Plug>(coc-rename)
nmap <leader>ac <Plug>(coc-codeaction)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Various mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""
noremap <leader>l :noh <CR>
noremap <leader>s :Obsession<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Trying to map global buffer copy/paste
"""""""""""""""""""""""""""""""""""""""""""""""""""""""
set clipboard=unnamed  " Copy into system (*) register
" Because of the former line, the following mappings
" are not needed
"vnoremap <leader>y "*y
"inoremap <leader>p "*p
"""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""
" What plugin?
"""""""""""""""""""""""""""""""""""""""""""""""""""""""
inoremap <expr> j pumvisible() ? "\C-n>" : "j"
inoremap <expr> k pumvisible() ? "\C-p>" : "k"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Colors
"""""""""""""""""""""""""""""""""""""""""""""""""""""""
set t_Co=256
"color molokai
"colorscheme industry
colorscheme PaperColor
set background=dark
"let g:molokai_original = 1
let g:rehash256 = 1

"if has('gui_running')
  "set background=dark
  "colorscheme solarized
"else
  "colorscheme zenburn
"endif

" Scroll Colors:
map <silent><F3> :NEXTCOLOR<cr>
map <silent><F2> :PREVCOLOR<cr>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Black config
"""""""""""""""""""""""""""""""""""""""""""""""""""""""
command! Black !black %
nnoremap <leader>b :!black %<CR>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Window and buffer management
"""""""""""""""""""""""""""""""""""""""""""""""""""""""
"split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
" Window Movement
" Move window to the bottom
nnoremap <Leader>mb :wincmd J<CR>
" Move window to the top
nnoremap <Leader>mt :wincmd K<CR>
" Move window to the right
nnoremap <Leader>mr :wincmd L<CR>
" Move window to the left
nnoremap <Leader>ml :wincmd H<CR>
" Buffer navigation
nnoremap <Leader>b :buffers<CR>:buffer<Space>
nnoremap <Leader>v :vertical sb
" File Explorer
nnoremap <Leader>d :Lex<CR>
" Make window the only window
nnoremap <Leader>o :only<CR>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable folding
"""""""""""""""""""""""""""""""""""""""""""""""""""""""
set foldmethod=indent
set foldlevel=99

"""""""""""""""""""""""""""""""""""""""""""""""""""""""
" for better file exploring
set wildmenu                    " Enable enhanced tab autocomplete.
set wildmode=list:longest,full  " Complete till longest string,
                                " then open the wildmenu.
"""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Scratch file shortcut
"""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <Leader>sc :Scratch<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Automatic searching
"""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <Leader>f /<C-R><C-W><CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Misc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""
let python_highlight_all=1
nnoremap <SPACE> <Nop>
" Ensure status line remains in place
set laststatus=2
"set statusline=%<%t%h%m%r\ \ %a\ %{strftime(\"%c\")}%=0x%B\ \ line:%l,\ \ col:%c%V\ %P\ %v
set showcmd

" Quick Fix Window height
" Don't foret :resize N can be called
" to change the height of the quickfix window
autocmd FileType qf setlocal winheight=25

" Set visual mode highlight color after the color scheme is loaded
" This was a previous workaround before switching to the PaperColor theme
"autocmd VimEnter * highlight Visual ctermbg=white ctermfg=black guibg=DarkGrey guifg=white

"""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Run this command after re-sourcing the .vimrc file, lest the
" custom highlighting gets overridden:
" :highlight Visual ctermbg=white ctermfg=black guibg=DarkGrey guifg=white

"""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""
