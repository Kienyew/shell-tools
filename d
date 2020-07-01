#!/bin/bash
# create a template source code file and output the file path


AVAILABLE_FILE_TYPES=("c" "py" "cpp" "js" "html" "hs" "php" "cs" "rs")
FILE_TYPE_COUNT=${#AVAILABLE_FILE_TYPES[@]}
BASEDIR="${HOME}/Misc/code"


usage() {
	echo -ne "\033[1;36m""Usage""\033[0m"": d ("
	for (( i=0; i<$FILE_TYPE_COUNT; i++ )) do
		echo -ne "\033[1;32m""${AVAILABLE_FILE_TYPES[$i]}""\033[0m"

		if (( $i != $FILE_TYPE_COUNT - 1 )); then
			echo -n ' | '
		fi
	done
	echo ') [date_shift=today]'
}

if [ -z "$1" ] || [ "$1" == "-h" ] || [ "$1" == "--help" ] 
then
	usage > /dev/stderr
	exit 1
fi

suffix="$1"
date_shift="$2"
now="$(date +"%Y-%m-%d" --date="$2")"
case "$suffix" in
"c")
	FILENAME="${BASEDIR}"/c/"$now"."$suffix" ;
	COMMENT_PREFIX="/*" ;
    COMMENT_POSTFIX="*/";
	read -r -d '' PLACEHOLDER << EOF
int main(int argc, char* argv[]) {

}
EOF
;;

"py")
	FILENAME="${BASEDIR}"/python/"$now"."$suffix";
	COMMENT_PREFIX="#" ;
	PLACEHOLDER="" ;;

"cpp")
	FILENAME="${BASEDIR}"/cpp/"$now"."$suffix";
	COMMENT_PREFIX="//" ;
	read -r -d '' PLACEHOLDER << EOF
int main(int argc, char* argv[]) {

}
EOF
;;

"js")
	FILENAME="${BASEDIR}"/js/"$now"."$suffix";
	COMMENT_PREFIX="//" ;
	PLACEHOLDER="" ;;

"html")
	FILENAME="${BASEDIR}"/html/"$now"."$suffix";
	COMMENT_PREFIX="<!--"
	COMMENT_POSTFIX=" -->" ;
	read -r -d '' PLACEHOLDER << EOF
<!DOCTYPE html>
<html>
<head>
	<title>${now}</title>
</head>
<body>

</body>
</html>
EOF
;;


"hs")
	FILENAME="${BASEDIR}"/haskell/"$now"."$suffix";
	COMMENT_PREFIX="--" ;
	read -r -d '' PLACEHOLDER << EOF
module Main where

main :: IO()
main = do
  print "Hello Haskell @ ${now}"
EOF
;;

"php")
	FILENAME="${BASEDIR}"/php/"$now"."$suffix"
	COMMENT_PREFIX="//"
	read -r -d '' PLACEHOLDER << EOF
<?php

?>
EOF
;;

"cs")
	FILENAME="${BASEDIR}"/cs/"$now"."$suffix"
	COMMENT_PREFIX="//"
	read -r -d '' PLACEHOLDER << EOF
class Program
{
	public static void Main(int argc, string[] argv)
	{
		// code
	}
}
EOF
;;
"rs")
    FILENAME="${BASEDIR}"/rs/"$now"."$suffix"
    COMMENT_PREFIX="//"
    read -r -d '' PLACEHOLDER << EOF
fn main() {

}
EOF
;;

esac

if [ -z "$FILENAME" ]
then
	echo "File extension '$suffix' not available." >&2
	exit 1
fi

if [ ! -f "$FILENAME" ]
then
	echo "${COMMENT_PREFIX} $(date +%c) ${COMMENT_POSTFIX}"$'\n'"${PLACEHOLDER}"$'\n' > "$FILENAME"
fi

echo "$FILENAME"
