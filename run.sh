#!/bin/bash
echo "[+] getting latest version of technodrome"
git pull
echo "[+] downloading wordlists"
git clone https://github.com/danielmiessler/SecLists.git ./wordlists/SecLists 2>/dev/null
cd ./wordlists/SecLists 2>/dev/null
git pull 2>/dev/null
cd ../..
echo "[+] updating environmental variables from configs/env"
file="./configs/env"
zsh="./configs/zsh"
cp $zsh.bk $zsh
while IFS= read line
do
	        echo "export $line" >> ./configs/zsh
done <"$file"
echo "[+] building docker"
docker build . -t dozerman
echo "[+] running docker"
docker run -v $(pwd)/wordlists:/root/wordlists -h technodrome -ti dozerman

