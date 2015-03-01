#!/usr/local/bin/bash
sudo pkg install -y python34 py34-setuptools34 >/dev/null
sudo easy_install-3.4 pip >/dev/null
echo "python3 installed:"
python3.4 -V
pip3 -V