## Rust plugin for vim-codefmt

This plugin enables rust formatting in vim-codefmt.

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

### Configuration
You can change the rustfmt executable with the rustfmt_executable codefmt flag. 
In your ~/.vimrc: 

```Glaive codefmt rustfmt_executable='/users/foo/bin/rustfmt'```
