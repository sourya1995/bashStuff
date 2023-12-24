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

info "Checking for Homebrew"
if which -s brew; then
  info "Homebrew installed"
else
  info "Installing Homebrew"
  /usr/bin/ruby -e \
  "$(curl -fsSL
        https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

declare -a apps=(tree curl unzip make nodejs)

info "Updating Package list"
brew update

info "Installing apps:"
for app in ${apps[@]}; do
  info "Installing ${app}"
  if brew list $app > /dev/null; then
    info "${app} is already installed"
  else
    brew install $app
  fi
  result=$?
  if [ $result -ne 0 ]; then
    error "Error: failed to install ${app}"
    exit 1
  else
    success "Installed ${app}"
  fi
done

# echo "Installing Node.js from Nodesource"
# curl -sL https://deb.nodesource.com/setup_11.x | sudo -E bash -
# sudo apt-get -y install nodejs
# result=$?
# if [ $result -ne 0 ]; then
#   error "Error: Couldn't install Node.js."
#   exit 1
# else
#   success "Installed Node.js"
# fi

info "Setting up ~/bash_profile"

if [ -f ~/.bash_profile ]; then
  oldprofile=~/.bash_profile.${datestamp}
  info "Found existing ~/.bash_profile file. Backing up to ${oldprofile}."
  mv ~/.bash_profile ${oldprofile}
fi

cat << 'EOF' > ~/.bash_profile
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
  error "Error: failed to create ~/.bash_profile"
  exit 1
else
  success "Created ~/.bash_profile"
fi

success "Done! Run   source ~/.bash_profile    to apply changes."
