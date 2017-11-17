#!/usr/bin/env bash

# Any subsequent commands which fail will cause the shell script to exit immediately
set -e

# Get script path
script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# User imports
source "$script_dir/utilities.sh"


printInfo "=========================================================================================="
printInfo "=================================== Linux Setup Script ==================================="
printInfo "=========================================================================================="


# =============================================================================================== #
# ================================ WHAT UBUNTU VERSION ARE WE RUNNING? ========================== #
# =============================================================================================== #

UBUNTU_VERSION=`lsb_release -sd`
# This should return something along the lines of "Ubuntu 17.04"  

IFS=' ' read -r -a array <<< ${UBUNTU_VERSION}
DISTRO_NAME=${array[0]}
DISTRO_VERSION=${array[1]}

echo "DISTRO_NAME = ${DISTRO_NAME}"
echo "DISTRO_VERSION = ${DISTRO_VERSION}"

# Make sure the user is running this setup script on Ubuntu!
if ! [[ ${DISTRO_NAME} == "Ubuntu" ]]; then
	printError "ERROR: Distribution name was not Ubuntu."
	exit 1
fi

# =============================================================================================== #
# ========================================= INSTALL GIT ========================================= #
# =============================================================================================== #

if ! type "git" > /dev/null; then
	printInfo "Installing git..."
	sudo apt-get install -y git
else
	printInfo "git detected on system, not installing."
fi

# =============================================================================================== #
# ==================================== INSTALL SUBLIME TEXT 3 =================================== #
# =============================================================================================== #

# Not crucial, but a useful tool to have!
if ! type "subl" > /dev/null; then
	printInfo "Installing sublime text 3..."
	sudo add-apt-repository -y ppa:webupd8team/sublime-text-3
	sudo apt-get update
	sudo apt-get install -y sublime-text-installer
else
	printInfo "subl detected on system, not installing."
fi

# =============================================================================================== #
# ======================================== INSTALL VSCODE ======================================= #
# =============================================================================================== #

if ! type "code" > /dev/null; then
	printInfo "Installing VSCode (code)..."
	sudo add-apt-repository -y "deb https://packages.microsoft.com/repos/vscode stable main"
	sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys EB3E94ADBE1229CF
	sudo apt update
	sudo apt -y install code
else
	printInfo "VSCode (code) detected on system, not installing."
fi

# =============================================================================================== #
# ======================================== INSTALL CMAKE ======================================== #
# =============================================================================================== #

# CMake for performing C/C++ builds
if ! type "cmake" > /dev/null; then
	printInfo "Installing cmake..."
	sudo apt-get install -y cmake
else
	printInfo "cmake detected on system, not installing."
fi

# =============================================================================================== #
# ================================== INSTALL JAVA and JAVAFX ==================================== #
# =============================================================================================== #

if ! type "java" > /dev/null; then
	printInfo "Installing java and javafx..."
	sudo apt-get install -y openjdk-8-jdk openjfx
else
	printInfo "java detected on system, not installing."
fi

# =============================================================================================== #
# ================================== INSTALL PYTHON3 and PIP ==================================== #
# =============================================================================================== #

if ! type "python3" > /dev/null; then
	printInfo "Installing python3 and pip..."
	sudo apt-get install -y python3
else
	printInfo "python3 detected on system, not installing."
fi

if ! type "pip3" > /dev/null; then
	printInfo "Installing pip3..."
	sudo apt-get install -y python3-pip
else
	printInfo "pip3 detected on system, not installing."
fi

# =============================================================================================== #
# ======================================== .bashrc CONFIG ======================================= #
# =============================================================================================== #

# Add useful history seach to up/down arrow keys
echo "bind \"\\\"\e[A\\\": history-search-backward\"" >> ~/.bashrc
echo "bind \"\\\"\e[B\\\": history-search-forward\"" >> ~/.bashrc

# =============================================================================================== #
# ======================================= WORKSPACE CONFIG ====================================== #
# =============================================================================================== #

# Increase default workspace (1) to a 2x3 grid
gsettings set org.compiz.core:/org/compiz/profiles/unity/plugins/core/ hsize 2
gsettings set org.compiz.core:/org/compiz/profiles/unity/plugins/core/ vsize 3