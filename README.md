# GPR-O
Octave/Matlab programs for processing and plotting 2D and 3D Ground Penetrating Radar data

Check out the documentation [GPR-O](https://github.com/NSGeophysics/GPR-O/blob/master/doc/GPR-O.pdf)

##Installation instructions for Windows
To be able to install the software you will need to have the following two programs installed:

Git:
https://git-scm.com/download/win

wget:
https://sourceforge.net/projects/gnuwin32/files/wget/1.11.4-1/wget-1.11.4-1-setup.exe/

Once they are installed, open a Command Prompt window, switch to the folder in which you would like to install GPR-O, and run

`git clone https://github.com/NSGeophysics/GPR-O.git`

Once the repository is cloned, switch to it

`cd GPR-O`

and run the setup script

`setup_windows.bat`

This will set up the folder structure and download some additional data files.



##Installation instructions for Mac/Linux/Unix
To be able to install GPR-O you will need to have the following two programs installed:

**Git:**
https://git-scm.com/

**curl:**
For Mac: It should already be installed. If not, you can get it from package managers such as [MacPorts](https://www.macports.org/), [Homebrew](http://brew.sh/), etc.
For Linux: If it's not already installed you can use a package manager such as apt-get.

Once they are installed, open a Terminal window, switch to the folder in which you would 
like to install GPR-O software, and run

`git clone https://github.com/NSGeophysics/GPR-O.git`

Once the repository is cloned, switch to it

`cd GPR-O`

and run the setup script

`./setup.sh`

This will set up the folder structure and download some additional data files.

## Running under Matlab
After starting Matlab, switch into the GPR-O folder and run in Matlab

`initialize`

## Running under Octave
After starting Octave, switch into the GPR-O folder and run in Octave

`initialize_octave`
