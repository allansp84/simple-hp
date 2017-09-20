FROM allansp84/ubuntu16.04-cuda8.0-opencv3.2
MAINTAINER Allan Pinto <allansp84@gmail.com>

ENV DISPLAY="localhost:0" MPLBACKEND="agg"

# -- step 1:
RUN \
    apt-get update && \
    apt-get install -y \
        build-essential wget git libxmu-dev libxi-dev libzmq-dev \
        freeglut3-dev libgl1-mesa-glx libgl1-mesa-dri libglapi-mesa libglu1-mesa libglu1-mesa-dev \
        libjpeg-dev python-dev python-pip python-tk libffi-dev libsodium-dev libssl-dev && \
    apt-get autoclean && apt-get clean && \
    pip install -U pip && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* ~/.cache

# -- step 2:
RUN \
    mkdir -p $HOME/dev/downloads && \
    cd $HOME/dev/downloads && \
    wget http://fastdl.mongodb.org/linux/mongodb-linux-x86_64-2.2.7.tgz && \
    tar -zxvf mongodb-linux-x86_64-2.2.7.tgz  && \
    cp -R -n mongodb-linux-x86_64-2.2.7/ $HOME/dev/mongodb-2.2.7  && \
    echo export PATH='$'PATH:$HOME/dev/mongodb-2.2.7/bin >> /etc/profile && \
    cd /root && \
    rm -rf $HOME/dev/downloads

# -- step 3:
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
    pip install pbr==1.8.0 && \
    pip install theano==0.6.0 && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* ~/.cache && \
    echo "[cuda]\nroot=/usr/local/cuda\n" > .theanorc && \
    echo "[global]\nfloatX=float32\ndevice=cpu" >> .theanorc

# -- step 4:
RUN \
    mkdir -p $HOME/dev/hp-pkgs && \
    cd $HOME/dev/hp-pkgs && \
    git clone https://github.com/hyperopt/hyperopt.git && \
    (cd hyperopt && python setup.py develop) && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* ~/.cache

# -- step 5:
RUN \
    cd $HOME/dev/hp-pkgs && \
    git clone https://github.com/jaberg/pyautodiff.git && \
    (cd pyautodiff && python setup.py develop) && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* ~/.cache

# -- step 6:
RUN \
    cd $HOME/dev/hp-pkgs && \
    git clone https://github.com/allansp84/hyperopt-convnet.git && \
    (cd hyperopt-convnet && python setup.py develop) && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* ~/.cache

WORKDIR /root
