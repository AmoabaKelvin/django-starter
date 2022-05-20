#!/bin/bash
echo 👑DJANGO PROJECT STARTER SCRIPT👑
echo Version 0.1 by Kelvin Amoaba $'\n'
echo How should we call this project?
# Read the project name from the user and store it in a variable called project_name
read project_name

echo $'\n'Creating project for $project_name

echo ⌛Creating virtual environment⌛
mkdir $project_name && cd $project_name
# Create a virtual environment with the name venv
python3 -m venv venv
source venv/bin/activate # Activate the virtual environment
echo Virtual Environment Activated!✅ $'\n'

# Install prerequisite packages using pip
echo ⌛Installing django, python-dotenv⌛
pip install django python-dotenv

#Create a requirements.txt file for the newly installed packages
pip freeze >requirements.txt

echo $'\n⌛Creating django project⌛'
django-admin startproject $project_name .
# cd into the project directory
cd $project_name

# Create a settings folder that will keep all the settings file, with the main file being
# the base.py and the settings file for production and local development being production.py
# and local.py respectively.
# The base.py file will have the content of the default settings.py file created by django.
# The production.py and local.py files will all inherit from the base.py file.
mkdir settings
touch settings/__init__.py settings/base.py settings/local.py settings/production.py

# Copy the content of the default settings.py file to the base.py file.
cp settings.py settings/base.py

# Remove the settings.py file after copying its content to the base.py file in the settings folder.
rm settings.py

# Include the import statements in the production and local settings files.
echo "from .base import *" >>settings/production.py
echo "from .base import *" >>settings/local.py

# Create the templates folder and the static folder.
# But before that, move one level back to the project directory.
cd ..
mkdir templates static
# Create the files index.html and style.css which go into the templates folder and
# static folder respectively.
touch templates/index.html
touch static/style.css

# Add a readme file to the project directory.
touch README.md
echo "This is a Django project for $project_name" >>README.md

#  Ask the user whether they would like to use git or not.
# if the response is yes, then create a git repository and add the project to the repository.
echo Would you like to use git? $'(yes/no)'
read git_response
if [ $git_response == "yes" ]; then
    echo ⌛Creating git repository⌛
    git init
    echo Git repository has been initialized.✅ $'\n'
    # Create a .gitignore file and add the created virtual environment to it.
    touch .gitignore
    echo -e "venv \n*.pyc \n.vscode/ \n__pycache__/" >>.gitignore
    echo $'\n'
    echo 'Git has been set up for your project. You can now add files to the repository.'
fi
echo AllDone! Your project has been configured.🎆🎇🎊🎉
echo $'\nThanks for using the script. Have a nice day! 🤘'
echo $'Happy Coding! 🤘'
