#!/bin/bash

# pushd /home/lbym
# cd test_BasicBoard
# rm -f /usr/local/i3/experiments/StartBasicBoard.tar
# tar cpf /usr/local/i3/experiments/StartBasicBoard.tar .

pushd /home/lbym
cd example_BasicBoard
rm -f /usr/local/i3/experiments/BasicBoard.tar
tar cpf /usr/local/i3/experiments/BasicBoard.tar .

popd
