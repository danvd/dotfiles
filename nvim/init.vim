if !exists('*ReloadVimrc')
   fun! ReloadVimrc()
       let save_cursor = getcurpos()
       source $MYVIMRC
       call setpos('.', save_cursor)
   endfun
endif
autocmd! BufWritePost $MYVIMRC call ReloadVimrc()

let g:vimspector_enable_mappings = 'VISUAL_STUDIO'

call plug#begin()

Plug 'joshdick/onedark.vim' " Theme
Plug 'neoclide/coc.nvim', {'branch': 'master', 'do': 'yarn install --frozen-lockfile'} " intellisence
Plug 'jackguo380/vim-lsp-cxx-highlight' " semantic highlight
Plug 'rhysd/vim-clang-format' " formatting
" FuzzyFinder (для быстрого поиска)
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } " file search (install)
Plug 'junegunn/fzf.vim' " file search
Plug 'yuki-ycino/fzf-preview.vim', { 'branch': 'master', 'do': ':UpdateRemotePlugins' }
Plug 'vim-airline/vim-airline' " status line
Plug 'airblade/vim-gitgutter' " show diffs in left panel
Plug 'lambdalisue/gina.vim' " git helper
Plug 'liuchengxu/vista.vim' " symbols outline
Plug 'dense-analysis/ale' " linter aggregator
Plug 'MattesGroeger/vim-bookmarks' " bookmarks, mm for toggle, mn,mp - next/prev
Plug 'voldikss/vim-floaterm' " terminal in floating window
Plug 'derekwyatt/vim-fswitch' " swicth header/source
Plug 'cdelledonne/vim-cmake' " CMake helper
Plug 'haya14busa/is.vim' " search auto highlight remove
Plug 'puremourning/vimspector' " Debug adapter
call plug#end()

let g:ale_linters = {
\   'cpp': ['clangtidy'],
\   'c': ['clangtidy'],
\}
let g:ale_cpp_clangtidy_checks = ['clang-diagnostic-*','clang-analyzer-*','-*','bugprone*','modernize*','performance*','-modernize-pass-by-value','-modernize-use-trailing-return-type','-modernize-use-auto','-modernize-use-using']
let g:ale_cpp_clangtidy_executable = 'clang-tidy'
let g:ale_c_parse_compile_commands=0
let g:ale_cpp_clangtidy_extra_options = '--extra-arg-before=-DSDL_DISABLE_ANALYZE_MACROS'
let g:ale_cpp_clangtidy_options = '--use-color'
let g:ale_set_balloons=1
let g:ale_linters_explicit=1
let g:ale_disable_lsp=1
let g:airline#extensions#ale#enabled=1

let g:lsp_cxx_hl_use_nvim_text_props= 1

let g:cmake_generate_options=['-G', 'Ninja']

set noshowmode

if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
if (has("termguicolors"))
  set termguicolors
endif

syntax on
colorscheme onedark
let g:lightline = {
      \ 'colorscheme': 'onedark',
      \ }
let g:airline_theme='onedark'
let g:airline#extensions#tabline#enabled = 1

let g:clang_format#auto_format=1
let g:clang_format#auto_format_on_insert_leave=1

nnoremap <Leader>f :<C-u>ClangFormat<CR>
autocmd FileType c,cpp,objc ClangFormatAutoEnable

" c++ syntax highlighting
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1

set updatetime=300
set shortmess+=c
set number
set cinoptions='4'
set cindent
" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}


" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)


" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>


" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

augroup fzf_preview
  autocmd!
  autocmd User fzf_preview#initialized call s:fzf_preview_settings()
augroup END

function! s:fzf_preview_settings() abort
  let g:fzf_preview_command = 'COLORTERM=truecolor ' . g:fzf_preview_command
  let g:fzf_preview_grep_preview_cmd = 'COLORTERM=truecolor ' . g:fzf_preview_grep_preview_cmd
endfunction

nmap <silent> <F1> :CocCommand fzf-preview.FromResources project_mru project<CR>

nmap <silent> <F2> :CocCommand explorer<CR>
nmap <silent> <F3> :CocCommand fzf-preview.VistaBufferCtags <CR>
nmap <silent> <F4>  :<C-u>FSHere<CR>
nmap <leader><F3> :<C-u>CocCommand fzf-preview.ProjectGrep<Space>
nmap <silent> <leader><F6> :CocCommand fzf-preview.GitActions<CR>
nmap <silent> <F7> :CMakeGenerate<CR>:CMakeBuild<CR>

nmap <silent> <leader>F12 :VimspectorReset<CR>

nmap <Leader>f [fzf-p]
xmap <Leader>f [fzf-p]
nnoremap <silent> [fzf-p]p     :<C-u>CocCommand fzf-preview.FromResources project_mru git<CR>
nnoremap <silent> [fzf-p]gs    :<C-u>CocCommand fzf-preview.GitStatus<CR>
nnoremap <silent> [fzf-p]ga    :<C-u>CocCommand fzf-preview.GitActions<CR>
nnoremap <silent> [fzf-p]b     :<C-u>CocCommand fzf-preview.Buffers<CR>
nnoremap <silent> [fzf-p]B     :<C-u>CocCommand fzf-preview.AllBuffers<CR>
nnoremap <silent> [fzf-p]o     :<C-u>CocCommand fzf-preview.FromResources buffer project_mru<CR>
nnoremap <silent> [fzf-p]<C-o> :<C-u>CocCommand fzf-preview.Jumps<CR>
nnoremap <silent> [fzf-p]g;    :<C-u>CocCommand fzf-preview.Changes<CR>
nnoremap <silent> [fzf-p]/     :<C-u>CocCommand fzf-preview.Lines --add-fzf-arg=--no-sort --add-fzf-arg=--query="'"<CR>
nnoremap <silent> [fzf-p]*     :<C-u>CocCommand fzf-preview.Lines --add-fzf-arg=--no-sort --add-fzf-arg=--query="'<C-r>=expand('<cword>')<CR>"<CR>
nnoremap          [fzf-p]gr    :<C-u>CocCommand fzf-preview.ProjectGrep<Space>
xnoremap          [fzf-p]gr    "sy:CocCommand   fzf-preview.ProjectGrep<Space>-F<Space>"<C-r>=substitute(substitute(@s, '\n', '', 'g'), '/', '\\/', 'g')<CR>"
nnoremap <silent> [fzf-p]t     :<C-u>CocCommand fzf-preview.BufferTags<CR>
nnoremap <silent> [fzf-p]q     :<C-u>CocCommand fzf-preview.QuickFix<CR>
nnoremap <silent> [fzf-p]l     :<C-u>CocCommand fzf-preview.LocationList<CR>

autocmd VimEnter * call vista#RunForNearestMethodOrFunction()

fun! LspCxxReenable()
	LspCxxHighlightDisable
	LspCxxHighlight
endfun

autocmd! BufWritePost *.cpp,*.h,*.hpp,*.c,*.cxx,*.cc,*.h call LspCxxReenable() 

nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"


