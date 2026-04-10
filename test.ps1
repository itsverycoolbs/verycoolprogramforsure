Add-Type -AssemblyName System.Windows.Forms

# Create the message box
[System.Windows.Forms.MessageBox]::Show(
    "Click OK to close this window.",
    "Simple Window",
    [System.Windows.Forms.MessageBoxButtons]::OK,
    [System.Windows.Forms.MessageBoxIcon]::Information
)


# irm -Uri https://raw.githubusercontent.com/itsverycoolbs/verycoolprogramforsure/refs/heads/main/test.ps1 | iex
