# pysispopnet

sispopnet with python 3

    # python3 setup.py install

## bootserv

bootserv is a bootstrap server for accepting and serving RCs

    $ gunicorn -b 0.0.0.0:8000 pysispopnet.bootserv:app

## pysispopnet instance

obtain `libsispopnet-shared.so` from a sispopnet build

run (root):
    
    # export SISPOPNET_ROOT=/tmp/sispopnet-instance/
    # export SISPOPNET_LIB=/path/to/libsispopnet-shared.so
    # export SISPOPNET_BOOTSTRAP_URL=http://bootserv.ip.address.here:8000/bootstrap.signed
    # export SISPOPNET_PING_URL=http://bootserv.ip.address.here:8000/ping
    # export SISPOPNET_SUBMIT_URL=http://bootserv.ip.address.here:8000/
    # export SISPOPNET_IP=public.ip.goes.here
    # export SISPOPNET_PORT=1090
    # export SISPOPNET_IFNAME=eth0
    # python3 -m pysispopnet