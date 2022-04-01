#!/bin/bash
# Simple password manager
# sudo apt install p7zip-full
cd "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"
if [[ "$1" == "edit" || "$1" == "init" ]]; then
    dir=/dev/shm/${USER}_${RANDOM}
    mkdir $dir 2> /dev/null
    if [[ "$1" == "init" ]]; then
        if [[ ! -s "pass.7z" ]]; then
            echo "Store passwords here" > $dir/pass.txt
        else
            echo "Already initialized"
            exit
        fi
    fi
    if [[ "$1" == "edit" ]]; then
        touch $dir/pass.txt
        chmod -R 00700 $dir
        echo -n "Enter password: "
        7za e -so pass.7z pass.txt > $dir/pass.txt
    fi
    if [[ -s "$dir/pass.txt" ]]; then
        vim -c 'set nobackup' -c 'set nowritebackup' -c 'set noswapfile' -c 'set noundofile' $dir/pass.txt
        7za a -t7z -m0=lzma2 -mx=9 -mfb=64 -md=32m -ms=on -mhe=on -p $dir/pass.7z $dir/pass.txt
        if [[ -s "$dir/pass.7z" ]]; then
            cp pass.7z pass-backup.7z
            cp $dir/pass.7z pass.7z
            #rm pass-backup.7z
            rm $dir/pass.7z
        fi
    else
        echo "Invalid password"
    fi
    shred -u $dir/pass.txt 2> /dev/null
    rmdir $dir 2> /dev/null
else
    (sleep 0.1 ; echo -n "Enter password: ") & \
    7za e -so pass.7z pass.txt | \
    vim -c 'set nobackup' -c 'set nowritebackup' -c 'set noswapfile' -c 'set noundofile' -
fi
