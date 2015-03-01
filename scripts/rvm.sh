#!/usr/local/bin/bash
if [ ! -d ~/.rvm ]; then
	# We need some packages, so ensure they're installed
	sudo pkg install -y curl gnupg >/dev/null
	curl -sSL https://rvm.io/mpapis.asc | gpg2 --import - >/dev/null
	\curl -sSL https://get.rvm.io | bash -s stable >/dev/null
fi
echo "rvm installed."
echo "You may have to log out and back in to use it."