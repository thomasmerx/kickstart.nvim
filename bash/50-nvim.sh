id >> /tmp/profile.log
if [ ! -L "/home/tom/.local" ]; then
	sudo ln -s "$HOME/.local" /home/tom/.local
	echo "ln result: $?" >> /tmp/profile.log
else
	echo "ln not done" >> /tmp/profile.log
fi
if [ ! -L "$HOME/.nix-profile" ]; then
	sudo ln -s "$HOME/.tools/state/nix/profiles/profile" "$HOME/.nix-profile"
	echo "ln nix result: $?" >> /tmp/profile.log
else
	echo "ln nix not done" >> /tmp/profile.log
fi

grep "/nix/var" ~/.profile > /dev/null
if [ $? -eq 1 ]; then
	echo "Updating ~/.profile" >> /tmp/profile.log
	echo PATH='$PATH':/nix/var/nix/profiles/default/bin >> ~/.profile
	echo PATH='$PATH':~/.nix-profile/bin >> ~/.profile
	echo PATH='$PATH':~/nvim/bin >> ~/.profile
	echo PATH='$PATH':~/.tools/bin >> ~/.profile
	echo PATH="$PATH":/home/vscode/nvim/bin | sudo tee -a /etc/environment
fi
grep "alias vim" ~/.bashrc > /dev/null
if [ $? -eq 1 ]; then
	echo "Updating ~/.bashrc" >> /tmp/profile.log
	echo alias sudo=\'sudo -s --preserve-env=PATH \' >> ~/.bashrc
	echo alias vim=\'nvim\' >> ~/.bashrc
	echo alias gis=\'git status\' >> ~/.bashrc
	echo export SHELL=/bin/bash >> ~/.bashrc
fi
grep "/.gitconfig" ~/.gitconfig > /dev/null
if [ $? -ge 1 ]; then
	echo "Updating ~/.gitconfig" >> /tmp/profile.log
	git config --global --add include.path /home/tom/.gitconfig
fi
if [ -d ~/.conan ]; then
	cp /etc/ssl/certs/ca-certificates.crt ~/.conan/cacert.pem
fi
