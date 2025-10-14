#!/bin/bash
dirs=(submission_reminder_*/)

shopt -s nullglob
dirs=(submission_reminder_*/)

if [ "${#dirs[@]}" -eq 0 ]; then
        echo "No environment detected!!!"
        echo "First, run create_environment.sh to create an environment"
        exit 1
elif [ "${#dirs[@]}" -gt 1 ]; then
        echo "Found ${#dirs[@]} environments. Choose one by entering a number: "
        select dir in "${dirs[@]}"; do
                if [ -n "dir" ]; then
                        echo "you choose $dir"
                        break
                else
                        echo "enter a vslid option!!!"
                fi
        done
else
          dir="${dirs[0]}"
        echo "found environment is ${dirs[0]}"
fi

config_dir="${dir}config/config.env"
read -p "Enter the name of the assignment to be tracked: " assignment
echo
sed -i "s/^ASSIGNMENT=.*/ASSIGNMENT=\"${assignment}\"/" "$config_dir"
echo "Successfully changed the the assignment being tracked!!!"
echo "currently tracking ${assignment}"
echo "======================================="
echo

# ask the teacher and delete this feature if it is not neccessary
cd $dir
bash startup.sh
