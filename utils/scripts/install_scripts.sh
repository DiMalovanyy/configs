#!/usr/bin/env zsh

shopt -s extglob
current_script_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd -P)
scripts_dir=${HOME}/.scripts
scripts_utils_dir=${scripts_dir}/utils
die_on_error='[ $? -ne 0 ] && exit $?'

if [ -d ${scripts_utils_dir} ]; then
    # Make backup
    rm -rf ${scripts_dir}/utils-backup && eval ${die_on_error}
    mv -f ${scripts_utils_dir} ${scripts_dir}/utils-backup && eval ${die_on_error}
fi

mkdir -p ${scripts_utils_dir} && eval ${die_on_error}

# Symlink all files (except install) to scripts_dir
ln -s -f ${current_script_dir}/!(install_scripts.sh) ${scripts_utils_dir} && eval ${die_on_error}

exit 0

