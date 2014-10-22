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


###############
# Bom negocio #
###############

# git completion
source /etc/bash_completion.d/git-completion.bash

# .bashrc
export PYTHON_27=/opt/python/bin/
export SCMCOORD=/opt/scmcoord_contrib/bin/
export PATH=${SCMCOORD}:${PYTHON_27}:${PATH}

# open all conflicted files in vim, buffered. To change to next buffer use :bd
editconflicts() {
    vim +/"<<<<<<<" $( git diff --name-only --diff-filter=U | xargs )
}


# create ctags for php
alias ctagsphp="ctags -R --exclude=.git --exclude=ninja_build --tag-relative=yes --PHP-kinds=+cf-v --regex-PHP='/abstract\s+class\s+([^ ]+)/\1/c/' --regex-PHP='/interface\s+([^ ]+)/\1/c/' --regex-PHP='/(public\s+|static\s+|abstract\s+|protected\s+|private\s+)function\s+\&?\s*([^ (]+)/\2/f/' ~/bomnegocio/php"
alias ctagbn="ctags -R --exclude=.git --exclude=ninja_build ~/bomnegocio/* /usr/local/lib/ruby/"
ctags_ng_api() {
	find . -type f -not -path "./build*" -not -path "./ng_api_tags*" -not -path "*__pycache__*" -not -path "./.git*" -not -path "./platform*" > to_index
	ctags -R -f ng_api_tags -L to_index --python-kinds=-i
}

# ignore git ssl certificate
export GIT_SSL_NO_VERIFY=true


function fix_test ()
{
    cat .get_url.out | sed 's/\(dev\|dv2\).srv.office:[0-9][0-9][0-9][0-9][0-9]/{{.*}}/g; 1s/^.*$/{{.*}}/g'
}

function fix_test_diff ()
{
    local in=${2:-.get_url.out}
    local out=$1

    if [ $# -lt 1 ]; then
        echo "Usage: fix_test_diff tests/arquivo-teste.out [.get_url.out]"
        return
    fi

    if [ ! -f "$out" ]; then
        echo "oops! arquivo $out nao encontrado."
        return
    fi

    sed 's/, /,\n/g' -i $out
	sed 's/\(dev\|dv2\).srv.office:[0-9][0-9][0-9][0-9][0-9]/{{.*}}/g; 1s/^.*$/{{.*}}/g' -i $in
    vimdiff -c 'windo set wrap' <(sed 's/, /,\n/g' $in) $out
    sed ':a;N;$!ba;s/,\n/, /g' -i $out
}

export API_SITE_ENCODING=latin1
