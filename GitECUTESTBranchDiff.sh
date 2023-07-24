#!/bin/bash

# ECU-TEST path
ecu_test_path="/c/xxxxx/ecu.exe"

# Function to display help
git_ecu_test_branch_diff_help() {
    cat << EOF
Usage: GitECUTESTBranchDiff.sh [path] [branch to compare]

Description:
  Copy files modified between the current folder and a specified branch.
  - Generates a temporary folder for review using the compare tool in ECU-TEST.
  - Generates a text file with the paths of the modified files for easy reference.

Arguments:
  arg1: Path of the Git repository
  arg2: Branch to compare with the current branch

Options:
  -h: Display this help message
EOF
}

# Function to open files for comparison in ECU-TEST
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
    echo "You will review repository $1 on the branch $2"
    read -p "Do you want to contine (Y/n)? " answer

    if [[ "$answer" == "Y" || "$answer" == "y" || "$answer" == "yes" ]]; then
        echo "Continuing..."
    else
        echo "Exiting..."
        exit 0
    fi

    # Go to the repository path
    cd "$1" || exit

    # Create a temporary directory for review
    folder_file_name=$(date "+tmp_%N")
    mkdir "$folder_file_name"

    # get the list of files that changed
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

    # Run ECU-TEST compare (Note: ECU-TEST CLI may not work in version 2023.1)
    # run_ecu_diff_on_files "$file_changed_list"

    # Return to the previous branch
    git switch -
}

# Call the main function with arguments
git_ecu_test_branch_diff "$1" "$2"
cd -
