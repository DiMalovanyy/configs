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
	echo "[INFO]: Creating backup copy of existing .vimrc -> .vimrc_backup"
	mv -f ${HOME}/.vimrc ${HOME}/.vimrc_backup
    [ $? -ne 0 ] && exit_with_msg "Could not create backup .vimrc file"
fi

if [ -d "${HOME}/.vim" ]; then
    echo "[INFO]: ${HOME}/.vim dir alredy exist, creataing backup copy .vim -> .vim_backup"
    rm -rf ${HOME}/.vim-backup
    mv -f ${HOME}/.vim ${HOME}/.vim-backup
    [ $? -ne 0 ] && exit_with_msg "Could not cread backup .vim dir"
fi

# Create all requred vim configs files
mkdir -p ${vim_dir}
touch ${vimrc_file}

# Download plug from remote server
which curl > /dev/null
[ $? -ne 0 ] && exit_with_msg "Could not found curl in system"

if [ ! -e ${script_dir}/autoload/plug.vim ]; then
    echo "[INFO]: Installing Plug from remote server"
    curl -fLo ${script_dir}/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim > /dev/null
    [ $? -ne 0 ] && exit_wirh_msg "Could not download plug"
else
    echo "[INFO]: Plug already installed"
fi

which node > /dev/null
if [ $? -ne 0 ]; then 
    echo "[INFO]: Installing node js for COC competion"
    curl -sL install-node.vercel.app/lts | sudo bash
    [ $? -ne 0 ] && exit_with_msg "Could not download node.js"
else
    echo "[INFO]: Node.js for COC already installed"
fi


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



# Link COC settings
ln -s -f ${script_dir}/coc/coc-settings.json ${vim_dir}/coc-settings.json
[ $? -ne 0 ] && exit_with_msg "Failed to links coc_settings.json"

# Install all plugins via Plug
vim +PlugInstall +qall


# Install COC language servers
./coc/install_servers.sh
[ $? -ne 0 ] && exit_with_msg "Failed to install coc language servers"
echo "[INFO]: COC Language servers successfully installed"


echo "[INFO]: Vim Configs Successfully installed"

exit 0

