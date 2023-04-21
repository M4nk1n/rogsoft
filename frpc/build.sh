#!/bin/sh

# build script for rogsoft project

MODULE="frpc"
VERSION="2.0"
TITLE="frpc内网穿透"
DESCRIPTION="支持多种协议的内网穿透软件"
HOME_URL="Module_frpc.asp"
TAGS="网络 穿透"
AUTHOR="clang"

do_build_result() {
	rm -f ${MODULE}/.DS_Store
	rm -f ${MODULE}/*/.DS_Store
	rm -f ${MODULE}.tar.gz

	if [ -z "$TAGS" ];then
		TAGS="其它"
	fi

	# add version to the package
	cat > ${MODULE}/version <<-EOF
	${VERSION}
	EOF

	tar -zcvf ${MODULE}.tar.gz $MODULE
	md5value=$(md5 ${MODULE}.tar.gz | tr " " "\n" | sed -n '$p')
	cat > ./version <<-EOF
	${VERSION}
	${md5value}
	EOF
	cat version

	DATE=$(date +%Y-%m-%d_%H:%M:%S)
	cat > ./config.json.js <<-EOF
	{
    "version":"$VERSION",
    "md5":"$md5value",
    "home_url":"$HOME_URL",
    "title":"$TITLE",
    "description":"$DESCRIPTION",
    "tags":"$TAGS",
    "author":"$AUTHOR",
    "link":"$LINK",
    "changelog":"$CHANGELOG",
    "build_date":"$DATE"
	}
	EOF

	#update md5
	# python ../softcenter/gen_install.py stage2
  echo ""
  echo "Version: $VERSION"
  echo "MD5: $md5value"
  echo "Build_date: $DATE"
  echo "自行修改 'Changlog'"
  echo ""
}

# Check and include base
DIR="$( cd "$( dirname "$BASH_SOURCE[0]" )" && pwd )"

# change to module directory
cd $DIR

# do something here
do_build_result
