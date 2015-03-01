#!/usr/local/bin/bash
sudo pkg install -y python python2 py27-setuptools >/dev/null
sudo easy_install-2.7 pip >/dev/null
echo "python2 installed:"
python2 -V
pip2 -V