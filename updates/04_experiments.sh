#!/bin/bash
extractExperiment()
{
	echo "Extracting Experiment $1 Source"
	dir=/home/lbym/+$1
	touch $dir
	chmod 777 $dir
	rm -rf $dir
	mkdir $dir
	chmod 777 $dir
	if [ -z $2 ]
	then
		tar xpf /usr/local/i3/experiments/$1.tar --directory $dir/
	else
		tar xpf /usr/local/i3/experiments/$2.tar --directory $dir/
	fi
}

extractExperiment example_BasicBoard BasicBoard
extractExperiment start_BasicBoard StartBasicBoard
extractExperiment heat-diffusion
extractExperiment heat-sim
extractExperiment heatwire
extractExperiment start_TurtleLogo TurtleLogo
extractExperiment start_r-sqrd r-sqrd
extractExperiment MFC
extractExperiment RD3024
extractExperiment petri

