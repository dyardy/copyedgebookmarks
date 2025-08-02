# Copy Chrome Bookmarks to Edge

A PowerShell script that copies bookmarks from Google Chrome to Microsoft Edge while preserving the exact structure and order.

## Features

- Automatically stops Microsoft Edge before copying
- Creates a backup of existing Edge bookmarks
- Copies Chrome bookmarks to Edge profile
- Verifies the copy operation with file hash comparison
- Preserves bookmark folder structure and order

## Usage

1. Make sure both Chrome and Edge have been run at least once (to create profile folders)
2. Close Microsoft Edge if it's running
3. Run the PowerShell script:

```powershell
.\copybookmarks.ps1
```

## Requirements

- Windows with PowerShell
- Google Chrome installed with bookmarks
- Microsoft Edge installed

## How it works

1. Locates Chrome and Edge profile folders in `%LocalAppData%`
2. Stops any running Edge processes
3. Backs up existing Edge bookmarks (if any) to `.bak` file
4. Copies Chrome's `Bookmarks` file to Edge's profile folder
5. Verifies the copy operation was successful

## Notes

- The script preserves the exact JSON structure and order from Chrome
- Edge will need to be restarted to see the imported bookmarks
- Original Chrome bookmarks remain unchanged
