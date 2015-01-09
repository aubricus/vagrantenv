# Vagrantenv

A `virtualenv` "style" utility file that attempts to sandbox vagrant plugin installs.

## Bash Setup

Add these vars to your .bashrc / .bash_profile (whichever file initializes your terminal)

```bash
export VAGRANTENV_SCRIPT=/path/to/vagrantenv.sh
export VAGRANTENV_HOME=$HOME/.vagrantenv
source VAGRANTENV_SCRIPT
```

## Installation

>First, checkout this repository

```bash
cd ~/path/to/repos
git clone git@github.com:aubricus/vagrantenv.git
```

1. Update bash vars above to match location to `vagrantenv.sh`
2. run `chmod +x /path/to/vagrantenv.sh`
3. `source .bashrc` or restart your terminal session.

## Initial Setup

You'll need to setup a couple of things before this utility file will work:

> First, navigate to your home dir, usually: `cd ~/`

Read the comments, and follow the commands:

```bash
# create the .vagrantenv folder
mkdir .vagrantenv

# check for a .vagrant.d folder
ls -la | grep vagrant

# IF .vagrant.d EXISTS
mkdir .vagrantenv/default
cp -a .vagrant.d/* .vagrantenv/default
rm -rf .vagrant.d

# run the vagrantenv_init command
# setup forces vagrant to generate a default .vagrant.d
# and stores it in .vagrantenv/base_vagrant.d
vagrantenv_setup

# run your default vagrantenv
workon_vagrantenv default

```

## Commands

Checkout [vagrantenv.sh](vagrantenv.sh) for details.