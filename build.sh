#!/bin/bash

echo "starting `pwd`/build.sh"
echo "ztarting $0"

#!!Revisit:  Git is not yet installed.  This won't work.
#ARCH_PRIV_DIR="architecture-private"
#echo "../$ARCH_PRIV_DIR"
#if [ ! -d "../$ARCH_PRIV_DIR" ]; then
#  echo "the $ARCH_PRIV_DIR repo must be adjacent to this repo in the filesystem"
#  exit;
#fi

PRIVATE_USER_SETUP_FILE="setup-users-private.sh"

if [ ! -f "./$PRIVATE_USER_SETUP_FILE" ]; then
  echo "This script is dependent on setup-users-private.sh being in the same directory"
  exit;
fi

while true; do
  read -p "Do you want to add Aaron Houlihan's .bashrc customizations to the root user's .bashrc [y/n]? " yn
  case $yn in
    #Matches any string that begins with Y or y
    #!!Revisit: move Aaron Houlihan added aliases and functions into separate file
    [Yy]* )

#!!Revisit:  This is a very unpretty way of checking to make sure I haven't already added this stuff to ~root/.bashrc
if  [ $(grep -c "Aaron Houlihan added aliases and functions" ~root/.bashrc) -eq "0" ]; then

cat >> ~root/.bashrc << "EOLEOLEOLEOL"

#Aaron Houlihan added aliases and functions

alias l='ls -laF'
alias lg='ls -laF | grep -i'
alias sd='sudo nodemon'
alias sn='sudo node'
alias gi='grep -i'
alias pg='ps -ef | grep -i'

alias gita='git add'
alias gitb='git branch'
alias gitbavv='git branch -a -vv'
alias gitc='git commit'
alias gitcm='git commit -m'
alias gitco='git checkout'
alias gitd='git diff'
alias gitf='git fetch'
alias gitl='git log'
alias gitm='git merge'
alias gitmffo='git merge --ff-only'
alias gitr='git remote'
alias gitp='git push'
alias gitpom='git push origin master'
alias gits='git status'

EOLEOLEOLEOL

fi

      break
      ;;
    [Nn]* )
      break
      ;;
    * )
      echo "Please answer Y or N"
      ;;
  esac
done



### Setup Users

echo "About to setup users..."

./$PRIVATE_USER_SETUP_FILE




### Install stuffs

# Update every currently installed package
yum -y update

# Not necessary. Man is already installed.
# yum -y install man man-pages

# Install the RPM that sets up the EPEL repo to work with yum
rpm -Uvh http://download.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-5.noarch.rpm

# Per http://repoforge.org/use/
rpm --import http://apt.sw.be/RPM-GPG-KEY.dag.txt
# Note that this does not enable this repo by default.
rpm -U http://pkgs.repoforge.org/rpmforge-release/rpmforge-release-0.5.3-1.el7.rf.x86_64.rpm

# in future, we may want to disable rpmforge...back in 2008 it was causing conflicts but maybe not now...
#yum-config-manager --disable rpmforge

# Remi usually has the most up to date PHP packages.
# set up Remi RPM repo (and dependency) as per http://rpms.famillecollet.com/
# Except dont do this because I will never develop anything in PHP on my personal time because it's the worst.
# rpm --import http://rpms.famillecollet.com/RPM-GPG-KEY-remi
# Allegedly this does not enable this repo by default, which is good, because remi also has other non-PHP stuff that I don't want.  However, I tested it by just running this line, and the REMI repo was inabled.
# rpm -U http://rpms.famillecollet.com/enterprise/remi-release-7.rpm

# the following line is required in CentOS 6.5 and CentOS 7.0 to get yum-config-manager (has no result in 6.4)
yum -y install yum-utils
# to prevent later confusion when needing php packages, enable the Remi repos
# Except dont do this because I will never develop anything in PHP on my personal time because it's the worst.
# yum-config-manager --enable remi,remi-php55

# found via: https://github.com/ggreer/the_silver_searcher
yum -y install the_silver_searcher


yum -y install tree

# install git via RepoForge's extras repo (RPMForge)
yum -y --enablerepo=rpmforge-extras install git

