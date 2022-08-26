#!/bin/bash
function add_wordlist(){
if [ "$3" == "git" ]; then
	git clone $1 $2 2>/dev/null
else
	wget $1 -O $2 2>/dev/null
fi
cd $2 2>/dev/null
git pull 2>/dev/null
cd ../..
}

echo "[+] getting latest version of technodrome"
git pull
echo "[+] downloading wordlists"
add_wordlist "https://github.com/danielmiessler/SecLists.git" "./wordlists/SecLists" "git"
add_wordlist "https://github.com/milo2012/pathbrute.git" "./wordlists/pathbrute" "git" 
echo "[+] updating environmental variables from configs/env"
file="./configs/env"
zsh="./configs/zsh"
cp $zsh.bk $zsh
while IFS= read line
do
	        echo "export $line" >> ./configs/zsh
done <"$file"
echo "[+] building docker"
docker build . -t technodrome
echo "[+] running docker"
docker run -v $(pwd)/wordlists:/root/wordlists -h technodrome -ti technodrome

