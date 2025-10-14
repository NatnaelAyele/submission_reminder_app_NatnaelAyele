#!/bin/bash
echo "Welcome!"

#prompt the user to enter name and capture the input
read -p "Enter your name, please: " name
parent_dir="submission_reminder_${name}"

#check if name entered is not empty
if [[ -z "$name" ]]; then
  echo "Error: Name cannot be empty. Please run the script again." >&2
  exit 1
fi
#create a main directory based on the name accepted from user and its following sub-directories
#if the directories were not able to be created display error message and exit the program
mkdir -p "$parent_dir"/{app,modules,assets,config} || { 
    echo "Error: Unable to create directories in '$parent_dir' run the program agin." >&2
    exit 1
}


# Create the reminder.sh file inside the 'app' directory
# append a script to reminder.sh that loads configuration files and helper functions, displays assignment details, and runs the submission reminder check

cat > "$parent_dir/app/reminder.sh" << 'DATA'
#!/bin/bash

# Source environment variables and helper functions
source ./config/config.env
source ./modules/functions.sh

# Path to the submissions file
submissions_file="./assets/submissions.txt"

# Print remaining time and run the reminder function
echo "Assignment: $ASSIGNMENT"
echo "Days remaining to submit: $DAYS_REMAINING days"
echo "--------------------------------------------"

check_submissions $submissions_file
DATA

#create the function.sh file inside 'modules' directory
#append a script to function.sh. The script defines a function that checks the submissions file and identifies students who have not submitted their assignments.
#the script is taken from the resources provided in the assignment submission page
cat > "$parent_dir/modules/functions.sh" << 'DATA'
#!/bin/bash

# Function to read submissions file and output students who have not submitted
function check_submissions {
    local submissions_file=$1
    echo "Checking submissions in $submissions_file"

    # Skip the header and iterate through the lines
    while IFS=, read -r student assignment status; do
        # Remove leading and trailing whitespace
        student=$(echo "$student" | xargs)
        assignment=$(echo "$assignment" | xargs)
        status=$(echo "$status" | xargs)

        # Check if assignment matches and status is 'not submitted'
        if [[ "$assignment" == "$ASSIGNMENT" && "$status" == "not submitted" ]]; then
            echo "Reminder: $student has not submitted the $ASSIGNMENT assignment!"
        fi
    done < <(tail -n +2 "$submissions_file") # Skip the header
}
DATA
#create the submissions.txt file inside 'assets' directory
#append a data of student's name the assignment they're working on and the submission status for each student into submissions.txt
#the data is taken from the resources provided in the assignment submission page

cat > "$parent_dir/assets/submissions.txt" << 'DATA'
student, assignment, submission status
Chinemerem, Shell Navigation, not submitted
Chiagoziem, Git, submitted
Divine, Shell Navigation, not submitted
Anissa, Shell Basics, not submitted
simeon, Git, not submitted
Bonnita, Shell Navigation, not submitted
Jenifer, Shell Basics, not submitted
Natnael, Git, not submitted
Fidel, Shell Navigation, not submitted
DATA

# Create the config.env file inside the 'config' directory 
# append a data to config.env. This data defines environment variables used by the reminder script.
cat > "$parent_dir/config/config.env" << 'DATA'
# This is the config file
ASSIGNMENT="Shell Navigation"
DAYS_REMAINING=2
DATA

# Create the startup.sh script inside the main directory
# append a script to startup.sh that runs the main reminder.sh script.
cat > "$parent_dir/startup.sh" << 'DATA'
#!/bin/bash
bash ./app/reminder.sh
DATA

#find all .sh files inside the main directory and give execute permission to all of them
find "$parent_dir" -type f -name "*.sh" -exec chmod +x {} \;

#print a completion and exiting messages
echo "Directory created, environment created successfully"
echo "You can now go to \"$parent_dir\" and run the startup.sh file to start the application."
