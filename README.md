Assignment Submission Reminder Project


This project contains two bash scripts that allow the user to create and manage an assignment submission reminder application. Of the two scripts, one is to set up the environment for the application, while the other is to manage the assignment tracking system.

How it works:
1. create_environment.sh

Upon running this script, you will be prompted to enter a name. Once you enter a name, an environment will be created based on your input. The naming format is “submission_reminder_<name>”.

The environment’s structure looks like this:
![Project Environment Structure](https://drive.google.com/uc?export=view&id=1ZcFmTyCwvnbTPdCrPd5DEY2xKxRCd8Ot)

From what we can see, the environment has four directories and a startup script file, which are needed to run the application. The application can be started by running the startup.sh script.

2. copilot_shell_script.sh

This script is used to manipulate the configuration of the environment. The config.env file dictates which assignment we are currently tracking.

Upon running:
    If no environment is found, you will be asked to create one first, and then the script exits.
    If multiple environments are found, it will ask you to choose one and then continue to ask for the assignment name you want to track.
    In the case of a single environment, it will skip directly to asking for the assignment name.

After that, the script changes the assignment value in the configuration file, and the application will start tracking the new assignment you entered. Finally, it automatically runs the startup script and starts the application.
