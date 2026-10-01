
# Homebrew first, so HOMEBREW_PREFIX is available to everything below (and to zshrc).
if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -x /usr/local/bin/brew ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

###########################################################
# Misc environment variables
###########################################################
export NVM_DIR="$HOME/.nvm"
export PKG_CONFIG_PATH="${HOMEBREW_PREFIX}/opt/openssl@3/lib/pkgconfig"
export ITERM_ENABLE_SHELL_INTEGRATION_WITH_TMUX=YES
export SSO_ROLE_NAME=sso_aws_platformeng
# Airflow config (work; only set where that project exists)
[[ -d "$HOME/projects/greenfield/airflow" ]] && export AIRFLOW_HOME="$HOME/projects/greenfield/airflow/"


# ensure pip works like this:  "pip install ".[all]"
#alias pip=noglob pip



# >>> Codex installer >>>
export PATH="$HOME/.local/bin:$PATH"
# <<< Codex installer <<<
