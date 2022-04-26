#!/usr/bin/sh

function build () {
				path_to_file=$1
				directory=`dirname $path_to_file`
				filename=`basename $path_to_file`
				file_ext=${filename##*.}
				[ $file_ext != dot ] && exit
				built="$directory/${filename::-4}"
				dotpp.py -s lookup.py -t $path_to_file -o $built
				echo "built $path_to_file->$built"
}

# export this for find subshell to pick it up
export -f build

find . -type f -exec bash -c 'build "{}"' \;
