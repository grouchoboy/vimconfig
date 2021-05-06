call plug#begin('~/.vim/plugged')

let g:polyglot_disabled = ['go', 'markdown']

Plug 'AndrewRadev/splitjoin.vim'
Plug 'bronson/vim-visual-star-search'
Plug 'christoomey/vim-tmux-navigator'
Plug 'junegunn/fzf.vim'
Plug 'tomtom/tcomment_vim'
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
Plug 'sheerun/vim-polyglot'
Plug 'plasticboy/vim-markdown'

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-rsi'
Plug 'tpope/vim-unimpaired'

Plug 'janko-m/vim-test'
Plug 'kassio/neoterm'

Plug 'camdencheek/sgbrowse'

Plug 'jonathanfilip/vim-lucius'
Plug 'tomasiser/vim-code-dark'

" Collection of common configurations for the Nvim LSP client
Plug 'neovim/nvim-lspconfig'
" Extensions to built-in LSP, for example, providing type inlay hints
Plug 'nvim-lua/lsp_extensions.nvim'
Plug 'rafcamlet/nvim-luapad'
Plug 'tjdevries/nlua.nvim'

" Telescope
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'
Plug 'nvim-telescope/telescope.nvim'

" Completion
Plug 'hrsh7th/nvim-compe'

Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'

Plug 'kyazdani42/nvim-web-devicons'
Plug 'folke/lsp-trouble.nvim', { 'branch': 'main' }

call plug#end()

" Syntax and filetype specific indentation and plugins on
syntax enable
filetype on
filetype plugin on
filetype indent on

" Make syntax highlighting faster
syntax sync minlines=256

" Shut up.
set noerrorbells
set visualbell

" Check if we can load the FZF vim plugin
if filereadable("/usr/local/opt/fzf/bin/fzf")
  set rtp+=/usr/local/opt/fzf
end

if filereadable("/home/mrnugget/.fzf/bin/fzf")
  set rtp+=/home/mrnugget/.fzf
end

" Basic stuff
" set clipboard=unnamed
set clipboard+=unnamedplus

set showmode
set showcmd
set history=500
set nocompatible
set hidden
set wildmenu
set scrolloff=5
set number
" set cursorline
set colorcolumn=80
set nowrap
set showmatch
set backspace=2
" Make J not insert whitespace
set nojoinspaces
" Allow project-specific vimrc files
set exrc

" Time out on key codes, not mappings.
set notimeout
set ttimeout
set ttimeoutlen=10

" Some tuning for macvim
set ttyfast
if !has('nvim')
  set lazyredraw
end

" Show incremental search/replace
if has('nvim')
  set inccommand=nosplit
end

" Backup
set undofile
set undodir=~/.vim/tmp/undo//
set backupdir=~/.vim/tmp/backup//
set backup
set noswapfile

" Resize vim windows when resizing the main window
au VimResized * :wincmd =

" Searching
set incsearch
set hlsearch
set ignorecase
set smartcase " Do not ignore case, if uppercase is in search term

" Indenting
set tabstop=2
set shiftwidth=2
set softtabstop=2
set shiftround
set expandtab

set list
set listchars=tab:▸\ ,eol:¬,extends:❯,precedes:❮
set ruler
set laststatus=2

" ctags tags file
set tags=./tags;

