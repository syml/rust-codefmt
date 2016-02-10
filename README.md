## Rust plugin for vim-codefmt

This is a temporary hack until vim-codefmt gets rust support.

### Installation
#### Prerequisites
* vim-codefmt (https://github.com/google/vim-codefmt) 
* rustfmt (https://github.com/rust-lang-nursery/rustfmt)

#### Vundle Installation
* Install Vundle (https://github.com/VundleVim/Vundle.vim)
* Add this line to the vundle plugins section in your ~/.vimrc:
```Plugin 'syml/rust-codefmt'```
* Run :PluginInstall inside vim to install the plugin.

### Usage
Format a rust buffer with :FormatCode
