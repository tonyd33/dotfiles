all:
	stow --verbose --target=$$HOME --ignore='.*\.dot' --restow */

delete:
	stow --verbose --target=$$HOME --delete */

