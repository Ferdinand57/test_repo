@echo off

:: Script to automatically git add ., commit with a default message, and push

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

:: Check if remote origin already exists
git remote -v | find "origin" >nul
if %errorlevel%==0 (
    echo "Remote already exists"
) else (
    git remote add origin https://github.com/Ferdinand57/test_repo.git
    echo "Remote added"
)

:: Push to the main branch
git push -u origin main