set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/vendor/bundle/*,*/node_modules/*

" Use ripgrep with fzz as :grep
if executable('rg')
  set grepprg=rg\ --vimgrep
endif


if has('nvim')
  lua require('globals')
end
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" <leader> is ,
let mapleader = ","
noremap \ ,
map <space> <leader>
let maplocalleader = ","

" Move around splits with <C-[hjkl]> in normal mode
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Move visual block selection with <C-[jk]> in visual mode
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv

" Move sanely through wrapped lines
nnoremap k gk
nnoremap j gj

" Use Ctrl-[ as Esc in neovim terminal mode
tnoremap <C-[> <C-\><C-n>

" In visual mode don't include the newline-character when jumping to
" end-of-line with $
vnoremap $ $h

" Paste and reformat with = to the last part of the previous
" paste. Let's see how this works.
"nnoremap p p=`]

" Select the last pasted text, line/block/characterwise
nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'

" Toggle paste mode
nmap <silent> <leader>p :set invpaste<CR>:set paste?<CR>

" Make Y behave like C and D
nmap <silent> Y y$

" Toggle hlsearch
nmap <silent> <leader>h :set invhlsearch<CR>
" Toggle case sensitive search
nmap <silent> <leader>c :set invignorecase<CR>

" Open and source vimrc file
nmap <silent> <leader>ev :e ~/.vimrc<CR>
nmap <silent> <leader>sv :so ~/.vimrc<CR>
" Wipe out ALL the buffers
nmap <silent> <leader>bw :%bwipeout<CR>
" Delete all trailing whitespaces
nmap <silent> <leader>tw :%s/\s\+$//<CR>:let @/=''<CR>``
" Make the just typed word uppercase
imap <C-f> <esc>gUiwgi
" Yank the whole file
nmap <leader>yf ggyG
" Highlight the current word under the cursor
nmap <leader>sw :set hlsearch<CR>mm*N`m
" Greps the current word under the cursor
nmap <leader>gr :gr! <C-r><C-w><CR>
" Find duplicate words
nnoremap <silent> <leader>du /\(\<\w\+\>\)\_s*\<\1\><CR>
" Converting symbols from ruby 1.8 syntax to 1.9
nmap <silent> <leader>19 hf:xepld3l
" Converting ruby symbols to strings
nmap <silent> <leader>tst f:xviwS"
" Repeat last command in tmux window below (if two-pane setup)
nmap <leader>rep :!tmux send-keys -t 2 C-p C-j <CR><CR>
" `puts` the selected expression in the line above
" like this: `puts "<myexpression>=#{<myexpression>}"`
vmap <silent> <leader>pe mz"eyOputs "<ESC>"epa=#{<ESC>"epa}"<ESC>`z
" Pipes the selected region to `jq` for formatting
vmap <silent> <leader>jq :!cat\|jq . <CR>
" Pipes the selection region to `pandoc` to convert it to HTML, opens the temp
" file.
vmap <silent> <leader>pan :w !cat\|pandoc -s -f markdown --metadata title="foo" -o ~/tmp/pandoc_out.html && open ~/tmp/pandoc_out.html <CR>
vmap <silent> <leader>word :w !cat\|pandoc -s -f markdown --toc --metadata title="foo" -o ~/tmp/pandoc_out.docx && open ~/tmp/pandoc_out.docx <CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin Configuration
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable the cfilter plugin that ships with Vim/NeoVim
packadd cfilter

" Enable matchit.vim, which ships with Vim but isn't enabled by default
" somehow
runtime macros/matchit.vim

" netrw
let g:netrw_liststyle = 3
let g:netrw_keepj="keepj"
function! OpenURLUnderCursor()
  let s:uri = expand('<cWORD>')
  let s:uri = matchstr(s:uri, '[a-z]*:\/\/[^ >,;()]*')
  let s:uri = substitute(s:uri, '?', '\\?', '')
  let s:uri = shellescape(s:uri, 1)
  if s:uri != ''
    silent exec "!xdg-open '".s:uri."'"
    :redraw!
  endif
endfunction
nnoremap gx :call OpenURLUnderCursor()<CR>

" See https://github.com/christoomey/vim-tmux-navigator/issues/189
" for context on the following
augroup netrw_mapping
  autocmd!
  autocmd filetype netrw call NetrwMapping()
augroup END

function! NetrwMapping()
  nnoremap <silent> <buffer> <c-l> :TmuxNavigateRight<CR>
endfunction

" fugitive.vim
nmap <leader>gb :Gblame<CR>

" Tabular
nmap <leader>a= :Tabularize /=<CR>
vmap <leader>a= :Tabularize /=<CR>
nmap <leader>ah :Tabularize /=>\?<CR>
vmap <leader>ah :Tabularize /=>\?<CR>

" neoterm
let g:neoterm_default_mod = "vert botright"
let g:neoterm_autoscroll = 1
let g:neoterm_keep_term_open = 1
" ,tg to[g]gle the terminal window
nmap     <silent> <leader>tg :Ttoggle<CR>
" ,tc [c]lear the terminal window
nmap     <silent> <leader>tc :Tclear<CR>
" ,sl [s]end [line] to REPL in terminal window
nmap     <silent> <leader>sl :TREPLSendLine<CR>
vnoremap <silent> <leader>sl :TREPLSendSelection<CR>
nmap     <silent> <leader>sf :TREPLSendFile<CR>

" vim-test
let g:test#strategy = "neoterm"
" ,rt runs rspec on current (or previously set ) single spec ('run this')
" ,rf runs rspec on current (or previously set) spec file ('run file')
" ,ra runs all specs ('run all')
" ,rl runs the last spec ('run last')
nmap <silent> <leader>rt :TestNearest<CR>
nmap <silent> <leader>rf :TestFile<CR>
nmap <silent> <leader>ra :TestSuite<CR>
nmap <silent> <leader>rl :TestLast<CR>

" Markdown
let g:markdown_fenced_languages = ['go', 'ruby', 'html', 'javascript', 'bash=sh', 'sql']
let g:vim_markdown_fenced_languages = ['go', 'ruby', 'html', 'javascript', 'bash=sh', 'sql']
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_folding_level = 6
let g:vim_markdown_new_list_item_indent = 2
let g:vim_markdown_no_default_key_mappings = 1

" FZF mappings and custom functions
" nnoremap <silent> <leader>fc :BCommits<CR>
" nnoremap <silent> <leader>fb :Buffers<CR>
" nnoremap <silent> <leader>fr :History<CR>
" nnoremap <silent> <leader>ft :Tags<CR>
" nnoremap <silent> <leader>fi :FZF<CR>
" nnoremap <silent> <C-p> :FZF<CR>

" Hide statusline
autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

let g:fzf_colors =
\ { "fg":      ["fg", "Normal"],
  \ "bg":      ["bg", "Normal"],
  \ "hl":      ["fg", "IncSearch"],
  \ "fg+":     ["fg", "CursorLine", "CursorColumn", "Normal"],
  \ "bg+":     ["bg", "CursorLine", "CursorColumn"],
  \ "hl+":     ["fg", "IncSearch"],
  \ "info":    ["fg", "IncSearch"],
  \ "border":  ["fg", "Ignore"],
  \ "prompt":  ["fg", "Comment"],
  \ "pointer": ["fg", "IncSearch"],
  \ "marker":  ["fg", "IncSearch"],
  \ "spinner": ["fg", "IncSearch"],
  \ "header":  ["fg", "WildMenu"] }


" Telescope.nvim, see lua/plugins/telescope.lua
if has('nvim')
  lua require('plugins.telescope')
end

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Notes
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let s:notes_folder = "~/Dropbox/notes"
let s:notes_fileending = ".md"

" This is either called with
" 0 lines, which means there's no result and no query
" 1 line, which means there's no result, but a user query
"         in this case: create a new file, based on user query
" 2 lines, which means there are results, so open them
"
function! s:note_handler(lines)
  if len(a:lines) < 1 | return | endif

  if len(a:lines) == 1
    let query = a:lines[0]
    let new_filename = fnameescape(query . s:notes_fileending)
    let new_title = "# " . query

    execute "edit " . new_filename

    " Append the new title and an empty line
    let failed = append(0, [new_title, ''])
    if (failed)
      echo "Unable to insert title file!"
    else
      let &modified = 1
    endif
  else
    execute "edit " fnameescape(a:lines[1])
  endif
endfunction

command! -nargs=* Notes call fzf#run({
\ 'sink*':   function('<sid>note_handler'),
\ 'options': '--print-query ',
\ 'dir':     s:notes_folder
\ })

function! s:rg_to_quickfix(line)
  let parts = split(a:line, ':')
  return {'filename': parts[0], 'lnum': parts[1], 'col': parts[2],
        \ 'text': join(parts[3:], ':')}
endfunction

function! s:find_notes_handler(lines)
  if len(a:lines) < 2 | return | endif

  let cmd = get({'ctrl-x': 'split',
               \ 'ctrl-v': 'vertical split',
               \ 'ctrl-t': 'tabe'}, a:lines[0], 'e')
  let list = map(a:lines[1:], 's:rg_to_quickfix(v:val)')

  let first = list[0]
  execute cmd escape(first.filename, ' %#\')
  execute first.lnum
  execute 'normal!' first.col.'|zz'

  if len(list) > 1
    call setqflist(list)
    copen
    wincmd p
  endif
endfunction

command! -nargs=* FindNotes call fzf#run({
\ 'source':  printf('rg --column --color=always "%s"',
\                   escape(empty(<q-args>) ? '' : <q-args>, '"\')),
\ 'sink*':    function('<sid>find_notes_handler'),
\ 'options': '--ansi --expect=ctrl-t,ctrl-v,ctrl-x --delimiter : --nth 4.. '.
\            '--multi --bind=ctrl-a:select-all,ctrl-d:deselect-all '.
\            '--color hl:68,hl+:110',
\ 'down':    '50%',
\ 'dir':     s:notes_folder
\ })

command! -bang -nargs=* FindNotesWithPreview
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview({'dir': s:notes_folder}, 'right:50%'),
  \   0,
  \ )

nmap <silent> <leader>nn :Notes<CR>
nmap <silent> <leader>fn :FindNotes<CR>
nmap <silent> <leader>nw :FindNotesWithPreview<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vsnip configuration
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NOTE: You can use other key to expand snippet.

" Expand
imap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'
smap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'

" Expand or jump
imap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
smap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'

" Jump forward or backward
imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'

" Select or cut text to use as $TM_SELECTED_TEXT in the next snippet.
" See https://github.com/hrsh7th/vim-vsnip/pull/50
nmap  s   <Plug>(vsnip-select-text)
xmap  s   <Plug>(vsnip-select-text)
nmap  S   <Plug>(vsnip-cut-text)
xmap  S   <Plug>(vsnip-cut-text)

" If you want to use snippet for multiple filetypes, you can `g:vsnip_filetypes` for it.
let g:vsnip_filetypes = {}
let g:vsnip_filetypes.javascriptreact = ['javascript']
let g:vsnip_filetypes.typescriptreact = ['typescript']

let g:vsnip_snippet_dir = "~/.vim/snippets"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" compe configuration
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set completeopt=menuone,noselect

let g:compe = {}
let g:compe.enabled = v:true
let g:compe.autocomplete = v:true
let g:compe.debug = v:false
let g:compe.min_length = 1
let g:compe.preselect = 'always'
let g:compe.throttle_time = 80
let g:compe.source_timeout = 200
let g:compe.incomplete_delay = 400
let g:compe.max_abbr_width = 100
let g:compe.max_kind_width = 100
let g:compe.max_menu_width = 100
let g:compe.documentation = v:true

let g:compe.source = {}
let g:compe.source.path = v:true
let g:compe.source.buffer = v:true
let g:compe.source.calc = v:true
let g:compe.source.nvim_lsp = v:true
let g:compe.source.nvim_lua = v:true
let g:compe.source.vsnip = v:true

inoremap <silent><expr> <C-n>     compe#complete()
inoremap <silent><expr> <CR>      compe#confirm('<CR>')
inoremap <silent><expr> <C-e>     compe#close('<C-e>')
inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" LSP configuration
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if has('nvim')
  " If we're using Neovim's builtin LSP support, let's disable a lot of the
  " auto-functionality in vim-go:
  let g:go_def_mapping_enabled = 0
  let g:go_term_enabled = 1
  let g:go_diagnostics_enabled = 0
  let g:go_code_completion_enabled = 0
  let g:go_code_completion_icase = 0
  let g:go_fmt_autosave = 0
  let g:go_mod_fmt_autosave = 0
  let g:go_doc_keywordprg_enabled = 0
  let g:go_gopls_enabled = 0
  let g:go_diagnostics_enabled = 0
  let g:go_echo_go_info = 0
  let g:go_echo_command_info = 0

  " Configure LSP
  lua require("lsp")

  " Code navigation shortcuts
  nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
  nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
  nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
  nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
  nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
  nnoremap <silent> gR    <cmd>lua vim.lsp.buf.references()<CR>
  nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
  nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
  nnoremap <silent> gd    <cmd>lua vim.lsp.buf.declaration()<CR>
  nnoremap <silent> ga    <cmd>lua vim.lsp.buf.code_action()<CR>
  nnoremap <silent> gr    <cmd>lua vim.lsp.buf.rename()<CR>
  nnoremap <silent> gld    <cmd>lua require('lsp_extensions.workspace.diagnostic').set_qf_list()<CR>
  " Set updatetime for CursorHold
  " 300ms of no cursor movement to trigger CursorHold
  set updatetime=300
  " Show diagnostic popup on cursor hold
  autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()
  " Goto previous/next diagnostic warning/error
  nnoremap <silent> g[ <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
  nnoremap <silent> g] <cmd>lua vim.lsp.diagnostic.goto_next()<CR>
  " have a fixed column for the diagnostics to appear in
  " this removes the jitter when warnings/errors flow in
  set signcolumn=yes
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Filetypes
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Markdown
augroup ft_markdown
  au!
  au BufNewFile,BufRead *.md setlocal filetype=markdown

  au Filetype markdown setlocal textwidth=80
  au Filetype markdown setlocal smartindent " Indent lists correctly
  au FileType markdown setlocal nolist
  " Taken from here: https://github.com/plasticboy/vim-markdown/issues/232
  au FileType markdown
      \ set formatoptions-=q |
      \ set formatlistpat=^\\s*\\d\\+\\.\\s\\+\\\|^\\s*\[-*+]\\s\\+
augroup END

" C
augroup ft_c
  au!
  au BufNewFile,BufRead *.h setlocal filetype=c
  au Filetype c setlocal expandtab shiftwidth=4 tabstop=4 softtabstop=4
  au Filetype c setlocal cinoptions=l1,t0,g0 " This fixes weird indentation of switch/case
augroup END

" Python
autocmd FileType python setlocal expandtab shiftwidth=4 tabstop=4 softtabstop=4

" Go
augroup ft_golang
  au!

  au BufEnter,BufNewFile,BufRead *.go setlocal formatoptions+=roq
  au BufEnter,BufNewFile,BufRead *.go setlocal noexpandtab shiftwidth=4 tabstop=4 softtabstop=4 nolist
  au BufEnter,BufNewFile,BufRead *.tmpl setlocal filetype=html

  au Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
  au Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
  au Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
augroup END

" Rust
augroup ft_rust
  au!
  au BufEnter,BufNewFile,BufRead *.rs :compiler cargo
  au FileType rust set nolist
augroup END

" Racket
augroup ft_racket
  au!
  au BufEnter,BufNewFile,BufRead *.rkt set filetype=racket
augroup END

" Typescript
augroup ft_typescript
  au!

  autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescript

  au Filetype typescript setlocal shiftwidth=4 softtabstop=4 expandtab
augroup END

" GNU Assembler
" Insert comments automatically on return in insert and when using O/o in
" normal mode
augroup ft_asm
  au!
  au FileType asm setlocal formatoptions+=ro
augroup END

" Merlin setup for Ocaml
" if executable('opam')
"   let g:opamshare = substitute(system('opam config var share'),'\n$','','''')
"   execute "set rtp+=" . g:opamshare . "/merlin/vim"
"
"   let g:merlin_split_method = "never"
"   let g:merlin_textobject_grow   = 'm'
"   let g:merlin_textobject_shrink = 'M'
" endif

" OCaml
augroup ft_ocaml
  au!

  au Filetype ocaml nmap <c-]> gd

  au Filetype ocaml nmap <leader>ot :MerlinTypeOf<CR>
  au Filetype ocaml nmap <leader>og :MerlinGrowEnclosing<CR>
  au Filetype ocaml nmap <leader>os :MerlinShrinkEnclosing<CR>
augroup END

" YAML
augroup ft_yaml
  au!
  au FileType yaml setlocal nolist
  au FileType yaml setlocal number
  au FileType yaml setlocal colorcolumn=0
augroup END

" Quickfix List
"
" Adjust height of quickfix window
function! AdjustWindowHeight(minheight, maxheight)
  exe max([min([line("$"), a:maxheight]), a:minheight]) . "wincmd _"
endfunction
augroup ft_quickfix
    autocmd!
    " Autowrap long lines in the quickfix window
    autocmd FileType qf setlocal wrap
    autocmd FileType qf call AdjustWindowHeight(3, 10)
augroup END

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" GVim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("gui_running")
  set guioptions=gc
  set lines=60 columns=90
  if has("mac")
    set guifont=Hack:h12
  else
    set guifont=Monospace\ 9
  endif
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Statusline
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set statusline=%<\ %{mode()}\ \|\ %f%m\ \|\ %{fugitive#statusline()\ }
if has('nvim')
  set statusline+=\ \|\ %{v:lua.workspace_diagnostics_status()}
endif
set statusline+=%{&paste?'\ \ \|\ PASTE\ ':'\ '}
set statusline+=%=\ %{&fileformat}\ \|\ %{&fileencoding}\ \|\ %{&filetype}\ \|\ %l/%L\(%c\)\ 

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Colors/colorscheme/etc.
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set termguicolors
set t_Co=256
set t_ut=

let kitty_profile = $KITTY_COLORS

if kitty_profile == "dark"
  set background=dark
  colorscheme codedark

  highlight LspDiagnosticsFloatingError guifg=#940000 guibg=NONE gui=bold
  highlight LspDiagnosticsFloatingHint guifg=#569CD6 guibg=NONE
  highlight LspDiagnosticsFloatingInformation guifg=#5e81ac guibg=NONE
  highlight LspDiagnosticsFloatingWarning guifg=#ebcb8b guibg=NONE
else
  set background=light
  let g:lucius_style  = 'light'
  let g:lucius_contrast  = 'high'
  let g:lucius_contrast_bg  = 'high'
  let g:lucius_no_term_bg  = 1
  colorscheme lucius

  " Give the active window a blue background and white foreground statusline
  hi StatusLine ctermfg=15 ctermbg=32 guifg=#FFFFFF guibg=#005FAF gui=bold cterm=bold
  hi SignColumn ctermfg=255 ctermbg=15 guifg=#E4E4E4 guibg=#FFFFFF

  " Tweak popup colors
  highlight Pmenu guibg=#E4E4E4 guifg=#000000

  highlight link LspDiagnosticsFloatingError ErrorMsg
  highlight link LspDiagnosticsFloatingWarning WarningMsg
  highlight link LspDiagnosticsFloatingHint Directory
  highlight link LspDiagnosticsFloatingInformation Directory
endif

highlight TelescopeSelection gui=bold " selected item

highlight link LspDiagnosticsDefaultError ErrorMsg
highlight link LspDiagnosticsDefaultWarning WarningMsg
highlight link LspDiagnosticsDefaultInformation Directory
highlight link LspDiagnosticsDefaultHint Directory

highlight link LspDiagnosticsUnderlineError ErrorMsg
highlight link LspDiagnosticsUnderlineWarning WarningMsg
highlight link LspDiagnosticsUnderlineInformation Directory
highlight link LspDiagnosticsUnderlineHint Directory

highlight LspDiagnosticsUnderlineError gui=underline cterm=underline
highlight LspDiagnosticsUnderlineWarning gui=underline cterm=underline
highlight LspDiagnosticsUnderlineInformation gui=underline cterm=underline
highlight LspDiagnosticsUnderlineHint gui=underline cterm=underline

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" THE END
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Only allow secure commands from this point on. Necessary because further up
" project-specific vimrc files were allowed with `set exrc`
set secure
