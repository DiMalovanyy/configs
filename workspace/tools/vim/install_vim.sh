#!/usr/bin/env zsh

import_script utils/logger
import_script utils/color
import_script utils/error

status_code=0
script_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd -P)

configure_lighweighted=0

create_backups() {
    # Creating backup file if required (.vimrc and .vim dir already exist)
    if [ -e "${HOME}/.vimrc" ]; then
        log_info "Creating backup copy of existing .vimrc -> .vimrc_backup"
        mv -f ${HOME}/.vimrc ${HOME}/.vimrc_backup
        [ $? -ne 0 ] && die_with_error "Could not create backup .vimrc file"
    fi

    if [ -d "${HOME}/.vim" ]; then
        log_info "${HOME}/.vim dir alredy exist, creataing backup copy .vim -> .vim_backup"
        rm -rf ${HOME}/.vim-backup
        mv -f ${HOME}/.vim ${HOME}/.vim-backup
        [ $? -ne 0 ] && die_with_error "Could not cread backup .vim dir"
    fi
}

restore_backups() {
    # Restoring original vim files from backup copies
    if [ -e "${HOME}/.vimrc_backup" ]; then
        log_info "Restore ${HOME}/.vimrc from backup file ${HOME}/.vimrc_backup"
        mv -f ${HOME}/.vimrc_backup ${HOME}/.vimrc
        [ $? -ne 0 ] && die_with_error "Could not resotre .vimrc from backup"
    fi
    if [ -d "${HOME}/.vim_backup" ]; then
        log_info "Restore ${HOME}/.vim from backup file ${HOME}/.vim_backup"
        rm -rf ${HOME}/.vim
        mv -f ${HOME}/.vim_backup ${HOME}/.vim
        [ $? -ne 0 ] && die_with_error "Could not restore .vim from backup"
    fi
}

create_backups

# Check if required minimum(lightweighted) installation
if [ $# -ge 2 ]; then
    if [ "$1" == "light" ]; then
        /bin/bash ${script_dir}/lightweighted/install_vim_light.sh
        exit $?
    fi
fi

vim_dir=${HOME}/.vim
vimrc_file=${HOME}/.vimrc

log_info "Installing vim configs start"

# Create all requred vim configs files
mkdir -p ${vim_dir}
touch ${vimrc_file}

# Download plug from remote server
which curl > /dev/null
[ $? -ne 0 ] && die_with_error "Could not found curl in system"

if [ ! -e ${script_dir}/autoload/plug.vim ]; then
    log_info "Installing Plug from remote server"
    curl -fLo ${script_dir}/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim > /dev/null
    [ $? -ne 0 ] && die_with_error "Could not download plug"
else
    log_info "Plug already installed"
fi

which node > /dev/null
if [ $? -ne 0 ]; then 
    log_info "Installing node js for COC competion"
    curl -sL install-node.vercel.app/lts | sudo bash
    [ $? -ne 0 ] && die_with_error "Could not download node.js"
else
    log_info "Node.js for COC already installed"
fi

# Installation (Linking) all vim requred files

# Link .vimrc
ln -s -f ${script_dir}/vimrc.vim ${HOME}/.vimrc
[ $? -ne 0 ] && die_with_error "Failed to install vim configs on system" 

# Link autoload
link_folders=(autoload plugin_configs)
for link_folder in ${link_folders[*]}; do
    ln -s -F -f ${script_dir}/${link_folder} ${HOME}/.vim
    [ $? -ne 0 ] && die_with_error "Could not install .vim/${link_folder} on system"
done


# Link COC settings
ln -s -f ${script_dir}/coc/coc-settings.json ${vim_dir}/coc-settings.json
[ $? -ne 0 ] && die_with_error "Failed to links coc_settings.json"

# Install all plugins via Plug
vim +PlugInstall +qall


# Install COC language servers
./coc/install_servers.sh
[ $? -ne 0 ] && die_with_error "Failed to install coc language servers"
log_info "COC Language servers successfully installed"


log_info "Vim Configs Successfully installed"

exit 0
