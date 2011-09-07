filetype off

call pathogen#runtime_append_all_bundles()

set nocompatible

set showbreak=...
set wrap linebreak nolist
set fo=l

set history=1000 " Define o historico do vi com 1000 comandos
set showcmd     " mostra os comandos
set showmode    " mostra o modo de comandos
set incsearch   " mostra a proxima sequencia encontrada pela pesquisa digitada
set hlsearch    " mostra a pesquisa com outra cor


" Theme enabling
 syntax enable
 colorscheme adam
" set background=dark

" Indentation
set softtabstop=4
set tabstop=4
set shiftwidth=4
set expandtab
set autoindent
set shiftround
set backspace=indent,eol,start
set linespace=4
set foldmethod=indent   "fold based on indent
set foldnestmax=3       "deepest fold is 3 levels
set nofoldenable        "dont fold by default


" Mapeamento de teclas
vmap <D-j> gj
vmap <D-k> gk
vmap <D-4> g$
vmap <D-6> g^
vmap <D-0> g^
nmap <D-j> gj
nmap <D-k> gk
nmap <D-4> g$
nmap <D-6> g^
nmap <D-0> g^
nmap <Down> gj
nmap <Up> gk

" Scrolling
set scrolloff=5
set nowrap
set ttyfast
set sidescrolloff=7
set sidescroll=1


" Encoding
set encoding=utf-8

" Name completion
set wildmenu
set wildmode=list:longest

" On screen information
set ruler
set number
set foldmethod=marker

set statusline=%f
set statusline+=%{GitBranch()}
" set statusline+=%{exists('g:loaded_rvm#statusline():')}
set statusline+=%=
set statusline+=%c,
set statusline+=%l
" set statusline+=/%L
set statusline+=\ %P
set statusline+=
set laststatus=2

set guioptions-=T

autocmd cursorhold,bufwritepost * unlet! b:statusline_trailing_space_warning

function! StatuslineTrailingSpaceWarning()
    if !exists("b:statusline_trailing_space_warning")
        if search('\s\+$', 'nw') != 0
            let b:statusline_trailing_space_warning = '[\s]'
        else
            let b:statusline_trailing_space_warning = ''
        endif
    endif
    return b:statusline_trailing_space_warning
endfunction

function! StatuslineCurrentHighlight()
    let name = synIDattr(synID(line('.'),col('.'),1),'name')
    if name == ''
        return ''
    else
        return '[' . name . ']'
    endif
endfunction

autocmd cursorhold,bufwritepost * unlet! b:statusline_tab_warning

function! StatuslineTabWarning()
    if !exists("b:statusline_tab_warning")
        let tabs = search('^\t', 'nw') != 0
        let spaces = search('^ ', 'nw') != 0

        if tabs && spaces
            let b:statusline_tab_warning =  '[mixed-indenting]'
        elseif (spaces && !&et) || (tabs && &et)
            let b:statusline_tab_warning = '[&et]'
        else
            let b:statusline_tab_warning = ''
        endif
    endif
    return b:statusline_tab_warning
endfunction

autocmd cursorhold,bufwritepost * unlet! b:statusline_long_line_warning

function! StatuslineLongLineWarning()
    if !exists("b:statusline_long_line_warning")
        let long_line_lens = s:LongLines()

        if len(long_line_lens) > 0
            let b:statusline_long_line_warning = "[" .
                        \ '#' . len(long_line_lens) . "," .
                        \ 'm' . s:Median(long_line_lens) . "," .
                        \ '$' . max(long_line_lens) . "]"
        else
            let b:statusline_long_line_warning = ""
        endif
    endif
    return b:statusline_long_line_warning
endfunction

function! s:LongLines()
    let threshold = (&tw ? &tw : 80)
    let spaces = repeat(" ", &ts)

    let long_line_lens = []

    let i = 1
    while i <= line("$")
        let len = strlen(substitute(getline(i), '\t', spaces, 'g'))
        if len > threshold
            call add(long_line_lens, len)
        endif
        let i += 1
    endwhile

    return long_line_lens
endfunction

function! s:Median(nums)
    let nums = sort(a:nums)
    let l = len(nums)

    if l % 2 == 1
        let i = (l-1) / 2
        return nums[i]
    else
        return (nums[l/2] + nums[(l/2)-1]) / 2
    endif
endfunction

