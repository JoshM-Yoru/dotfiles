
# .bashrc
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zprofile

# Source global definitions
if [ -f /etc/zshrc ]; then
	. /etc/zshrc
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
if [ -d ~/.zshrc.d ]; then
	for rc in ~/.zshrc.d/*; do
		if [ -f "$rc" ]; then
			. "$rc"
		fi
	done
fi

unset rc


export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
. "$HOME/.cargo/env"

# PS1="$(tput setaf 14) yoru$(tput setaf 199)@$(tput setaf 14)\h $(tput setaf 199)\W $(tput setaf 14)>$(tput setaf 199)>$(tput setaf 14)>$(tput setaf 199) ";
# export PS1;

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


# export JVM_ARGS="-javaagent:~/Programming/Java/Lombok/lombok.jar"

alias ls="exa"
eval "$(thefuck --alias fuck)"
eval "$(zoxide init zsh)"
eval "$(starship init zsh)"

if (( $+commands[luarocks] )); then
    eval `luarocks path --bin`
fi


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# nitrogen --restore

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# bun completions
[ -s "/home/Yoru/.bun/_bun" ] && source "/home/Yoru/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
export JDTLS_JVM_ARGS="-javaagent:$HOME/Programming/Java/Lombok/lombok.jar"

neofetch
# neofetch --kitty ~/Pictures/2bneo.jpg
