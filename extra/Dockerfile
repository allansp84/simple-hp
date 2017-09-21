FROM allansp84/ubuntu16.04-cuda8.0-opencv3.2
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
    pip install -U pip && \
    apt-get --purge autoremove && apt-get autoclean && apt-get clean && \
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

# -- step 4: install python dependences
RUN \
    pip --no-cache-dir install setuptools==0.6rc11 && \
    pip --no-cache-dir install distribute==0.6.38 && \
    pip --no-cache-dir install cython==0.25 && \
    pip --no-cache-dir install ipython==3.0.0 && \
    pip --no-cache-dir install argparse && \
    pip --no-cache-dir install SQLAlchemy && \
    pip --no-cache-dir install sphinx && \
    pip --no-cache-dir install nose && \
    pip --no-cache-dir install nose-parameterized && \
    pip --no-cache-dir install parameterized && \
    pip --no-cache-dir install Pillow==2.4.0 && \
    pip --no-cache-dir install pyzmq && \
    pip --no-cache-dir install bson==0.4.1 && \
    pip --no-cache-dir install pymongo && \
    pip --no-cache-dir install networkx && \
    pip --no-cache-dir install six && \
    pip --no-cache-dir install coverage && \
    pip --no-cache-dir install numpy==1.10 && \
    pip --no-cache-dir install scipy==0.15.1 && \
    pip --no-cache-dir install matplotlib==1.5.3 && \
    pip --no-cache-dir install scikit-image==0.11.2 && \
    pip --no-cache-dir install scikit-learn==0.16.1 && \
    pip --no-cache-dir install pbr==1.8.0 && \
    pip --no-cache-dir install cffi==1.7 && \
    pip --no-cache-dir install cryptography==2.0.3 && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* ~/.cache

# -- step 3: install libgpuarray
RUN \
    cd /root/dev && \
    git clone https://github.com/Theano/libgpuarray.git && \
    mkdir -p /root/dev/libgpuarray/release && \
    cd /root/dev/libgpuarray/release && \
    cmake .. -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/usr && \
    make -j"$(nproc)" && make install && \
    cd /root/dev/libgpuarray && \
    python setup.py build_ext -L /usr/lib -I /usr/include && \
    python setup.py install


# Install Theano and set up Theano config (.theanorc) for CUDA and OpenBLAS
RUN pip --no-cache-dir install theano==0.6 && \
    echo "[global]\ndevice=gpu\nfloatX=float32\noptimizer_including=cudnn\nmode=FAST_RUN \
        \n[lib]\ncnmem=0.95 \
        \n[nvcc]\nfastmath=True \
        \n[blas]\nldflag = -L/usr/lib/openblas-base -lopenblas \
        \n[DebugMode]\ncheck_finite=1" \
    > /root/.theanorc

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
