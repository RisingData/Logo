#!/bin/bash
echo "linking bashrc"
rm /home/lbym/.bashrc
ln -s /usr/local/i3/hpstream_bashrc .bashrc

echo "linking bash_login"
rm /home/lbym/.bash_login
ln -s /usr/local/i3/hpstream_bash_login .bash_login

echo "linking gnomerc"
rm /home/lbym/.gnomerc
ln -s /usr/local/i3/hpstream_gnomerc .gnomerc
