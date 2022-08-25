my_path=$(ls -d /root/tools/* | sed -z 's/\n/:/g')
my_path="$my_path/root/go/bin:/root/tools/GraphQLmap/bin:"
echo 'export PATH=$PATH:'$my_path$'\n'"$(cat /root/zsh)" > /root/.zshrc

for FILE in /root/go/bin/*; do
	#FILE=$(echo $FILE | sed -i 's/\/root\/go\/bin//')
	FILE=$(basename "$FILE")
	ln -s /root/go/bin/$FILE /root/tools/$FILE; 
done
