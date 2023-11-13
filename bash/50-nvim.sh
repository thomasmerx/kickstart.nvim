id >> /tmp/profile.log
if [ ! -f "/home/tom/.local" ]; then
	sudo ln -s "$HOME/.local" /home/tom/.local
	echo "ln result: $?" >> /tmp/profile.log
else
	echo "ln not done" >> /tmp/profile.log
fi
echo alias vim='nvim' >> ~/.bashrc
echo alias sudo='sudo ' >> ~/.bashrc
echo PATH="$PATH":~/nvim/bin >> ~/.bashrc
