# Makes less scroll nicely horizontally
#export LESS='-R#3'

# bash in vi mode
# if you want to undo
# $set -o emacs
set -o vi

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

#$set -o emacs
#to disable the command below
set -o vi

# User specific aliases and functions
alias lalias='cat ~/.bashrc | grep alias'
alias ll='ls -laGh --color=auto'
alias ls='ls -FG --color=always'
alias c='clear'
alias ..='cd ..'
alias grep='grep --color=always'
alias fgrep='fgrep --color=always'
alias egrep='egrep --color=always'


#GIT
# git completion
source /etc/bash_completion.d/git-completion.bash

# git branch
parse_git_branch() {
        git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1) /'
}

PS1="\$(parse_git_branch)$PS1"

#git alias
## Pretty graph
alias gl='git log --graph --pretty=format:'\''%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'\'' --abbrev-commit --'
## Pretty graph one parent
alias gl1p='git log --graph --pretty=format:'\''%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'\'' --abbrev-commit --first-parent'
alias glfh='git log --graph --full-history --all --pretty=format:'\''%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'\'' --abbrev-commit --'
alias git_tags_with_dates='git log --tags --simplify-by-decoration --pretty="format:%ai %d"'

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

dirtree() {
	ls $1 -R | grep ":$" | sed -e 's/:$//' -e 's/[^-][^\/]*\//--/g' -e 's/^/   /' -e 's/-/|/';
}

# Found in
# http://code-and-hacks.peculier.com/vim/recovering-after-vim-terminates/
function vimswp (){
       swap_files=`find . -name "*.swp"`

       for s in $swap_files ; do
               orig_file=`echo $s | perl -pe 's!/\.([^/]*).swp$!/$1!' `
               echo "Editing $orig_file"
               sleep 1
               vim -r $orig_file -c "DiffOrig"
               echo -n "  Ok to delete swap file? [y/n] "
               read resp
               if [ "$resp" == "y" ] ; then
                       echo "  Deleting $s"
                       rm $s
               fi
       done
}


