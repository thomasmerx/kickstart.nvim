id >> /tmp/profile.log
if [ ! -f "/home/tom/.local" ]; then
	sudo ln -s "$HOME/.local" /home/tom/.local
	echo "ln result: $?" >> /tmp/profile.log
else
	echo "ln not done" >> /tmp/profile.log
fi

grep "/nvim/bin" ~/.bashrc > /dev/null
if [ $? == 1 ]; then
	echo alias sudo=\'sudo env PATH=\$PATH \' >> ~/.bashrc
	echo alias vim=\'nvim\' >> ~/.bashrc
	echo alias gis=\'git status\' >> ~/.bashrc
	echo PATH="$PATH":~/nvim/bin >> ~/.bashrc
	echo PATH="$PATH":/home/vscode/nvim/bin | sudo tee -a /etc/environment
	echo export SHELL=/bin/bash >> ~/.bashrc
fi
