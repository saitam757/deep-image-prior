FROM nvidia/cuda:11.8.0-cudnn8-devel-ubuntu22.04

ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y \
        build-essential \
        libgl1-mesa-glx \
        libglib2.0-0 \
        libxcb-util1 '^libxcb.*-dev' libx11-xcb-dev \
        libglu1-mesa-dev \
        libxrender-dev \
        libxi-dev \
        libxkbcommon-dev \ 
        libxkbcommon-x11-dev \
        wget \
        python3-dev \
        python3-pip \
        python3-setuptools \
        neovim \
        libx11-dev \
        x11-apps \
        qtbase5-dev \  
    && apt-get clean

RUN pip install --upgrade pip

ENV BUILD_DIR /build
WORKDIR ${BUILD_DIR}

COPY requirements.txt .
RUN pip install -r requirements.txt

# when attaching to running container via vs code and creating new files
# they have the have user rights and not root:w
RUN addgroup --gid 1000 devuser
RUN adduser --disabled-password --gecos "" --uid 1000 --gid 1000 devuser
ENV HOME /home/devuser

USER devuser


#FROM nvidia/cuda:9.0-cudnn7-devel

# Install system dependencies
#RUN apt-get update \
#    && DEBIAN_FRONTEND=noninteractive apt-get install -y \
#        build-essential \
#        curl \
#        git \
 #    && apt-get clean
 
# Install python miniconda3 + requirements
#ENV MINICONDA_HOME="/opt/miniconda"
#ENV PATH="${MINICONDA_HOME}/bin:${PATH}"
#RUN curl -o Miniconda3-latest-Linux-x86_64.sh https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh \
#    && chmod +x Miniconda3-latest-Linux-x86_64.sh \
#    && ./Miniconda3-latest-Linux-x86_64.sh -b -p "${MINICONDA_HOME}" \
#    && rm Miniconda3-latest-Linux-x86_64.sh
#COPY environment.yml environment.yml
#RUN conda env update -n=root --file=environment.yml
#RUN conda clean -y -i -l -p -t && \
#    rm environment.yml

# Clone deep image prior repository
#RUN git clone https://github.com/DmitryUlyanov/deep-image-prior.git
#WORKDIR /deep-image-prior

# Start container in notebook mode
#CMD jupyter notebook --ip="*" --no-browser --allow-root

