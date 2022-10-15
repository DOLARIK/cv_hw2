#FROM ubuntu:16.04
FROM python:3.6

ENV JUPYTER_TOKEN dgupta12_psood_asg2

# Pick up some general dependencies
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        build-essential \
        tree \
        curl \
        libfreetype6-dev \
        libpng-dev \
        libzmq3-dev \
        pkg-config \
        rsync \
        software-properties-common \
        unzip \
        libgtk2.0-0 \
        git \
        tcl-dev \
        tk-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Python 3.6
#
# For convenience, alias (but don't sym-link) python & pip to python3 & pip3 as recommended in:
# http://askubuntu.com/questions/351318/changing-symlink-python-to-python3-causes-problems
#RUN apt-get install -y --no-install-recommends python3.6 python3.6-dev python3-pip python3-tk && \
#    pip3 install --no-cache-dir --upgrade pip setuptools && \
#    echo "alias python='python3'" >> /root/.bash_aliases && \
#    echo "alias pip='pip3'" >> /root/.bash_aliases

# Pillow and it's dependencies
RUN apt-get install -y --no-install-recommends libjpeg-dev zlib1g-dev && \
    pip3 --no-cache-dir install Pillow

# Science libraries and other common packages
RUN pip3 --no-cache-dir install \
    numpy matplotlib Cython

# Jupyter Lab
RUN pip install jupyter -U && pip install jupyterlab -U
EXPOSE 8888

# OpenCV 3.4.1    
RUN pip install opencv-python && \ 
    apt-get update && \
    apt-get install ffmpeg libsm6 libxext6  -y

RUN PROTOC_ZIP=protoc-3.15.8-linux-x86_64.zip && \
    curl -OL https://github.com/google/protobuf/releases/download/v3.15.8/$PROTOC_ZIP && \
    unzip -o $PROTOC_ZIP -d /usr/local bin/protoc && \
    unzip -o $PROTOC_ZIP -d /usr/local include/* && \
    rm -f $PROTOC_ZIP

WORKDIR /assignment_2

# Production
COPY ./ /assignment_2
RUN pip install -r requirements.txt

ENTRYPOINT ["jupyter", "lab","--ip=0.0.0.0","--allow-root"]