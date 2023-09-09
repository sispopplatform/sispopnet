#!/bin/bash
set +x
cd sispop1
nohup ./sispopnet1 $PWD/sispopnet.ini &
# seed node needs some time to write RC to make sure it's not expired on load for the rest
sleep 1
cd ../sispop2
nohup ./sispopnet2 $PWD/sispopnet.ini &
cd ../sispop3
nohup ./sispopnet3 $PWD/sispopnet.ini &
cd ../sispop4
nohup ./sispopnet4 $PWD/sispopnet.ini &
cd ../sispop5
nohup ./sispopnet5 $PWD/sispopnet.ini &
cd ..
tail -f sispop*/nohup.out
