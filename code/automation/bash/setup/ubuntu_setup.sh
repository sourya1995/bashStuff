#!/usr/bin/env bash
#---
# Excerpted from "Small, Sharp, Software Tools",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/bhcldev for more book information.
#---
datestamp=$(date +"%Y%m%d%H%M")

sudo -v

ERRORCOLOR=$(tput setaf 1)    # Red
SUCCESSCOLOR=$(tput setaf 2)  # Green
INFOCOLOR=$(tput setaf 3)     # Yellow
RESET=$(tput sgr0)

function info()    { echo "${INFOCOLOR}${@}${RESET}"; }
function success() { echo "${SUCCESSCOLOR}${@}${RESET}"; }
function error()   { echo "${ERRORCOLOR}${@}${RESET}" >&2; }

info "Starting install at $(date)"

declare -a apps=(tree curl unzip make)

info "Updating Package list"
sudo apt-get update

info "Installing apps:"
for app in ${apps[@]}; do
  info "Installing ${app}"
  sudo apt-get -y install $app
  result=$?
  if [ $result -ne 0 ]; then
    error "Error: failed to install ${app}"
    exit 1
  else
    success "Installed ${app}"
  fi
done


echo "Installing Node.js from Nodesource"
curl -sL https://deb.nodesource.com/setup_11.x | sudo -E bash -
sudo apt-get -y install nodejs
result=$?
if [ $result -ne 0 ]; then
  error "Error: Couldn't install Node.js."
  exit 1
else
  success "Installed Node.js"
fi

info "Setting up ~/.bashrc"

if [ -f ~/.bashrc ]; then
  oldbashrc=~/.bashrc.${datestamp}
  info "Found existing ~/.bashrc file. Backing up to ${oldbashrc}."
  mv ~/.bashrc ${oldbashrc}
fi

cat << 'EOF' > ~/.bashrc
[ -z "$PS1" ] && return

shopt -s histappend
HISTCONTROL=ignoreboth
HISTSIZE=1000
HISTFILESIZE=2000
HISTIGNORE="exit:clear"

export EDITOR=nano
export VISUAL=nano

export PATH=~/bin:$PATH
EOF

result=$?
if [ $result -ne 0 ]; then
  error "Error: failed to create ~/.bashrc"
  exit 1
else
  success "Created ~/.bashrc"
fi

success "Done! Run   source ~/.bashrc    to apply changes."
