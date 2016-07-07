#!/bin/bash
pushd ~
sudo /usr/local/i3/Wifi.sh

ssh lbym@192.168.2.1 -p 25000 date >/tmp/tdate
/usr/local/i3/presetdate.sh
sudo /usr/local/i3/setdate.sh

# if [ $(hostname) = "lbym23"]
# then
#	/usr/local/i3/postinstall.sh
#; fi

ls /usr/local/i3/i3-version*

rm .bashrc
ln -s /usr/local/i3/hpstream_bashrc .bashrc

rm .bash_login
ln -s /usr/local/i3/hpstream_bash_login .bash_login

rm .gnomerc
ln -s /usr/local/i3/hpstream_gnomerc .gnomerc

#no longer needed
#rm -rf .ssh
#mkdir .ssh
#chmod 700 .ssh
#cd .ssh
#tar xpf /usr/local/i3/dotssh_hpstream.tar .
#cd ..

echo making directory example_BasicBoard
touch +example_BasicBoard
chmod 777 +example_BasicBoard
rm -rf +example_BasicBoard
mkdir +example_BasicBoard
chmod 777 +example_BasicBoard
cd +example_BasicBoard
tar xpf /usr/local/i3/experiments/BasicBoard.tar
cd ~/
chmod 444 +example_BasicBoard

echo making directory start_BasicBoard
touch +start_BasicBoard
chmod 777 +start_BasicBoard
rm -rf +start_BasicBoard
mkdir +start_BasicBoard
chmod 777 +start_BasicBoard
cd +start_BasicBoard
tar xpf /usr/local/i3/experiments/StartBasicBoard.tar
cd ~/
chmod 444 +start_BasicBoard

echo making directory heat-diffusion
touch +heat-diffusion
chmod 777 +heat-diffusion
rm -rf +heat-diffusion
mkdir +heat-diffusion
chmod 777 +heat-diffusion
cd +heat-diffusion
tar xpf /usr/local/i3/experiments/heat-diffusion.tar
cd ~/
chmod 444 +heat-diffusion

echo making directory heat-sim
touch +heat-sim
chmod 777 +heat-sim
rm -rf +heat-sim
mkdir +heat-sim
chmod 777 +heat-sim
cd +heat-sim
tar xpf /usr/local/i3/experiments/heat-sim.tar
cd ~/
chmod 444 +heat-sim

echo making directory heatwire
touch +heatwire
chmod 777 +heatwire
rm -rf +heatwire
mkdir +heatwire
chmod 777 +heatwire
cd +heatwire
tar xpf /usr/local/i3/experiments/heatwire.tar
cd ~/
chmod 444 +heatwire

echo making directory start_TurtleLogo
touch +start_TurtleLogo
chmod 777 +start_TurtleLogo
rm -rf +start_TurtleLogo
mkdir +start_TurtleLogo
chmod 777 +start_TurtleLogo
cd +start_TurtleLogo
tar xpf /usr/local/i3/experiments/TurtleLogo.tar
cd ~/
chmod 444 +start_TurtleLogo

echo making directory start_r-sqrd
touch +start_r-sqrd
chmod 777 +start_r-sqrd
rm -rf +start_r-sqrd
mkdir +start_r-sqrd
chmod 777 +start_r-sqrd
cd +start_r-sqrd
tar xpf /usr/local/i3/experiments/r-sqrd.tar
cd ~/
chmod 444 +start_r-sqrd


echo making directory MFC
touch +MFC
chmod 777 +MFC
rm -rf +MFC
mkdir +MFC
chmod 777 +MFC
cd +MFC
tar xpf /usr/local/i3/experiments/MFC.tar
cd ~/
chmod 444 +MFC

echo making directory RD3024
touch +RD3024
chmod 777 +RD3024
rm -rf +RD3024
mkdir +RD3024
chmod 777 +RD3024
cd +RD3024
tar xpf /usr/local/i3/experiments/RD3024.tar
cd ~/
chmod 444 +RD3024

echo making directory petri
touch +petri
chmod 777 +petri
rm -rf +petri
mkdir +petri
chmod 777 +petri
cd +petri
tar xpf /usr/local/i3/experiments/petri.tar
cd ~/
chmod 444 +petri

# `cd ~/
# `echo making directory Curriculum
# `rm -rf Curriculum
# `tar xpf /usr/local/i3/Curriculum.tar
# `cd ~/
# `chmod 777 Curriculum

#cd ~/
#echo making directory i3_training_2015_June
# delete i3_training_2015_June
rm -rf i3_training_2015_June
#tar xpf /usr/local/i3/i3_training_2015_June.tar

#cd ~/
#chmod 777 i3_training_2015_June
# copy Student folder to /home/lbym
#rm -rf /home/lbym/+Student
#cp -r /usr/local/i3/Student /home/lbym/+Student

# copy TowerGame to /home/lbymn
cp /usr/local/i3/tower/TowerGame /home/lbym

# delete any training folders with a leading "+"
rm -rf /home/lbym/i3_train*

# copy version file to home directory
rm -f /home/lbym/i3-version*
cp /usr/local/i3/*version* /home/lbym

DATE=`date +%Y-%m-%d:%H:%M:%S`
rm -f Update_*
touch /home/lbym/Update_$DATE

popd




