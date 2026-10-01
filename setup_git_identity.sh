#!/usr/bin/env bash
#
# Git identity is per-machine (personal vs work), so it is NOT in the shared
# gitconfig. ~/.gitconfig includes ~/.gitconfig.local; this creates it once.
#
LOCAL="$HOME/.gitconfig.local"

if git config -f "$LOCAL" user.email >/dev/null 2>&1; then
  echo "Git email already set in $LOCAL: $(git config -f "$LOCAL" user.email)"
  exit 0
fi

read -r -p "Git email for commits on THIS machine: " email
if [[ -z "$email" ]]; then
  echo "No email entered. Set it later with: git config -f ~/.gitconfig.local user.email you@example.com"
  exit 0
fi
git config -f "$LOCAL" user.email "$email"
echo "Wrote user.email=$email to $LOCAL"
