#!/bin/bash
echo "Welocome!"
read -p "Enter your name, please: " name
parent_dir="submission_reminder_${name}"
mkdir -p $parent_dir/{app,modules,assets,config}

cat > $parent_dir/app/reminder.sh << 'DATA'
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

cat > $parent_dir/modules/functions.sh << 'DATA'
#!/bin/bash
#
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

cat > $parent_dir/assets/submissions.txt << 'DATA'
student, assignment, submission status
Chinemerem, Shell Navigation, not submitted
Chiagoziem, Git, submitted
Divine, Shell Navigation, not submitted
Anissa, Shell Basics, submitted
simeon, Git, submitted
Bonnita, Shell Navigation, not submitted
Jenifer, Shell Basics, submitted
Natnael, Git, submitted
Fidel, Shell Navigation, not submitted
DATA

cat > $parent_dir/config/config.env << 'DATA'
# This is the config file
ASSIGNMENT="Shell Navigation"
DAYS_REMAINING=2
DATA

cat > $parent_dir/startup.sh << 'DATA'
#!/bin/bash
bash ./app/reminder.sh
DATA

find "$parent_dir" -type f -name "*.sh" -exec chmod +x {} \;
echo "creating a directory based on your name...............hang on!!!!!"
echo "Directory created, environment created successfully"
echo "You can now go to the ${parent_dir} and run the startup.sh file to start the application"
