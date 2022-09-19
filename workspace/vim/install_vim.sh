#!/bin/bash

status_code=0
script_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd -P)

echo "Installing vim configs start"

if [ -e "${HOME}/.vimrc" ]; then
	echo "Creating backup copy of existing .vimrc"
	cp ${HOME}/.vimrc ${HOME}/.vimrc_backup
	echo "Backup copy of .vimrc created: .vimrc_backup"
	rm -rf ${HOME}/.vimrc
fi

ln -s ${script_dir}/vimrc.vim ${HOME}/.vimrc
status_code=$?
if [ ${status_code} -ne 0 ]; then
	echo "Failed to install vim configs on system"
else
	echo "Vim configs successfully instaled on system"
fi

exit ${status_code}

