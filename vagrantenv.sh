# A 'virtualenvwrapper-style' extensions to sandbox vagrant plugin installs.
#

# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #
# A GENERAL WARNING ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #
# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ #

# This file is not 'safe'. It runs arbitrary scripts on your system.
# Please do your best to review the commands below before running.
# Also, make sure to check out the README.md as it has some instructions
# regarding some initial setup.

# Copyright 2015 Aubrey Taylor
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# see: http://github.com/aubricus/vagrantenv for documentation and notes.

# utility function to kill output

__vagrantenv_silent() {
    # see ..http://stackoverflow.com/a/17812463
    "$@" &>/dev/null
}

vagrantd_base_name='base_vagrant.d'

vagrantenv_setup() {
    echo "Running initial vagrantenv setup..."

    __vagrantenv_silent rm -rf $HOME/.vagrant.d
    __vagrantenv_silent vagrant plugin list
    __vagrantenv_silent mkdir -p $VAGRANTENV_HOME/base_vagrant.d
    __vagrantenv_silent cp -a $HOME/.vagrant.d/* $VAGRANTENV_HOME/$vagrantd_base_name/
    __vagrantenv_silent rm -rf $HOME/.vagrant.d

    workon_vagrantenv default

    echo "...finished!"
}

# mkvagrantenv
# make vagrantenv
# takes param $vagrant_env, e.g. 'mkvagrantenv my_env'
mkvagrantenv(){
    vagrant_env=$1

    echo "Creating vagrant env: $vagrant_env..."

    __vagrantenv_silent mkdir -p $VAGRANTENV_HOME/$vagrant_env
    __vagrantenv_silent cp -a $VAGRANTENV_HOME/$vagrantd_base_name/* $VAGRANTENV_HOME/$vagrant_env

    workon_vagrantenv $vagrant_env
}

# workon_vagrantenv
# activate vagrantenv
# takes param $env_name, e.g. 'workon_vagrantenv my_env'
workon_vagrantenv(){
    vagrant_env=$1

    echo "Attaching $vagrant_env vagrantenv..."

    rm -rf $HOME/.vagrant.d
    ln -s $VAGRANTENV_HOME/$vagrant_env $HOME/.vagrant.d

    echo "...finished!"
}

# rmvagrantenv
# remove vagrantenv
# takes param $env_name, e.g. 'rmnvagrantenv my_env'
rmvagrantenv(){
    vagrant_env=$1

    echo "Removing $vagrant_env vagrantenv..."

    rm -rf $VAGRANTENV_HOME/$vagrant_env

    workon_vagrantenv default
}

# cdvagrantenv
# change dir to vagrant environment root
# takes param $env_name, e.g. 'cdvagrantenv my_env'
cdvagrantenv(){
    vagrant_env=$1
    cd $VAGRANTENV_HOME/$vagrant_env
}

# lsvagrantenv
# list vagrant envs
# lists home dir contents, probably not the best ever but works (mostly)
lsvagrantenv(){
    ls $VAGRANTENV_HOME
}

# get the currently attached vagrantenv
currentvagrantenv() {
    echo "Current vagrantenv: $(basename $(readlink $HOME/.vagrant.d))"
}