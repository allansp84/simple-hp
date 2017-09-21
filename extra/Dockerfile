FROM nvidia/cuda:8.0-cudnn6-devel-ubuntu14.04
MAINTAINER Allan Pinto <allansp84@gmail.com>

ENV DISPLAY="localhost:0" MPLBACKEND="agg" CUDA_ROOT=/usr/local/cuda/bin

# -- step 1: install dependences
RUN \
    apt-get update && \
    apt-get install -y \
        build-essential \
        gfortran \
        git \
        wget \
        liblapack-dev \
        libopenblas-dev \
        libxmu-dev \
        libxi-dev \
        libzmq-dev \
        freeglut3-dev libgl1-mesa-glx libgl1-mesa-dri libglapi-mesa libglu1-mesa libglu1-mesa-dev \
        libjpeg-dev python-dev python-pip python-tk libffi-dev libsodium-dev libssl-dev && \
    apt-get autoclean && apt-get clean && \
    pip install -U pip && \
    ln -s /usr/local/nvidia/lib64/libcuda.so.1 /usr/lib/x86_64-linux-gnu/libcuda.so && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* ~/.cache

# -- step 2: install mongodb
RUN \
    mkdir -p /root/dev/downloads && \
    cd /root/dev/downloads && \
    wget http://fastdl.mongodb.org/linux/mongodb-linux-x86_64-2.2.7.tgz && \
    tar -zxvf mongodb-linux-x86_64-2.2.7.tgz  && \
    cp -R -n mongodb-linux-x86_64-2.2.7/ /root/dev/mongodb-2.2.7  && \
    echo export PATH='$'PATH:/root/dev/mongodb-2.2.7/bin >> /etc/profile && \
    cd /root && \
    rm -rf /root/dev/downloads

# # -- step 3: install libgpuarray
# RUN \
#     pip install cython==0.25 && \
#     cd /root/dev && \
#     git clone https://github.com/Theano/libgpuarray.git && \
#     mkdir -p /root/dev/libgpuarray/release && \
#     cd /root/dev/libgpuarray/release && \
#     cmake .. -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/usr && \
#     make -j"$(nproc)" && make install && \
#     cd /root/dev/libgpuarray && \
#     python setup.py build_ext -L /usr/lib -I /usr/include && \
#     python setup.py install

# Install git, wget, python-dev, pip, BLAS + LAPACK and other dependencies
RUN apt-get update && apt-get install -y \
  gfortran \
  git \
  wget \
  liblapack-dev \
  libopenblas-dev \
  python-dev \
  python-pip \
  python-nose \
  python-numpy \
  python-scipy

RUN cd /root && wget http://www.cmake.org/files/v3.8/cmake-3.8.1.tar.gz && \
  tar -xf cmake-3.8.1.tar.gz && cd cmake-3.8.1 && \
  ./configure && \
  make -j "$(nproc)" && \
  make install

RUN pip install Cython=0.25

RUN \
    cd /root && git clone https://github.com/Theano/libgpuarray.git && cd libgpuarray && \
    mkdir Build && cd Build && \
    cmake .. -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/usr && \
    make -j"$(nproc)" && make install

RUN cd /root/libgpuarray && \
  python setup.py build_ext -L /usr/lib -I /usr/include && \
  python setup.py install

# -- step 4: install python dependences
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
    pip install numpy==1.10 && \
    pip install scipy==0.15.1 && \
    pip install matplotlib==1.5.3 && \
    pip install scikit-image==0.11.2 && \
    pip install scikit-learn==0.16.1 && \
    pip install pbr==1.8.0 && \
    pip install theano==0.6.0 && \
    pip install cffi==1.7 && \
    pip install cryptography==2.0.3 && \
    echo "[blas]\nldflags=-lopenblas\n" > /root/.theanorc && \
    echo "[cuda]\nroot=/usr/local/cuda\n" >> /root/.theanorc && \
    echo "[global]\nfloatX=float32\ndevice=cuda\n" >> /root/.theanorc && \
    echo "[lib]\ncnmem=0.1\n[nvcc]\nfastmath=True" >> /root/.theanorc && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* ~/.cache

# -- step 5: install hyperopt package
RUN \
    mkdir -p $HOME/dev/hp-pkgs && \
    cd $HOME/dev/hp-pkgs && \
    git clone https://github.com/hyperopt/hyperopt.git && \
    (cd hyperopt && python setup.py develop) && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* ~/.cache

# -- step 5: install pyautodiff package
RUN \
    cd $HOME/dev/hp-pkgs && \
    git clone https://github.com/jaberg/pyautodiff.git && \
    (cd pyautodiff && python setup.py develop) && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* ~/.cache

# -- step 6: install hyperopt-convnet package
RUN \
    cd $HOME/dev/hp-pkgs && \
    git clone https://github.com/allansp84/hyperopt-convnet.git && \
    (cd hyperopt-convnet && python setup.py develop) && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* ~/.cache

# -- step 7: install simple-hp package
RUN \
    cd $HOME/dev && \
    git clone https://github.com/allansp84/simple-hp.git && \
    (cd simple-hp && python setup.py develop)

WORKDIR /root
