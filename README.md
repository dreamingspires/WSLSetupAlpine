<img src="https://github.com/dreamingspires/WSLSetup/blob/master/misc/wsl_setup.svg?raw=True">

Quickly import the Dreaming Spires work environment into WSL, with a user and the appropriate packages.

# Part 1: Enable WSL in Windows 10

WSL has to be enabled in one of the following ways:
###### &nbsp;
### **Using the GUI for enabling Windows features**
1.	Open the Start Menu and search Turn Windows features on or off
2.	Select Windows Subsystem for Linux
3.	Click OK
4.	Restart your computer when prompted
###### &nbsp;
### **Using PowerShell**

Open PowerShell as Administrator and run:

1. Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux
2. Restart your computer when prompted
###### &nbsp;

This repo allows you to make your own WSL installer to the Dreaming Spires specification, with a user. 
### **If you wish to download a pre-built version of this package please [click here](https://github.com/dreamingspires/WSLSetup/releases/latest)**. 

Otherwise, read on.

# Part 2: Re-create the WSL installer (optional, skip if you downloaded the pre-built version)

## **Step 1:** Download the Fedora 33 file
[Download here](https://kojipkgs.fedoraproject.org//packages/Fedora-Container-Base/33)

Go to `"current-date".0/images/Fedora-Container-Base-33-"current-date".0.x86_64.tar.xz`

Or, if you're lazy, get an older file directly from [here](https://kojipkgs.fedoraproject.org//packages/Fedora-Container-Base/33/20201216.0/images/Fedora-Container-Base-33-20201216.0.x86_64.tar.xz).

Extract the file within this package (e.g. with WinRAR) called layer.tar, and rename it:

`fedora-33-rootfs.tar`

###### &nbsp;
## **Step 2:** Install fedora into WSL

### **Make a directory where you wish to put your WSL distribution**

e.g. in powershell

`mkdir $HOME\wsl\fedora` 
###### &nbsp;
### **Import into WSL**

Assuming all of the above steps are complete, you are ready to import your distribution.

Here I have used:

* Chosen name of distribution (this can be anything you like): `fedora`

* Destination directory: `$HOME\wsl\fedora`

* Unpacked fedora-33 file: `$HOME\Downloads\fedora-33-rootfs.tar`


In powershell:

`wsl --import fedora $HOME\wsl\fedora $HOME\Downloads\fedora-33-rootfs.tar`

To check this has worked:

`wsl -l`

which will list your available WSL distros.

If this is your first distro, this will automatically be default. Otherwise run:

`wsl -s fedora`

to set as default.

###### &nbsp;
## **Step 3:** Set up Fedora for Dreaming Spires

To enter your WSL, in powershell enter:

`wsl -d fedora`

Note: *Do* ***not*** *make a user here - we want this package to be a clean as possible*

### **Install necessary packages**

`dnf install -y nano git poetry python3-flit gcc python3-devel sqlite-devel python3-pytest npm`

### **Copy in** `startup.sh`
You will find in the `build_files` in this repo a file called `startup.sh`. Copy this file to:

`/home/startup.sh`

### **Clean Package Install Materials**
This will reduce the size of the final package *significantly*.

`dnf clean all`


To leave WSL enter:

`exit`

###### &nbsp;
## **Step 4:** Make your clean distro into a package

### **Export the distro to a .tar file**
In powershell:

`wsl --export fedora $HOME\Downloads\dreaming.tar`

### **Make the package**

Copy the file in `build_files` called `wslgen.bat`, and put this next to the .tar file.

Using 7-Zip, or otherwise, package both these files into one 7-Zip package, which should be significantly smaller than the unpackaged .tar .

# Part 3: Using the WSL Installer

## **Step 1:** Running the installer

Using 7-Zip, or otherwise, unpackage the installer. You should see two files inside, `dreaming.tar` and `wslgen.bat`. Run `wslgen.bat`

## **Step 2:** Using the installer
Note: While every effort has been made to account for the use of spaces in file paths, due to fact variables are passed between command line and bash this may cause errors. You may use the WSL installer if the file path to the distro in Windows already has a space in it (e.g. `Documents and Settings`), but please don't *create* folders with spaces in their names.

Please press enter after each step

### **Enter chosen distro name**
Choose a name for your new distro. This will be how Windows refers to it from now. **No spaces**.

### **Enter path to tar file**
Enter the path to the `dreaming.tar` file which came in the package. This might look something like:

`C:\Users\Mark\Downloads\dreaming_installer\dreaming.tar`

### **Enter path to distro**
This is the path where you wish your distro to go. It does not have to exist (No spaces in the new bit please!), but if it does exist, ensure the folder is empty. This might look something like:

`C:\Users\Mark\wsl\fedora`

Note: *The program will most likely hang for a moment after this command - this is normal.*

### **Enter Username**
Choose a username - please, no spaces - hyphens are acceptable.

### **Enter Password**
Choose a password, you will have to re-enter this in a moment. Bear in mind this will be your sudo password for your user, and will be frequently entered. Choose carefully.

### **Enter Github User Email and Username**
Enter the details associated with your github user account.

### **Place ssh key at github**
Copy the line provided in cmd (that starts `ssh-ed25519`)

Go to your ssh key settings in github: [Click here](https://github.com/settings/keys)

Click "New SSH Key".

Paste the line you copied in the key box.

Give it a memorable title - maybe the distro name you chose earlier.

Click "Add SSH Key"

### **Configure VS Code to boot into WSL**

Copy the line provided (that starts `"terminal.integrated.shell.windows"`)

Press enter (This should open your settings.json file - if not, see below)
* If your settings.json did not open, navigate to something like:
    `C:\Users\Mark\AppData\Roaming\Code\User\settings.json`,
    or it can be accessed through VS Code. In VS Code perform Ctrl+Shift+P to open the command line and do `>Open Settings (JSON)`.

Paste this line into your settings.json file - if one already labelled this exists replace it.

Now, in VS Code just do Terminal -> New Terminal. If all has gone well, and you didn't ***use any spaces*** you'll be in WSL at the location set by VS Code!
