let s:plugin = maktaba#plugin#Get('codefmt')
let s:registry = s:plugin.GetExtensionRegistry()

call s:plugin.Flag('rustfmt_executable', 'rustfmt')

function! rustfmt#GetRustFmtFormatter() abort
  let l:formatter = {
      \ 'name': 'rustfmt',
      \ 'setup_instructions': 'Install rustfmt' .
          \ '(https://github.com/rust-lang-nursery/rustfmt).'}

  function l:formatter.IsAvailable() abort
    return executable(s:plugin.Flag('rustfmt_executable'))
  endfunction

  function l:formatter.AppliesToBuffer() abort
    return &filetype is# 'rust'
  endfunction

  ""
  " Reformat the current buffer with rustfmt or the binary named in
  " @flag(rustfmt_executable)
  " @throws ShellError
  function l:formatter.Format() abort
    let l:cmd = [s:plugin.Flag('rustfmt_executable')]

    let l:lines = getline(1, line('$'))
    let l:input = join(l:lines, "\n")

    let l:result = maktaba#syscall#Create(l:cmd).WithStdin(l:input).Call()
    let l:formatted = split(l:result.stdout, "\n")

    call maktaba#buffer#Overwrite(1, line('$'), l:formatted)
  endfunction

  return l:formatter
endfunction

call s:registry.AddExtension(rustfmt#GetRustFmtFormatter())
