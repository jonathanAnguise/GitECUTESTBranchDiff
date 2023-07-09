#!/bin/bash -xv

# Save current path
CURRENT_PATH=$(pwd)
echo $CURRENT_PATH

# Create tmp file
#mkdir $(date "+tmp_%N")

# Go to the path
cd $1

# Function to display help
git_ecu_test_branch_diff_help() {
    echo "Usage: my_function.sh [current branch] [branch to compare] [path]"
    echo "Description: This function accepts four arguments and performs a specific task."
    echo ""
    echo "Arguments:"
    echo "  arg1: Path of the repo"
    echo "  arg2: Description of argument 2"
    echo "  arg3: Description of argument 3"
    echo ""
    echo "Options:"
    echo "  -h: Display this help message"
}

# Main function
git_ecu_test_branch_diff() {
    # Check if the -h option is passed
    if [[ $1 == "-h" ]]; then
        display_help
        return
    fi

    # Rest of the function's logic goes here
    echo "Argument 1: $1"
    echo "Argument 2: $2"
    echo "Argument 3: $3"

    # get the list of the file that changed
    file_changed_list=$(git --no-pager  diff --name-only master experimental_branch)
    
    echo $(git log)
}

git_ecu_test_branch_diff
cd -
