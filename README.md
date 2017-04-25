# GPR-O
Octave/Matlab programs for processing and plotting 2D and 3D Ground Penetrating Radar data
Octave is freely available from https://www.gnu.org/software/octave/

Check out the documentation [GPR-O](https://github.com/NSGeophysics/GPR-O/blob/master/doc/GPR-O.pdf)

## Installation instructions

### Downloading GPR-O
The easiest way of installing the software is via git. You can obtain git from
https://git-scm.com/download/win

Once git is installed installed, open a Command Prompt window, switch to the folder in which you would like to install GPR-O, and run

`git clone https://github.com/NSGeophysics/GPR-O.git`

This will download all the scripts and subfolders and will allow you to easily update the software at a later point

Alternatively, you can just download a zipped version by clicking on "Clone or download" and then "Download ZIP". Once you unzipped the file on your computer, the folder will be named "GPR-O-master". I recommend renaming it to "GPR-O".

### Installing GPR-O
After cloning or unzipping the software package, change directory into its main folder

`cd GPR-O`

and open Matlab or Octave.

In Matlab or Octave, run the setup script

`setup`

This will set up the folder structure and download some additional data files.


## Running under Matlab
After starting Matlab, switch into the GPR-O folder and run in Matlab

`initialize`

## Running under Octave
After starting Octave, switch into the GPR-O folder and run in Octave

`initialize_octave`

## Keeping GPR-O updated
If you used git to clone the software (instead of downloading a zipped folder), you can update GPR-O by running in a terminal or command prompt:

`git pull origin master`
