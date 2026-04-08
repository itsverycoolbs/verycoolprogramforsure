# 1. Define the directories where you want the files created
$targetPaths = @(
    "$env:USERPROFILE\Desktop",
    "$env:USERPROFILE\Documents",
    "$env:USERPROFILE\Downloads",
    "C:\"
)

# 2. Loop through each directory
foreach ($path in $targetPaths) {
    
    # Create the directory if it doesn't already exist
    if (!(Test-Path -Path $path)) {
        New-Item -ItemType Directory -Path $path | Out-Null
        Write-Host "Created directory: $path" -ForegroundColor Cyan
    }

    # 3. Create 37 empty .txt files in the current directory
    for ($i = 1; $i -le 250; $i++) {
        $fileName = "hacked$i.txt"
        $fullPath = Join-Path -ChildPath $fileName -Path $path
        
        # New-Item creates the file; -Force overwrites if it already exists
        New-Item -Path $fullPath -ItemType "file" -Force | Out-Null
    }

    Write-Host "Successfully created 37 files in: $path" -ForegroundColor Green
}
