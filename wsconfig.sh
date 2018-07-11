# CodeSinppest workspace home path.
CSHOME=./
SNIPPETS_SPACES=./snippets/
WSCONFIG_FN="wsconfig.txt"
WSCONFIG_F=$CSHOME/$WSCONFIG_FN

mk_wsconfig() {
    if [ -f $WSCONFIG_F ]
    then
	echo ""
    else
    	touch $WSCONFIG_F
    fi
}

# if no parameters, use the default workspace.
# if usrs want to create new snippet space like Java space, this function can be called as well to create a new snippet space.
mk_snippets_spaces() {
    if [ $# -eq 0 ]
    then
	if [ -d $SNIPPETS_SPACES ]
	then
	    echo ""
	    echo "SnippetSpaces folder exists."
	else
	    mkdir -p $SNIPPETS_SPACES

	    # once the default snippet folder is created, its path should be wrote into wsconfig.txt to be recorded.
	    append_wscfg "default" "$SNIPPETS_SPACES"
        fi
    elif [ $# -gt 0 ]
	SPACE_NAME=$1
        if [ -d $SPACE_NAME ]
	then
	    echo ""
	else
	    mkdir -p $SNIPPETS_SPACE$SPACE_NAME
	    # append_wscfg "default" "$SNIPPETS_SPACES"
	fi
    then
	echo ""
    fi
    return 0  
}

# select current working snippet space.
switch_current_snippet() {
    
    local snippet_name=""
    local snippet_path=""
    
    for line in $(cat wsconfig.txt)
    do
	line_str=$line
	index=$(expr index ${line} =)
	if [ "$index" == "0" ]
	then
	    # means no selected snippet folder is found.
	    echo ""
	else
	    snippet_name=${line:0:$(expr $index - 1)}
	    snippet_path=${line:$index}
	    find_current "$line"
	    find_res=`echo $?`
	    if [ $res = "1" ]; then
		# not a current space
		is_selected "$snippet_name" "$line"
		continue
	    else
		break
	    fi
	fi
    done
}

# select any working snippet space with a specific name.
select_any_snippet() {
    if [ $# -eq 0 ]
    then
	# if no args, return default snippet space.
        select_current_snippet
    elif [ $# -gt 0 ]
    then
	space_name=$1
	for line in $(cat wsconfig.txt)
	do
	    line_str=$line
	    index=$(expr index ${line} =)
	    if [ "$index" == "0" ]
	    then
		# means no selected snippet folder is found.
		echo ""
	    else
		snippet_name=${line:0:$(expr $index - 1)}
	    fi
	done
    fi	    
}

# read snippet space path from wsconfig.txt file.
read_wscfg() {
    for line in $(cat wsconfig.txt)
    do
	echo $line
        index=$(expr index $line =)
	echo ${line:0:$(expr $index - 1)}
	echo ${line:$index}
	echo $prefix
    done
	
    sed -i '1i\a new line' wsconfig.txt
}

# read and append new name and path to wsconfig.txt file.
# format: Java=C:\workproject\java\
append_wscfg() {
    
    local snippet_space_name=$1
    local snippet_space_path=$2
    	
    if [ -f $WSCONFIG_F ] && [ -r $WSCONFIG_F ] && [ -w $WSCONFIG_F ]
    then
	if [ "$1" == "default" ]
	then
	    if [ -s $WSCONFIG_F ]
	    then
		echo ""
	    else
		echo "$snippet_space_name=$snippet_space_path" >> $WSCONFIG_F
	    fi
	else
	    echo ""
	fi
    else
	echo "The file wsconfig.txt is not a file or it can't read."
    fi		
}

# this method is used to find current snippet working space.
# a current working snippet space path is such as "(current) Java=./Java/"
# so a line string in wsconfig.txt will be passed in as a parameter.
find_current() {
    cfg_line=$1
    current="(current)"
    if ["$cfg_line" == ""]
    then
	echo "You passed in a invalid config path."
	return 1
    else
	is_current=$(echo $cfg_line | grep "$(current)")
	if [[ "$is_current" != "" ]]
	then
	    return 0
	else
	    return 1
	fi
    fi
}


# User is able to pass in two parameters.
# @param target: a string value. it means that which folder name you want to find.
# @param path:   a string value. it means that path of a folder.
is_selected() {
    target=$1
    cfg_line=$2
    is_current=$(echo $cfg_line | grep "$(target)")
    if [[ "$is_current" != "" ]]
    then
        return 0
    else
	return 1
    fi
}

