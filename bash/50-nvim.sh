create_link() {
	pushd ~/.local/share/nvim/mason/bin/vscode || exit
	filename=$(basename -- "$1")
	destination=$(find "$1" -type l -printf "%l")
	destination=$(echo "$destination" | sed -e "s#/home/[a-z]*/#/home/vscode/#")
	if [ ! -f "$filename" ]; then
		ln -s "$destination" "$filename"
	fi
	popd || exit
}
create_links() {
	for symlink in "$@"; do
		create_link "$symlink"
	done
}
export -f create_link
export -f create_links

if [ ! -d "$HOME/.local/share/nvim/mason/bin/vscode" ]; then
	mkdir -p "$HOME/.local/share/nvim/mason/bin/vscode"
fi
find ~/.local/share/nvim/mason/bin -maxdepth 1 -type l -exec bash -c 'create_links "$@"' bash {} +
echo PATH="$PATH":~/nvim/bin:~/.local/share/nvim/mason/bin/vscode>> ~/.bashrc
