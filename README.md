# Dev utils & scripts

This repository contains and keep track of all the utilities I use for my own convenience.

## Zsh Plugins

### Current plugins that is being used in zsh

```sh
plugins=(git nvm npm yarn pyenv python deno rust poetry zsh-autosuggestions zsh-syntax-highlighting docker docker-compose)
```

Among them, these plugins does not come with omz, and are stored as submodule for this repo to allow easy configuration

- zsh-syntax-highlighting
- zsh-autosuggestions

## Binary/Scripts
### git-acc

Bash script used to switch between public accounts generated from various repository hosting platform.

Script should be placed in `/usr/local/bin` or its equivalent for global access.