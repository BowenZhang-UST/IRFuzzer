FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# RUN echo "">/etc/sources.list
# RUN echo "deb http://mirrors.aliyun.com/ubuntu/ jammy main restricted universe multiverse">>/etc/apt/sources.list
# RUN echo "deb http://mirrors.aliyun.com/ubuntu/ jammy-security main restricted universe multiverse">>/etc/apt/sources.list
# RUN echo "deb http://mirrors.aliyun.com/ubuntu/ jammy-updates main restricted universe multiverse">>/etc/apt/sources.list
# RUN echo "deb http://mirrors.aliyun.com/ubuntu/ jammy-backports main restricted universe multiverse">>/etc/apt/sources.list

RUN apt-get clean

RUN apt-get update 
RUN apt-get -y upgrade
RUN apt-get install -y -q git build-essential wget zlib1g-dev cmake python3 python3-pip ninja-build ccache --fix-missing 
RUN apt-get clean

ENV FUZZING_HOME=/IRFuzzer
RUN git clone https://github.com/SecurityLab-UCD/IRFuzzer.git $FUZZING_HOME -b irfuzzer-0.4
WORKDIR $FUZZING_HOME

ENV LLVM=llvm-project
ENV AFL=AFLplusplus
ENV PATH="${FUZZING_HOME}/clang/bin:${PATH}"
ENV AFL_LLVM_INSTRUMENT=CLASSIC

RUN ./init.sh

# Don't build debug in docker image.
ENV NO_DEBUG_BUILD=1
RUN ./build.sh
