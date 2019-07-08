#!/usr/bin/env bash

set -e
set -o pipefail

export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get install -y curl gnupg
rm -rf /var/lib/apt/lists/*

curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -

tee -a /etc/apt/sources.list.d/yarn.list >/dev/null <<"EOF"
deb https://dl.yarnpkg.com/debian/ stable main
EOF

packages="

bsdmainutils
curl
emacs-nox
git
haskell-stack
nodejs
python
python-pip
python3
python3-pip
python3-venv
ruby
ruby-bundler
sqlite3

"

export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get install -y $packages
rm -rf /var/lib/apt/lists/*

pip2 --disable-pip-version-check install pipreqs poetry
pip3 --disable-pip-version-check install pipreqs poetry
gem install gems
curl -fsSL https://raw.githubusercontent.com/cask/cask/master/go | python3
ln -s "$HOME/.cask/bin/cask" /usr/local/bin/

# https://github.com/docker-library/rails/issues/10#issuecomment-169957222
bundle config --global silence_root_warning 1

rm /tmp/docker-install-languages.bash