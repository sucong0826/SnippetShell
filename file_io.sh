# Print all files in a snippet folder.
print_snippet_space() {
    folder_path=$1
    cd $folder_path
    
    index=1
    for file in ./*
    do
	    if [ -f $file ]
            then
	        f_name=$(basename $file)
	        f_path=$(dirname $file)
		echo "$index. $f_name ($f_path)"
		index=$[$index + 1]
	    fi
    done
}
