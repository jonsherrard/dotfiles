alias ec2chaffinch='ssh 46.51.170.54 -l ec2-user -i /Users/jonsherrard/Library/Containers/com.sparrowmailapp.sparrow/Data/Library/Application\ Support/Sparrow/jon@chaffin.ch.sparrowdb/Cache/INBOX/58/2/keypair1.pem'
alias ls='ls -ls -G'
PS1="\\[$(tput setaf 1)\\]\\u@\W: \\[$(tput sgr0)\\]"
alias webfaction='ssh web185.webfaction.com -l jonsherrard'
alias mediatemple='ssh s142834.gridserver.com -l dropmusic.net'
CDPATH='.:~:/Applications/MAMP/htdocs'
alias home='cd ~/'
alias htdocs='cd /Applications/MAMP/htdocs'
alias cb='build.sh'
alias na='node app'
alias re='cb; na;'
alias hurl='cd hurl; bundle exec shotgun config.ru; open -a "Google Chrome" "http://dev:9393";'
alias ec2='ssh -l ubuntu 54.247.84.184 -i ~/.ec2/shezserverkey.pem'
export PATH=:$PATH/Users/jonsherrard/code/android/platform-tools/
export ANROID_HOME=:$PATH/Users/jonsherrard/code/
export PATH=$PATH:/Users/jonsherrard/code/android/tools/





[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
