all:
	./builddots.sh
	stow --verbose --target=$$HOME --ignore='.*\.dot' --restow `ls -d */ | grep -v -f .stowignore`

delete:
	stow --verbose --target=$$HOME --delete */

