mkdir sispop$1
cd sispop$1
ln -s ../sispopnet sispopnet$1
cp ../sispopnet.ini .
nano sispopnet.ini
cd ..
echo "killall -9 sispopnet$1" >> ../stop.sh
