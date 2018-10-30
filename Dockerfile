FROM ubuntu:16.04

RUN apt-get update && apt-get upgrade -y

RUN apt-get update && apt-get install -y htop mc vim git wget terminator

RUN apt-get update && apt-get install -y gcc g++ cmake openjdk-8-jdk libxft-dev libssl-dev libxext-dev libxml2-dev libreadline6 libquadmath0 libxslt1-dev libopenmpi-dev openmpi-bin libxss-dev libgsl0-dev libx11-dev gfortran libfreetype6-dev

RUN useradd -ms /bin/bash matmat
USER matmat
WORKDIR /home/matmat

RUN git clone https://github.com/fonadius/scipion.git /home/matmat/scipion && \
    cd /home/matmat/scipion/ && \
    git checkout newDefModel
    
RUN mkdir /home/matmat/.config/ && \
    mkdir /home/matmat/.config/scipion/

COPY ./scipion.conf /home/matmat/.config/scipion/scipion.conf

RUN cd /home/matmat/scipion && \
    ./scipion config && \
    ./scipion install -j 4 --no-opencv --no-scipy && \
    ./scipion install ctffind --no-opencv && \
    ./scipion install ctffind4 --no-opencv && \
    ./scipion install gctf --no-opencv && \
    ./scipion install unblur --no-opencv && \
    ./scipion install summovie --no-opencv && \
    ./scipion install motioncorr --no-opencv && \
    ./scipion install motioncor2 --no-opencv

CMD terminator
