#!/usr/bin/env python3
import json
import os
import subprocess

script_dir = os.path.dirname(os.path.realpath(__file__))
coc_extension_file = script_dir + "/coc_extensions.json"

if __name__ == "__main__":
    with open(coc_extension_file) as f:
        coc_extensions = json.load(f)
        coc_extension_names = [ extension["name"] for extension in coc_extensions["extensions"]]
        install_command = ' '.join(coc_extension_names)
        subprocess.check_call("vim +\'CocInstall -sync " + install_command + "\' +qall", shell=True)
