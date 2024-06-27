id >> /tmp/profile.log
if [ ! -f "/home/tom/.local" ]; then
	sudo ln -s "$HOME/.local" /home/tom/.local
	echo "ln result: $?" >> /tmp/profile.log
else
	echo "ln not done" >> /tmp/profile.log
fi
if [ ! -f "$HOME/.nix-profile" ]; then
	sudo ln -s "$HOME/.local/state/nix/profiles/profile" "$HOME/.nix-profile"
	echo "ln nix result: $?" >> /tmp/profile.log
else
	echo "ln nix not done" >> /tmp/profile.log
fi

grep "/nix/var" ~/.profile > /dev/null
if [ $? == 1 ]; then
	echo PATH='$PATH':/nix/var/nix/profiles/default/bin >> ~/.profile
	echo PATH='$PATH':/home/vscode/.nix-profile/bin >> ~/.profile
	echo PATH='$PATH':~/nvim/bin >> ~/.profile
	echo PATH="$PATH":/home/vscode/nvim/bin | sudo tee -a /etc/environment
fi
grep "alias vim" ~/.bashrc > /dev/null
if [ $? == 1 ]; then
	echo alias sudo=\'sudo -s --preserve-env=PATH \' >> ~/.bashrc
	echo alias vim=\'nvim\' >> ~/.bashrc
	echo alias gis=\'git status\' >> ~/.bashrc
	echo export SHELL=/bin/bash >> ~/.bashrc
fi
