set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}

" Yet Another JavaScript Syntax
Plugin 'othree/yajs.vim'

" HTML5 + inline SVG omnicomplete function, indent and syntax for Vim.
Plugin 'othree/html5.vim'

" The React syntax highlighting and indenting plugin for vim.
Plugin 'maxmellon/vim-jsx-pretty'

" Opinionated code formatter
Plugin 'prettier/vim-prettier', { 'do': 'yarn install' }

" Проверка на синтаксисические и семантические ошибки
Plugin 'https://github.com/dense-analysis/ale'

" Insert or delete brackets, parens, quotes in pair
Plugin 'jiangmiao/auto-pairs'

" Плагин Emmet
Plugin 'mattn/emmet-vim'

" Подсветка
Plugin 'mhartington/oceanic-next'


" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" Настройки табов для Python, согласно рекоммендациям
<<<<<<< HEAD
autocmd FileType python setlocal expandtab shiftwidth=4 tabstop=8 softtabstop=4 smarttab 
" Общие настройки табов
set tabstop=2 
set shiftwidth=2
set smarttab
set expandtab "Ставим табы пробелами
set softtabstop=2 "2 пробела в табе

=======
set tabstop=4 
set shiftwidth=4
set smarttab
set expandtab "Ставим табы пробелами
set softtabstop=4 "4 пробела в табе
>>>>>>> 3dca4f11c97000933c9fa00490375662b1d08b70
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
autocmd BufEnter * if expand("%:p:h") !~ '^/tmp' | silent! lcd %:p:h | endif
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
endfunction

imap <tab> <c-r>=InsertTabWrapper()<cr>

set complete=""
set complete+=.
set complete+=b
set complete+=t

" Плагин ALE
nnoremap ]r :ALENextWrap<CR>     " move to the next ALE warning / error
nnoremap [r :ALEPreviousWrap<CR> " move to the previous ALE warning / error
noremap <leader>a :ALEToggle<CR>
let g:ale_enabled = 0

" Плагин Prettier
" Замена команды :Prettier на комбинацию клавиш gp
nnoremap gp :silent %!prettier --stdin-filepath %<CR>

let g:netrw_winsize = 25 " размер окна открываемое через команду Explore
