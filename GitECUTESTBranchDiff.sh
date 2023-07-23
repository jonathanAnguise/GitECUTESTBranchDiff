#!/bin/bash

# ECU-TEST path
ecu_test_path="/c/xxxxx/ecu.exe"

# Function to display help
git_ecu_test_branch_diff_help() {
    echo "Usage: GitECUTESTBranchDiff.sh [path] [branch to compare]"
    echo "Description: Copy files modified between the current folder and a specified branch."
    echo " * generate a tmp folder for a review with the tool compare in ecu-test"
    echo " * generate a text file with the path of the file in order to find them fastly"
    echo ""
    echo "Arguments:"
    echo "  arg1: Path of the repo"
    echo "  arg2: branch to compare with the actual repo"
    echo ""
    echo "Options:"
    echo "  -h: Display this help message"
}

# Please note, ECU-test has a bug and the cli does not work on version 2023.1
run_ecu_diff_on_files() {
    for file in $1
    do 
        $(ecu_test_path --diff $folder_file_name/$(basename $file) $file)
    done
}

# Main function
git_ecu_test_branch_diff() {
    # Check if the -h option is passed
    if [[ "$1" == "-h" ]]; then
        git_ecu_test_branch_diff_help
        exit 0
    fi

    echo "Hello,"
    echo "Please make sure your repo is clean and is on the main branch (and not the branch that you want to merge)"
    echo "**********"
    echo "You will review repo $1 on the branch $2"
    read -p "Do you want to contine: Y/n: " answer

    if [[ "$answer" == "Y" || "$answer" == "y" || "$answer" == "yes" ]]; then
        echo "cool"
    else
        echo "Exiting..."
        exit 0
    fi

    # Go to the path
    cd "$1"

    # Create tmp file
    folder_file_name=$(date "+tmp_%N")
    mkdir "$folder_file_name"

    # get the list of the file that changed
    file_changed_list=$(git --no-pager  diff --name-only "$2")

    # Change to the branch to copy
    git switch "$2"

    
    for file in $file_changed_list
    do
       # Create a file with files to review
       echo $file >> $folder_file_name/files_to_review.txt
       # Copy files for manual diff compare
       cp "$file" "$folder_file_name" -v
    done

    # Please note, ECU-test has a bug and the cli does not work on version 2023.1
    # run_ecu_diff_on_files "$file_changed_list"

    # Return to the previous branch
    git switch -
}

git_ecu_test_branch_diff "$1" "$2"
cd -
