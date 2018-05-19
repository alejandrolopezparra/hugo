#!/bin/bash

echo -e "\033[0;32mDeploying updates to GitHub...\033[0m"

# Build the project.
hugo # if using a theme, replace with `hugo -t <YOURTHEME>`


##### HUGO

# Add changes to git.
git add --all

# Commit changes.
msg="rebuilding site `date`"
if [ $# -eq 1 ]
  then msg="$1"
fi
git commit -m "$msg"


##### WEB

# Go To Public folder
cd public
# Add changes to git.
git add --all

# Commit changes.
msg="rebuilding site `date`"
if [ $# -eq 1 ]
  then msg="$1"
fi
git commit -m "$msg"



# Come Back up to the Project Root
cd ..

# Push source and build repos.
git push origin master

