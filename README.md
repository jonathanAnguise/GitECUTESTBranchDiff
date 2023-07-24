# <p align="center">GitECUTESTBranchDiff</p>
  
GitECUTESTBranchDiff is a simple and efficient script designed to simplify the process of comparing two branches in ECU-TEST, an automotive software testing tool. This script helps identify modified files between the local branch and another branch, copies these files to a temporary folder, and allows you to open them directly in ECU-TEST's native compare tool.


## 🧐 Features    
Quickly identify files modified between the local branch and another branch
Automatically copy these files to a temporary folder for easy access
Easily open the copied files with the native ECU-TEST compare tool (Note: This feature may **not work with ECU-TEST 2023.1 version**, so I still **have not implemented** it)
        
## 🛠️ Installation
To use GitECUTESTBranchDiff, follow these simple steps:

1. Clone the GitECUTESTBranchDiff repository:

```bash
git clone https://github.com/jonathanAnguise/GitECUTESTBranchDiff.git
```

2. Make the script executable:

```bash
chmod +x GitECUTESTBranchDiff/GitECUTESTBranchDiff.sh
```

## 🧑💻 Usage
To compare branches in ECU-TEST, run the script with the following command:

```bash
./GitECUTESTBranchDiff.sh path branch_to_compare
```

Replace path with the desired path to store the temporary files, and branch_to_compare with the name of the branch you want to compare with the local branch.

        
## 🙇 Author
#### Jonathan Anguise
Feel free to explore, use, and contribute to the GitECUTESTBranchDiff project! If you encounter any issues or have suggestions for improvements, don't hesitate to open an issue or create a pull request.

Happy testing! 🚗🧪
- Github: [@jonathanAnguise](https://github.com/jonathanAnguise)
        
