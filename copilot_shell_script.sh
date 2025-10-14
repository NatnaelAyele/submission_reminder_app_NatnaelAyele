#!/bin/bash

#tell bash to not store 'submission_reminder_*' as a literal value when no matches are found
shopt -s nullglob

#create an array to store directories that start with submission_reminder_
dirs=(submission_reminder_*/)

#if no matching directory is found display error message and exit the program
if [ "${#dirs[@]}" -eq 0 ]; then
        echo "No environment detected!!!"
        echo "First, run create_environment.sh to create an environment"
        exit 1
#if more than one directories matched, prompt the user to choose one
#store the name of the directory in avariable called 'dir' and continue the program if a valid option is selected.
# If the user presses Enter without choosing an option or selects an invalid option it prints an error message and re-display the menu. 
elif [ "${#dirs[@]}" -gt 1 ]; then
        echo "Found ${#dirs[@]} environments. Choose one by entering a number: "
        select dir in "${dirs[@]}"; do
                if [ -n "$dir" ]; then
                        echo "you choose $dir"
                        break
                else
                        echo "enter a vslid option!!!"
                fi
        done
#if only one directory matches store the name in a variable called 'dir'
else
          dir="${dirs[0]}"
        echo "found environment is ${dirs[0]}"
fi

config_dir="${dir}config/config.env"

#prompt the user to enter the name of the assignment they want to track
read -p "Enter the name of the assignment you want track: " assignment
echo

#change the value of the variable 'ASSIGNMENT' inside config.env with the new assignment name accpeted form the user
sed -i "s/^ASSIGNMENT=.*/ASSIGNMENT=\"${assignment}\"/" "$config_dir"

#print success and exiting message
echo "Successfully changed the the assignment being tracked!!!"
echo "currently tracking ${assignment}"
echo "======================================="
echo


#ask the teacher and delete this feature if it is not neccessary

#change directory to the selected environment
cd $dir
#run the startup.sh script file
bash startup.sh
