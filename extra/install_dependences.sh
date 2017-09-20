#!/bin/bash

export DISPLAY=localhost:0
export MPLBACKEND="agg"

apt-get update && apt-get install -y  build-essential freeglut3-dev libxmu-dev libxi-dev \
    libgl1-mesa-glx libgl1-mesa-dri libglapi-mesa libglu1-mesa libglu1-mesa-dev libzmq-dev \
    libjpeg-dev python-dev python-pip python-tk libffi-dev libsodium-dev libssl-dev

CUDA_PATH=/usr/local/cuda
INSTALLED_PACKAGES=/root/local
INSTALLED_PACKAGES_DOWNLOAD_FOLDER=$INSTALLED_PACKAGES/downloads
MONGODB_VERSION=2.2.7
MONGODB_INSTALLATION_FOLDER=$INSTALLED_PACKAGES/mongodb-$MONGODB_VERSION
MONGODB_PKG=mongodb-linux-x86_64-$MONGODB_VERSION
MONGODB_FILENAME=$MONGODB_PKG.tgz

mkdir -p $INSTALLED_PACKAGES_DOWNLOAD_FOLDER
cd $INSTALLED_PACKAGES_DOWNLOAD_FOLDER

wget http://fastdl.mongodb.org/linux/$MONGODB_FILENAME
tar -zxvf $MONGODB_FILENAME
cp -R -n $MONGODB_PKG/ $MONGODB_INSTALLATION_FOLDER
echo export PATH='$'PATH:$MONGODB_INSTALLATION_FOLDER/bin >> /etc/profile

CURRENT_DIR=$(pwd)
cd $HOME

# -- setuptools 0.7 is bugged, use 0.6 instead
pip install setuptools==0.6rc11
pip install distribute==0.6.38
#wget -O /tmp/setuptools-0.6c11-py2.7.egg https://pypi.python.org/packages/2.7/s/setuptools/setuptools-0.6c11-py2.7.egg
#sh /tmp/setuptools-0.6c11-py2.7.egg

pip install ipython==3.0.0
pip install argparse
pip install SQLAlchemy
pip install sphinx
pip install nose
pip install nose-parameterized
pip install parameterized

pip install Pillow==2.4.0
pip install pyzmq
pip install bson==0.4.1
pip install pymongo
pip install networkx
pip install six
pip install coverage

pip install cython==0.23
pip install numpy==1.10
pip install scipy==0.15.1
pip install matplotlib==1.5.3
pip install scikit-image==0.11.2
pip install scikit-learn==0.16.1

# -- install theano
pip install theano==0.6.0

# set .theanorc -- you change cpu by gpu if you have one
echo "[cuda]
root=$CUDA_PATH

[global]
floatX=float32
device=cpu" > .theanorc

# # -- run theano tests
# python -c 'import theano as th; th.test()'

echo "You shold have obtained 19 (known) failures. If that is the case, press [enter] and go ahead..."

# -- installing hyperopt
mkdir -p $HOME/dev/hp-pkgs
cd $HOME/dev/hp-pkgs

git clone https://github.com/hyperopt/hyperopt.git
(cd hyperopt && python setup.py develop)
(cd hyperopt && nosetests)

echo "Make sure hyperopt tests are OK at this point. If so, press [enter] and go ahead..."

# -- installing pyautodiff from James' repo
git clone https://github.com/jaberg/pyautodiff.git
(cd pyautodiff && python setup.py develop)
(cd pyautodiff && nosetests)

# -- installing hyperopt-convnet
rm -rf hyperopt-convnet
git clone https://github.com/allansp84/hyperopt-convnet.git
(cd hyperopt-convnet && python setup.py develop)

cd $CURRENT_DIR
