#!/usr/bin/env bash

## This script installs the dotfiles in this directory to the user's home directory
## bashrc and bash_profile are the only exposed entry points to bash configuration

## This is a reasonable precision at which to generate timestamps for 'unique' suffixes
function safe-link {
	if [ "$#" -ne 3 ]; then
		set -e 1;
		return;
	fi

	local origfile="${1}"
	local altfile="${2}"
	local suffix="${3}"
	local backupdir=~/dotfiles-backup/dotfiles.d.bk-"${suffix}"

	echo " ==> Setting up ${origfile}"

	if [ -f "${origfile}" ]; then
		if ! [ -d "${backupdir}" ] ; then
			mkdir -p "${backupdir}"
			echo "Created backup directory: ${backupdir}"
		fi
		if [ -L "${origfile}" ]; then
			ln -s $(readlink -f "${origfile}") "${backupdir}/$(basename ${origfile})"
			rm "${origfile}"
		else
			mv "${origfile}" "${backupdir}"/
			ln -s "${altfile}" "${origfile}"
		fi
	else
		ln -s "${altfile}" "${origfile}"
	fi
}

suffix="$(date +%Y%m%d%H%M%S)"

SOURCE="${BASH_SOURCE[0]}"

# resolve $SOURCE until the file is no longer a symlink
while [ -h "$SOURCE" ]; do
	DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null && pwd )"
	SOURCE="$(readlink "$SOURCE")"
	# if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
	[[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" 
done
DIR="$(cd "$( dirname "${SOURCE}" )" >/dev/null && pwd)"

if [ $# -eq 0 ]; then
	echo "At least one of -b, -f or -v must be present"
	echo
	echo "Usage: install.sh -b|-f|-v"
	echo "    -b Installs bash config"
	echo "    -f Installs fish config"
	echo "    -g Installs git config"
	echo "    -v Installs neovim config"
	echo ""
fi

while getopts ":bfgv" opt; do
	case $opt in
	b)
		echo "Installing bash config..."
		safe-link ~/.bash_profile "${DIR}"/bash.d/bash_profile "${suffix}"
		safe-link ~/.bashrc "${DIR}"/bash.d/bashrc "${suffix}"
		safe-link ~/.inputrc "${DIR}"/bash.d/inputrc "${suffix}"
		;;
	f)
		echo "Installing fish config..."
		;;
	g)
		echo "Installing git config..."
		safe-link ~/.gitconfig "${DIR}"/gitconfig "${suffix}"
		;;
	v)
		echo "Installing neovim config..."
		NVIM_BASE=~/.config
		mkdir -p "${NVIM_BASE}"/nvim
		safe-link ~/.vim "${DIR}"/vim.d/vim/ "${suffix}"
		safe-link "${NVIM_BASE}"/nvim/init.vim "${DIR}"/vim.d/vimrc "${suffix}"
		;;
	\?)
		echo "Invalid option: -${OPTARG}"
		;;
	esac
done

