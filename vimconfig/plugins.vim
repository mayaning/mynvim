""""""""""""""""""""""""vim-mundo settings"""""""""""""""""""""""
let g:mundo_verbose_graph = 0
let g:mundo_width = 80

nnoremap <silent> <Space>u :MundoToggle<CR>

""""""""""""""""""""""""""" vista settings """"""""""""""""""""""""""""""""""
" How each level is indented and what to prepend.
" This could make the display more compact or more spacious.
" e.g., more compact: ["▸ ", ""]
" Note: this option only works for the kind renderer, not the tree renderer.
let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]

" Executive used when opening vista sidebar without specifying it.
" See all the avaliable executives via `:echo g:vista#executives`.
let g:vista_default_executive = 'ctags'

" Set the executive for some filetypes explicitly. Use the explicit executive
" instead of the default one for these filetypes when using `:Vista` without
" specifying the executive.
"let g:vista_executive_for = {
  \ 'cpp': 'nvim-lspconfig',
  \ 'php': 'nvim-lspconfig',
  \ }

" Declare the command including the executable and options used to generate ctags output
" for some certain filetypes.The file path will be appened to your custom command.
" For example:
let g:vista_ctags_cmd = {
      \ 'haskell': 'hasktags -x -o - -c',
      \ }

" To enable fzf's preview window set g:vista_fzf_preview.
" The elements of g:vista_fzf_preview will be passed as arguments to fzf#vim#with_preview()
" For example:
let g:vista_fzf_preview = ['right:50%']

" Ensure you have installed some decent font to show these pretty symbols, then you can enable icon for the kind.
let g:vista#renderer#enable_icon = 1

" The default icons can't be suitable for all the filetypes, you can extend it as you wish.
let g:vista#renderer#icons = {
\   "function": "\uf794",
\   "variable": "\uf71b",
\  }

" Do not echo message on command line
let g:vista_echo_cursor = 0
" Stay in current window when vista window is opened
let g:vista_stay_on_open = 0

nnoremap <silent> <Space>t :<C-U>Vista!!<CR>


""""""""""""""""""""""""""" easymotion settings """""""""""""""""""""""""""""""
" easymotion
" 
" 功能说明:
" 快速跳转
" 
" 配置:
let g:EasyMotion_smartcase = 1
let g:EasyMotion_startofline = 0 " keep cursor colum when JK motion
" 跳转到当前光标前后的位置(w/b)
" 快捷键<leader><leader>w和<leader><leader>b
" 搜索跳转(s)
" 快捷键<leader><leader>s, 然后输入要搜索的字母, 这个跳转是双向的
" 行级跳转(jk)
map <Leader><leader>h <Plug>(easymotion-linebackward)
map <Leader><Leader>j <Plug>(easymotion-j)
" 行内跳转(hl)
map <Leader><Leader>k <Plug>(easymotion-k)
map <Leader><leader>l <Plug>(easymotion-lineforward)
" 重复上一次操作, 类似repeat插件, 很强大
map <Leader><leader>. <Plug>(easymotion-repeat)


"""""""""""""""""""""""" VIM 的自动换行及自动折行设置 """"""""""""""""""""""""
" 自动换行是每行超过 n 个字的时候 vim 自动加上换行符
" 需要注意的是，如果一个段落的首个单词很长，超出了自动换行设置的字符，
" 这种情况下不会换行。
" 于是，中文就悲剧了，因为中文中很少出现空格，字之间没有，句子之间也没有。
" 于是不会触发自动换行的处理。
" 对已经存在的文本，不做自动换行处理，只有新输入文本的才会触发。
" 如要对已存在的文本应用自动换行，只要选中它们，然后按gq就可以了。
set textwidth=80
" 上面所说的中文不能自动换行的问题，可以通过下面的配置解决.
" m - Also break at a multi-byte character above 255. This is useful for
" Asian text where every character is a word on its own.
" M - When joining lines, don't insert a space before or after a
" multi-byte character. Overrules the 'B' flag.
set formatoptions+=mM
" 自动折行是把长的一行用多行显示 , 不在文件里加换行符
" 设置自动折行(默认开启)
set wrap
" 设置不自动折行
" set nowrap
