filetype off " required
" Specify a directory for plugins
call plug#begin('~/.vim/plugged')

" Fugitive is :Git (or just :G), which calls any arbitrary Git command.
Plug 'tpope/vim-fugitive'
" tpope/vim-commentary: comment stuff out.
Plug 'tpope/vim-commentary'
" fzf is a general-purpose command-line fuzzy finder.
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" Insert or delete brackets, parens, quotes in pair
Plug 'jiangmiao/auto-pairs'

" Yet Another JavaScript Syntax
Plug 'othree/yajs.vim'
" HTML5 + inline SVG omnicomplete function, indent and syntax for Vim.
Plug 'othree/html5.vim'
" The React syntax highlighting and indenting plugin for vim.
Plug 'maxmellon/vim-jsx-pretty'
" Javascript and Typescript vim snippets for developing React applications.
Plug 'SirVer/ultisnips'
Plug 'mlaursen/vim-react-snippets'
" Opinionated code formatter
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
" Проверка на синтаксисические и семантические ошибки
Plug 'https://github.com/dense-analysis/ale'
" Плагин Emmet
Plug 'mattn/emmet-vim'
" Подсветка
Plug 'mhartington/oceanic-next'

" Initialize plugin system
call plug#end()
filetype plugin indent on    " required

" Настройки табов для Python, согласно рекоммендациям
autocmd FileType python setlocal expandtab shiftwidth=4 tabstop=8 softtabstop=4 smarttab 
" Общие настройки табов
set tabstop=2 
set shiftwidth=2
set smarttab
set expandtab "Ставим табы пробелами
set softtabstop=2 "2 пробела в табе

" Автоотступ
set autoindent
" Подсвечиваем все что можно подсвечивать
let python_highlight_all = 1
" Включаем 256 цветов в терминале, мы ведь работаем из иксов?
" Нужно во многих терминалах, например в gnome-terminal
set t_Co=256

" Перед сохранением вырезаем пробелы на концах (только в .py файлах)
autocmd BufWritePre *.py normal m`:%s/\s\+$//e ``
" В .py файлах включаем умные отступы после ключевых слов
autocmd BufRead *.py set smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class

syntax on "Включить подсветку синтаксиса

" Устанавливает рабочую папку в месте открытия файла 
set autochdir
"set nu "Включаем нумерацию строк
set number relativenumber " релятивная нумерация
set mousehide "Спрятать курсор мыши когда набираем текст
set mouse=a "Включить поддержку мыши
set termencoding=utf-8 "Кодировка терминала
set novisualbell "Не мигать 
set t_vb= "Не пищать! (Опции 'не портить текст', к сожалению, нету)
" Удобное поведение backspace
set backspace=indent,eol,start whichwrap+=<,>,[,]
" Вырубаем черточки на табах
set showtabline=1

" Переносим на другую строчку, разрываем строки
set wrap
set linebreak

" Вырубаем .swp и ~ (резервные) файлы
set nobackup
set noswapfile
set encoding=utf-8 " Кодировка файлов по умолчанию
set fileencodings=utf8,cp1251

set clipboard=unnamed
set ruler

set hidden
nnoremap <C-N> :bnext<CR>
nnoremap <C-P> :bprev<CR>

let g:netrw_liststyle = 3 " netrw древовидный вид (Можно менять нажатием i в netrw)
let g:netrw_banner = 0 " Убрать подсказку
let g:netrw_winsize = 30 " размер окна открываемое через команду Explore

" OceanicNext color for vim 8
if (has("termguicolors"))
  set termguicolors
endif
colorscheme OceanicNext

" Выключаем звук в Vim
set visualbell t_vb=

"split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Игнорировать верхний регистр при поиске
set ignorecase
" Vim будет искать любую комбинацию верхнего и нижнего регистра текста
set smartcase

" Складки
set foldmethod=manual
:nnoremap <space> za

"Шорткат на переключение между закладками
noremap <A-j> gT
"Alt-k to move to the tab to the right
noremap <A-k> gt

"Сделать автодополнение на Tab
function InsertTabWrapper()
  let col=col('.') - 1
  if !col || getline('.')[col - 1] !~ '\k'
    return "\<tab>"
  else
    return "\<c-p>"
  endif
endfunction
inoremap <expr> <tab> InsertTabWrapper()
inoremap <s-tab> <c-n>

set complete=""
set complete+=.
set complete+=b
set complete+=t

" Команда :make (если в текущем каталоне нет файла Makefile, перейти в родительский каталог)
fun! SetMkfile()
  let filemk = "Makefile"
  let pathmk = "./"
  let depth = 1
  while depth < 4
    if filereadable(pathmk . filemk)
      return pathmk
    endif
    let depth += 1
    let pathmk = "../" . pathmk
  endwhile
  return "."
endf
command! -nargs=* Make tabnew | let $mkpath = SetMkfile() | make <args> -C $mkpath | cwindow 10

" Плагин ALE
nnoremap ]r :ALENextWrap<CR>     " move to the next ALE warning / error
nnoremap [r :ALEPreviousWrap<CR> " move to the previous ALE warning / error
noremap <leader>a :ALEToggle<CR>
let g:ale_enabled = 0

" Плагин Prettier. Замена команды :Prettier на комбинацию клавиш gp
nnoremap gp :silent %!prettier --stdin-filepath %<CR>

" Плагин FZF (FZF.vim)
nmap ; :Buffers<CR>
nmap <Leader>f :Files<CR>
nmap <Leader>t :Tags<CR>
