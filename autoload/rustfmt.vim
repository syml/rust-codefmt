echoerr 'FOO'

let s:plugin = maktaba#plugin#Get('codefmt')
let s:registry = s:plugin.GetExtensionRegistry()

function! rustfmt#GetRustFmtFormatter() abort
  let l:formatter = {
      \ 'name': 'rustfmt',
      \ 'setup_instructions': 'Install rustfmt' .
          \ '(https://github.com/rust-lang-nursery/rustfmt).'}

  function l:formatter.IsAvailable() abort
    return executable('rustfmt')
    "return executable(s:plugin.Flag('rustfmt_executable'))
  endfunction

  function l:formatter.AppliesToBuffer() abort
    return &filetype is# 'rust'
  endfunction

  ""
  " Reformat the current buffer with js-beautify or the binary named in
  " @flag(js_beautify_executable), only targeting the range between {startline} and
  " {endline}.
  " @throws ShellError
  function l:formatter.FormatRange(startline, endline) abort
    "let l:cmd = [s:plugin.Flag('js_beautify_executable'), '-f', '-']
    let l:cmd = ['rustfmt']

    call maktaba#ensure#IsNumber(a:startline)
    call maktaba#ensure#IsNumber(a:endline)

    let l:lines = getline(1, line('$'))
    " Hack range formatting by formatting range individually, ignoring context.
    let l:input = join(l:lines[a:startline - 1 : a:endline - 1], "\n")

    let l:result = maktaba#syscall#Create(l:cmd).WithStdin(l:input).Call()
    let l:formatted = split(l:result.stdout, "\n")
    " Special case empty slice: neither l:lines[:0] nor l:lines[:-1] is right.
    let l:before = a:startline > 1 ? l:lines[ : a:startline - 2] : []
    let l:full_formatted = l:before + l:formatted + l:lines[a:endline :]

    call maktaba#buffer#Overwrite(1, line('$'), l:full_formatted)
  endfunction

  return l:formatter
endfunction

call s:registry.AddExtension(rustfmt#GetRustFmtFormatter())
