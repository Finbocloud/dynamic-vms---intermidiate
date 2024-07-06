# Show current branch and status
git pull
git branch
git status

# Show git status and print result
$gitStatus = git status --porcelain
echo $gitStatus

# Get list of untracked and modified files
$untrackedFiles = $gitStatus | Select-String '^\?\?'
$modifiedFiles = $gitStatus | Select-String '^ M'

# Prompt user for input on which files to add
$input = Read-Host "Enter 'A' to add all files, 'S' to add specific file, or 'G' to add a group of files"

switch ($input) {
    "A" {
        git add .
    }
    "S" {
        do {
            $file = Read-Host "Enter the name of the file to add"
            if (($untrackedFiles -match [regex]::Escape($file)) -or ($modifiedFiles -match [regex]::Escape($file))) {
                git add $file
                break
            } else {
                echo "File not found in untracked or modified files. Please try again."
            }
        } while ($true)
    }
    "G" {
        do {
            $allFilesValid = $true
            $files = Read-Host "Enter the names of the files to add, separated by spaces"
            
            foreach ($file in $files -split ' ') {
                if (($untrackedFiles -match [regex]::Escape($file)) -or ($modifiedFiles -match [regex]::Escape($file))) {
                    git add $file
                } else {
                    echo "File $file not found in untracked or modified files. Please try again."
                    $allFilesValid = $false
                    break
                }
            }

            if ($allFilesValid) {
                break
            }
        } while ($true)
    }
    default {
        echo "Invalid input"
    }
}

# Prompt user for commit message and push changes to repo.
$message = Read-Host "Enter commit message"
git commit -m $message
git push

echo "Push complete."
Start-Sleep -Seconds 100
Clear-Host