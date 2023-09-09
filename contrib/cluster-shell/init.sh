#!/bin/sh
# copy a sispopnet binary into this cluster
cp ../../sispopnet .
# generate default config file
./sispopnet -g -r sispopnet.ini
# make seed node
./makenode.sh 1
# establish bootstrap
ln -s sispop1/self.signed bootstrap.signed
