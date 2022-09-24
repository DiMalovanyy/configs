#!/bin/bash

status_code=0
script_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd -P)

exit_with_msg() {
    echo "[ERROR]: $1"
    exit 1
}

vimrc_file=${HOME}/.vimrc
vim_dir=${HOME}/.vim

echo "[INFO]: Installing vim configs start"

# Creating backup file if required (.vimrc and .vim dir already exist)
if [ -e "${HOME}/.vimrc" ]; then
	echo "Creating backup copy of existing .vimrc"
	mv -f ${HOME}/.vimrc ${HOME}/.vimrc_backup
	echo "Backup copy of .vimrc created: .vimrc_backup"
fi

if [ -d "${HOME}/.vim" ]; then
    echo "${HOME}/.vim dir alredy exist, creataing backup copy \".vim_backup\""
    mv -f ${HOME}/.vim ${HOME}/.vim-backup
fi

# Create all requred vim configs files
mkdir -p ${vim_dir}
touch ${vimrc_file}

# Download plug from remote server
which curl > /dev/null
[ $? -ne 0 ] && exit_with_msg "Could not found curl in system"

curl -fLo ${script_dir}/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim > /dev/null
[ $? -ne 0 ] && exit_wirh_msg "Could not download plug"

# Installation (Linking) all vim requred files

# Link .vimrc
ln -s -f ${script_dir}/vimrc.vim ${HOME}/.vimrc
[ $? -ne 0 ] && exit_with_msg "Failed to install vim configs on system" 

# Link autoload
link_folders=(autoload plugin_configs)
for link_folder in ${link_folders[*]}; do
    ln -s -F -f ${script_dir}/${link_folder} ${HOME}/.vim
    [ $? -ne 0 ] && exit_with_msg "Could not install .vim/${link_folder} on system"
done

# Install all plugins via Plug
vim +PlugInstall +qall

echo "[INFO]: Vim Configs Successfully installed"

exit 0

