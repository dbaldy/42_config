# Definition du PATH
PATH=$HOME/scripts:$HOME/usr/local/bin:$HOME/usr/bin:$HOME/.brew/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/usr/texbin
export PATH

# Configuration de l'historique
HISTFILE=~/.zshrc_history
SAVEHIST=5000
HISTSIZE=5000
setopt inc_append_history
# setopt share_history

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

# Definition des repertoires de travail et de correction
MODULE=unix
export MODULE
PROJECT=42sh
export PROJECT
WP=/nfs/zfs-student-3/users/2013/mdelage/Rendu/perso/$MODULE/$PROJECT
export WP
MOD_COR=unix
export MOD_COR
PROJ_COR=ftsh3
export PROJ_COR
COR=/nfs/zfs-student-3/users/2013/mdelage/Rendu/correction/$MOD_COR/
export COR
LIB=/nfs/zfs-student-3/users/2013/mdelage/libft/
export LIB

# Definition des couleurs
source ~/.ls_colors

# Definition du prompt
PROMPT="%n@%m:%~
> "
precmd ()
{
	NORMAL="%{$reset_color%}"
	ISGIT=$(git status 2> /dev/null)
	if [ -n "$ISGIT" ]
	then
		STATUS=$(echo "$ISGIT" | grep "modified" | cut -d ' ' -f 4)
		BRANCH=$(git branch | cut -d ' ' -f 2 | tr -d '\n')
		if [ -n "$STATUS" ]
		then
			COLOR="%{$fg[red]%}"
		else
			COLOR="%{$fg[green]%}"
		fi
		RPROMPT="%{$COLOR%}($BRANCH)%{$NORMAL%} "
	else
		RPROMPT=""
	fi
	if [[ $(cd $WP && git status | grep "modified" | cut -d ' ' -f 4) > /dev/null ]]
	then
		COLOR2="%{$fg[red]%}"
	else
		COLOR2="%{$fg[green]%}"
	fi
	RPROMPT="$RPROMPT%{$COLOR2%}$MODULE:$PROJECT%{$NORMAL%}"
}

# Definition des alias raccourcis
alias cdc="cd $WP"
alias cdl="cd $LIB"
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
alias ls='ls -G'
alias modsh='emacs ~/dotfiles/.zshrc'
alias norme='~/scripts/norme'
alias norme2='~/scripts/sn.sh'
alias norme3='python ~/scripts/norme.py'
alias norme4='python ~/scripts/norme.py'
alias proto='~/scripts/proto'
alias rl='source ~/.zshrc'
alias sd='emacs'

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

# Experimental
TERM=xterm-256color
