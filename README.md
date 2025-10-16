Assignment Submission reminder Project


This project contains two bash scripts that allows user to create and manage an assignment submission reminder application. Of the two scripts one is to set up the environment for the application while the second is to manage the assignment tracking system.

How it works:
1. create_environment.sh:
    Upon running this script you will be prompted to enter a name.
    once you entered a name, an environment will be created based on your name. the naming is "submission_reminder_'name'".
    the environment's structure looks like this:
        ![Screenshot](C:\Users\HP\OneDrive\Bilder\Screenshots\Screenshot%202025-10-16%20152027.png)
    from what we can see the environment has four directories and a startup script file which are needed to run the application. The application can be started by running the startup.sh script.

2. copilot_shell_script.sh:
    This script is used to mainubilate the configuration of the environment. The congi.env file dictates which assignment we are currenlty tracking.
    upon running if it found no environment you will be asked to create environment first and it exits. If it found multiple environment it will ask you to choose one and continues to ask you for the assignment name you want to track. Incase of a single environment it will directly skips to ask you the assignment name.
    change the assignment in from the configuration and now the the application will be tracking the new assignment you entered.
    automaticaly runs the startup script and start the application. 
