#!/data/data/com.termux/files/usr/bin/bash

cwd=$(pwd)
name=$(basename "$0")
export exploitdbinst="$cwd/$name"
#sha_actual=$(sha256sum $(echo $exploitdbinst))
#echo $sha_actual
if [ $name != "termux_searchsploit.sh" ]; then
	echo "[-] Please do not use third-party stolen scripts"
	exit 1
fi

exploitdbvar=2019-01-12
exploitdbpath='/data/data/com.termux/files/home'
if [ -d "$exploitdbpath/exploitdb" ]; then
	echo "exploitdb is installed"
	exit 1
fi

cd $exploitdbpath
git clone --single-branch --depth 1 --branch $exploitdbvar https://github.com/offensive-security/exploitdb.git
cd $exploitdbpath/exploitdb
git config user.name "anonymous"
git config user.email "anonymous@example.com"

if [ -e $PREFIX/bin/searchsploit ];then
        rm $PREFIX/bin/searchsploit
fi

sed 's|path_array+=(.*)|path_array+=("/data/data/com.termux/files/home/exploitdb")|g' $exploitdbpath/exploitdb/.searchsploit_rc > ~/.searchsploit_rc
ln -sf $exploitdbpath/exploitdb/searchsploit $PREFIX/bin/searchsploit

$PREFIX/bin/find -type f -executable -exec termux-fix-shebang \{\} \;

chmod +rwx $PREFIX/bin/searchsploit

echo "you can directly use searchsploit rather than ./searchsploit as it is symlinked to $PREFIX/bin"