set wildmode=list:longest   "make cmdline tab completion similar to bash
set wildmenu                "enable ctrl-n and ctrl-p to scroll thru matches
set wildignore=*.o,*.obj,*~ "stuff to ignore when tab completing

set formatoptions-=o "dont continue comments when pushing o/O
filetype plugin on
filetype indent on
set mouse=a
set ttymouse=xterm2

set hidden

" Sets 2-spaces indentation for Ruby
" autocmd Filetype ruby setlocal ts=2
" autocmd Filetype ruby setlocal ts=2
" autocmd Filetype ruby setlocal sts=2

" fn + F1 - syntastic
" nnoremap <silent> <F1> :Errors<cr>		
" inoremap <silent> <F1> <esc>:Errors<cr>

" fn + F2 - NERDTree
" nnoremap <silent> <F2> :NERDTreeToggle<cr>
" inoremap <silent> <F2> <esc>:NERDTreeToggle<cr>

" let g:syntastic_auto_loc_list=1
" let g:syntastic_enable_signs=1

let g:CommandTMaxHeight=10
let g:CommandTMatchWindowAtTop=1

if has("gui_running")
    set t_Co=256

    colorscheme railscasts
    set guitablabel=%M%t
    set lines=40
    set columns=115

    if has("gui_gnome")
        set term=gnome-256color
        colorscheme railscasts
        set guifont=Monospace\ Bold\ 12
    endif

    if has("gui_mac") || has("gui_macvim")
        set guifont=Menlo:h14
        set invmmta
        try
          set transparency=5
        catch
        endtry
    endif

    if has("gui_win32") || has("gui_win32s")
        set guifont=Consolas:h12
        set enc=utf-8
    endif
else
    let g:CSApprox_loaded = 1
endif

silent! nmap <silent> <Leader>p :NERDTreeToggle<CR>

nnoremap <C-L> :nohls<CR><C-L>
inoremap <C-L> <C-O>:nohls<CR>

nnoremap <leader>b :BufExplorer<cr>

nnoremap <leader>t :CommandT<CR>

noremap Q gq

nnoremap Y y$

inoremap <M-o>       <Esc>o
inoremap <C-j>       <Down>
let g:ragtag_global_maps = 1

let g:syntastic_enable_signs=1

map <A-o> :copen<CR>
map <A-q> :cclose<CR>
map <A-j> :cnext<CR>
map <A-k> :cprevious<CR>

try
  source ~/.vim/snippets/support_functions.vim
catch
  source ~/vimfiles/snippets/support_functions.vim
endtry
autocmd vimenter * call s:SetupSnippets()
function! s:SetupSnippets()

    if filereadable("./config/environment.rb")
        call ExtractSnips("~/.vim/snippets/ruby-rails", "ruby")
        call ExtractSnips("~/.vim/snippets/eruby-rails", "eruby")
    endif

    call ExtractSnips("~/.vim/snippets/html", "eruby")
    call ExtractSnips("~/.vim/snippets/html", "xhtml")
    call ExtractSnips("~/.vim/snippets/html", "php")
endfunction

function! s:VSetSearch()
    let temp = @@
    norm! gvy
    let @/ = '\V' . substitute(escape(@@, '\'), '\n', '\\n', 'g')
    let @@ = temp
endfunction
vnoremap * :<C-u>call <SID>VSetSearch()<CR>//<CR>
vnoremap # :<C-u>call <SID>VSetSearch()<CR>??<CR>


autocmd BufReadPost * call SetCursorPosition()
function! SetCursorPosition()
    if &filetype !~ 'commit\c'
        if line("'\"") > 0 && line("'\"") <= line("$")
            exe "normal! g`\""
            normal! zz
        endif
    end
endfunction

command! -nargs=? HighlightLongLines call s:HighlightLongLines('<args>')
function! s:HighlightLongLines(width)
    let targetWidth = a:width != '' ? a:width : 79
    if targetWidth > 0
        exec 'match Todo /\%>' . (targetWidth) . 'v/'
    else
        echomsg "Usage: HighlightLongLines [natural number]"
    endif
endfunction

map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

nmap <C-s> :w<CR>

nmap <Tab> gt
nmap <S-Tab> gT

nmap <D-[> <<
nmap <D-]> >>
vmap <D-[> <gv
vmap <D-]> >gv

let ScreenShot = {'Icon':0, 'Credits':0, 'force_background':'#FFFFFF'} 
