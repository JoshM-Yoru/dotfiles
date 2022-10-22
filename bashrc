# .bashrc


# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi


# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
	for rc in ~/.bashrc.d/*; do
		if [ -f "$rc" ]; then
			. "$rc"
		fi
	done
fi

unset rc

#neofetch alternator
NUMBER=$(( $RANDOM%2 ))
if [ $((NUMBER%2)) == 0 ]; then 
		neofetch --kitty ~/Pictures/shinobuneo.png
else
		neofetch --kitty ~/Pictures/2bneo.jpg
fi

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
. "$HOME/.cargo/env"

PS1="$(tput setaf 14) yoru$(tput setaf 199)@$(tput setaf 14)\h $(tput setaf 199)\W $(tput setaf 14)>$(tput setaf 199)>$(tput setaf 14)>$(tput setaf 199) ";
export PS1;

[ -f ~/.fzf.bash ] && source ~/.fzf.bash


# Load Angular CLI autocompletion.
source <(ng completion script)

export EDITOR='nvim'
export VISUAL='nvim'
