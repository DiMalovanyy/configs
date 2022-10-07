#!/usr/bin/env zsh

script_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd -P)

# All logic based on .configrc file that will be modified by other modules
configrc=${HOME}/.configrc
if [ -e ${configrc} ]; then
    # Create backup copy
    mv -f ${configrc} ${HOME}/.configrc_backup
fi

configrc_base=${script_dir}/configrc

cp -f ${configrc_base} ${configrc}


read -r -d '' source_code << 'EOF'
# Don't change and left it at last line!!
source ${HOME}/.configrc
EOF


shell_name=$(basename ${SHELL})

# Append to shell rc file configrc loading logic

if [ "${shell_name}" = "zsh" ]; then 
    rc=${HOME}/.zshrc
    env=${HOME}/.zshenv
fi

if [ "$(tail -2 ${rc})" != "${source_code}" ]; then
    echo "${source_code}" >> ${rc}
fi

if [ ! -e ${env} ]; then
    touch ${env}
fi

if [ "$(tail -2 ${env})" != "${source_code}" ]; then
    echo "${source_code}" >> ${env}
fi
