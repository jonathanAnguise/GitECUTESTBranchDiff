#!/bin/bash -xv

# ECU-TEST path
ecu_test_path="/c/xxxxx/ecu.exe"

# Go to the path
cd "$1"

# Create tmp file
folder_file_name=$(date "+tmp_%N")
mkdir "$folder_file_name"

# Function to display help
git_ecu_test_branch_diff_help() {
    echo "Usage: my_function.sh [path] [branch to compare]"
    echo "Description: This function accepts four arguments and performs a specific task."
    echo ""
    echo "Arguments:"
    echo "  arg1: Path of the repo"
    echo "  arg2: branch to compare with the actual repo"
    echo "  arg3: Description of argument 3"
    echo ""
    echo "Options:"
    echo "  -h: Display this help message"
}

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
        display_help
        return
    fi

    # get the list of the file that changed
    file_changed_list=$(git --no-pager  diff --name-only "$2")

    # Create a file with files to review
    echo $file_changed_list > $folder_file_name/files_to_review.txt
    
    for file in $file_changed_list
    do
       cp "$file" "$folder_file_name"
       echo "$file_changed_list has been copied"
    done

    run_ecu_diff_on_files "$file_changed_list"
}

git_ecu_test_branch_diff "$1" "$2"
cd -
