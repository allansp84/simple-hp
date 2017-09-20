FROM nvidia/cuda:8.0-devel-ubuntu16.04
MAINTAINER Allan Pinto <allansp84@gmail.com>

ENV DISPLAY localhost:0
ENV MPLBACKEND "agg"

# RUN \
#     echo 'export DISPLAY=localhost:0' >> .bashrc && \
#     echo 'export MPLBACKEND="agg"' >> .bashrc

RUN \
    apt-get update && apt-get install -y  build-essential wget git libxmu-dev libxi-dev libzmq-dev \
    freeglut3-dev libgl1-mesa-glx libgl1-mesa-dri libglapi-mesa libglu1-mesa libglu1-mesa-dev \
    libjpeg-dev python-dev python-pip python-tk libffi-dev libsodium-dev libssl-dev

RUN \
    mkdir -p /root/local/downloads && \
    cd /root/local/downloads && \
    wget http://fastdl.mongodb.org/linux/mongodb-linux-x86_64-2.2.7.tgz && \
    tar -zxvf mongodb-linux-x86_64-2.2.7.tgz  && \
    cp -R -n mongodb-linux-x86_64-2.2.7/ /root/local/mongodb-2.2.7  && \
    echo export PATH='$'PATH:/root/local/mongodb-2.2.7/bin >> /etc/profile  && \

RUN \
    pip install setuptools==0.6rc11 && \
    pip install distribute==0.6.38 && \
    pip install ipython==3.0.0 && \
    pip install argparse && \
    pip install SQLAlchemy && \
    pip install sphinx && \
    pip install nose && \
    pip install nose-parameterized && \
    pip install parameterized && \
    pip install Pillow==2.4.0 && \
    pip install pyzmq && \
    pip install bson==0.4.1 && \
    pip install pymongo && \
    pip install networkx && \
    pip install six && \
    pip install coverage && \
    pip install cython==0.23 && \
    pip install numpy==1.10 && \
    pip install scipy==0.15.1 && \
    pip install matplotlib==1.5.3 && \
    pip install scikit-image==0.11.2 && \
    pip install scikit-learn==0.16.1 && \
    pip install theano==0.6.0

RUN echo "[cuda]
root=/usr/local/cuda

[global]
floatX=float32
device=cpu" > .theanorc

RUN python -c 'import theano as th; th.test()' && \
    echo "You shold have obtained 19 (known) failures. If that is the case, press [enter] and go ahead..."

RUN \
    mkdir -p $HOME/dev/hp-pkgs && \
    cd $HOME/dev/hp-pkgs && \
    git clone https://github.com/hyperopt/hyperopt.git && \
    (cd hyperopt && python setup.py develop) && \
    (cd hyperopt && nosetests) && \

RUN \
    git clone https://github.com/jaberg/pyautodiff.git && \
    (cd pyautodiff && python setup.py develop) && \
    (cd pyautodiff && nosetests)

RUN \
    rm -rf hyperopt-convnet && \
    git clone https://github.com/allansp84/hyperopt-convnet.git && \
    (cd hyperopt-convnet && python setup.py develop)
