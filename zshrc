[[ -s /Users/technicaldeveloper/.nvm/nvm.sh ]] && . /Users/technicaldeveloper/.nvm/nvm.sh  # This loads NVM
# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="pygmalion"


# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git autojump osx)

source $ZSH/oh-my-zsh.sh

# NO CORRECTS
alias vim='nocorrect vim'

# MONGO

export MONGO_PATH=/usr/local/mongodb
export PATH=$PATH:$MONGO_PATH/bin

# ALIASES

alias gmail='vmail -c .vmailrc-andthatsit'
alias home='cd ~/'
alias htdocs='cd /Applications/MAMP/htdocs'
alias cb='build.sh'
alias na='node app'
alias re='cb; na;'
alias hurl='cd hurl; bundle exec shotgun config.ru; open -a "Google Chrome" "http://dev:9393";'
alias ec2='ssh -l ubuntu 54.247.84.184 -i ~/.ec2/shezserverkey.pem'
CDPATH='.:~:/Applications/MAMP/htdocs'
alias ls='ls -1 -G -F -la -tr'

 #FUNCTIONS


function ql {
	quick-look $1 
}

function ms {
	mux start $1
}

function cd(){
	builtin cd "$*" && ls 
}

function mkcd () {
  mkdir -p "$@" && eval cd "\"\$$#\""; 
}
# Autojump

if [ -f `brew --prefix`/etc/autojump ]; then
  . `brew --prefix`/etc/autojump
fi

export TERM=xterm-256color
export EDITOR='vim'
[[ -s $HOME/.tmuxinator/scripts/tmuxinator ]] && source $HOME/.tmuxinator/scripts/tmuxinator


PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" # This loads RVM into a shell session.


