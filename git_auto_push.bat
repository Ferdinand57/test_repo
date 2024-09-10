@echo off

:: Script to automatically git add ., commit with a default message, and push

:: Check if on 'master' branch and switch to 'main' if needed
git rev-parse --abbrev-ref HEAD | findstr "master" >nul
if %errorlevel%==0 (
    echo "You are on the master branch. Switching to main..."
    git checkout -b main
    git branch -D master
) else (
    echo "Already on the main branch or another branch"
)

:: Add all changes
git add .

:: Check if any changes are staged for commit, and only commit if there are changes
git diff --cached --exit-code >nul
if %errorlevel%==1 (
    git commit -m "Whermst"
) else (
    echo "No changes to commit"
    exit /b 0
)

:: Check if remote origin already exists, if it does, skip adding it
git remote -v | findstr "origin" >nul
if %errorlevel%==0 (
    echo "Remote 'origin' already exists"
) else (
    git remote add origin https://github.com/Ferdinand57/test_repo.git
    echo "Remote 'origin' added"
)

:: Push to the main branch
git push -u origin main
