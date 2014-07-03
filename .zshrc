# Definition du PATH
PATH=$HOME/scripts:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/usr/texbin
export PATH

# Configuration de l'historique
HISTFILE=~/.zshrc_history
SAVEHIST=5000
HISTSIZE=5000
setopt inc_append_history
# setopt share_history

# default editor
EDITOR=vim
export EDITOR

# Reglage du terminal
TERM=xterm-256color

# Correction de la touche Delete
bindkey "\e[3~"   delete-char

# Autocompletion de type menu
autoload -U compinit && compinit
zstyle ':completion:*' menu select

# Couleur prompt
autoload -U colors && colors

# Definition des variables
USER=`/usr/bin/whoami`
export USER
GROUP=`/usr/bin/id -gn $user`
export GROUP
MAIL="$USER@student.42.fr"
export MAIL

# Definition des couleurs
if [ -f ~/.ls_colors ]; then
    source ~/.ls_colors
fi

NORMAL="%{$reset_color%}"

# Definition du prompt
precmd ()
{
    if [ $? -eq 0 ]
    then
        COLOR3="%{$fg[green]%}"
    else
        COLOR3="%{$fg[red]%}"
    fi
    ISGIT=$(git status 2> /dev/null)
    if [ -n "$ISGIT" ]
    then
        STATUS=$(echo "$ISGIT" | grep "modified:\|renamed:\|new file:\|deleted:")
        BRANCH=$(git branch | cut -d ' ' -f 2 | tr -d '\n')
        if [ -n "$STATUS" ]
        then
            COLOR="%{$fg[red]%}"
        else
            REMOTE_EXIST=$(git branch -a | grep remotes/origin/$BRANCH)
            if [ -n "$REMOTE_EXIST" ]
            then
                REMOTE=$(git diff origin/$BRANCH $BRANCH)
                if [ -n "$REMOTE" ]
                then
                    COLOR="%{$fg[yellow]%}"
                else
                    COLOR="%{$fg[green]%}"
                fi
            else
                COLOR="%{$fg[green]%}"
            fi
        fi
        RPROMPT="%{$COLOR%}($BRANCH)%{$NORMAL%}"
    else
        RPROMPT=""
    fi
    RPROMPT="$RPROMPT"
    PROMPT="%B%{$fg[green]%}%n@%m%{$NORMAL%}%B:%{$fg[blue]%}%~%{$NORMAL%}
%B%{$COLOR3%}> %{$NORMAL%}%b"
}

# Definition des alias raccourcis
alias cdc='cd $WP'
alias cdl='cd $LIB'
alias cdm='cd $MAMP'
alias cds='cd ~/scripts/'
alias cdt='cd ~/test/'
alias cdx='cd $COR'

# Definition des alias de git
alias ga="git add"
alias gb="git branch"
alias gcm="git commit -m"
alias gco="git checkout"
alias gpl="git pull"
alias gps="git push"
alias gm="git merge"
alias gu="git add -u"

# Definition des alias
alias auteur="echo 'mdelage' > auteur"
alias em="emacs"
alias files_s="defaults write com.apple.finder AppleShowAllFiles TRUE && killall Finder"
alias files_h="defaults write com.apple.finder AppleShowAllFiles FALSE && killall Finder"
alias find_text='~/scripts/find_text'
alias grand="open ~/GrandPerspective.app"
alias gccf='gcc -Wall -Wextra -Werror'
alias gccl="gcc -I ~/libft/includes -L ~/libft -lft"
alias gcclf="gcc -Wall -Wextra -Werror -I ~/libft/includes -L ~/libft -lft"
alias l='ls -l'
alias la='ls -lA'
alias libft='cp -r ~/libft libft; rm -rf libft/.git'
alias ls='ls --color'
alias modsh='vim ~/dotfiles/.zshrc'
alias next='source ~/scripts/nextprev next'
alias prev='source ~/scripts/nextprev prev'
alias proto='~/scripts/proto'
alias rl='source ~/.zshrc'
alias sd='emacs'
alias GG="cowsay \"Bien Joue les gars ! Bon courage et bonne continuation.\" "

# Couleurs pour le man
man()
{
    env \
        LESS_TERMCAP_mb=$(printf "\e[1;31m") \
        LESS_TERMCAP_md=$(printf "\e[1;31m") \
        LESS_TERMCAP_me=$(printf "\e[0m") \
        LESS_TERMCAP_se=$(printf "\e[0m") \
        LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
        LESS_TERMCAP_ue=$(printf "\e[0m") \
        LESS_TERMCAP_us=$(printf "\e[1;32m") \
        man "$@"
}

html()
{
    echo "<html>" > $1
    echo "\t<head>" >> $1
    echo "\t</head>" >> $1
    echo "\t<body>" >> $1
    echo "\t</body>" >> $1
    echo "</html>" >> $1
}

sp()
{
    echo "<?php" >> $1
    echo "" >> $1
    echo "?>" >> $1
}

sc()
{
    if [ "$1" = "sh" ]
    then
        echo "#!/bin/sh" >> $2
    elif [ "$1" = "php" ]
    then
        echo "#!/usr/bin/php" >> $2
        sp $2
    fi
}
