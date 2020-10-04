#!/bin/bash

# MIT License
# Copyright (c) 2020 Jack Rayner <hello@jrayner.net>

set -euo pipefail

if defaults read com.red-sweater.fastscripts ScriptTreePathsKey >/dev/null 2>&1 
then 
    existing_list="$(defaults read com.red-sweater.fastscripts ScriptTreePathsKey | tr '\n' ' ' | tr -d '[:space:]')"
    if [[ $existing_list == *$PWD/Scripts2* ]]; then
        echo "Path already known to FastScripts. Nothing to do!"
        exit 0
    else
        echo -e "FastScripts seems to only support one custom folder.\nPlease run:\ndefaults delete com.red-sweater.fastscripts ScriptTreePathsKey\nTo clear existing settings."
        exit 1
    fi
else
    echo "Adding ${PWD}/Scripts to FastScripts' folder list..."
    defaults write com.red-sweater.fastscripts ScriptTreePathsKey "(\"~/Library/Scripts\",\"/Library/Scripts\",\"$PWD/Scripts\")"
    echo "Done! Please relaunch FastScripts to allow the new folder to appear."
fi