# Read lib file wsconfig.sh.
# This shell is for creating configuration file and reading configs.

# create space config file
. wsconfig.sh
. file_io.sh

mk_wsconfig

# create default snippet spaces
mk_snippets_spaces
exit_code=$?
if [ $exit_code -eq 0 ]
then
    # default snippet space is created successfully.
    echo "A default snippet space is created successfully. If you't create other spaces, all snippets will be set here. Of course, you can create spaces by different programming languages, like C++/Java/Python. You can switch to your favorite space or most-used space as your default folder."
else
    echo "Failed to create default snippet space. You can create it by yourself."
fi

# switch to current working snippet space.
np=$(switch_current_snippet)

# main screen ui.
echo -e
echo -e "===================\tSimple Code Sinppets\t==================="
echo -e "\n # Recent Code Snippets (current snippet location : $np) \n"
echo -e "files are below:"
print_snippet_space $np

sleep 5
