# docker build --build-arg ETHMINER_VERSION=v0.12.0 -f Dockerfile -t cuda-ethminer:9.1-0.12.0 .
# nvidia-docker run -it --rm --net=host cuda-ethminer:9.1-0.12.0 ethminer -U -M
FROM nvidia/cuda:9.1-devel
LABEL maintainer="jinsyin@gmail.com"

ENV TZ=Asia/Shanghai
ARG ETHMINER_VERSION=v0.12.0
WORKDIR /opt

# Install dependencies
RUN apt-get update \
    && apt-get install -qy tzdata git cmake mesa-common-dev

# Build ethminer
RUN git clone https://github.com/ethereum-mining/ethminer.git /opt/ethminer \
    && cd ethminer \
    && git checkout tags/${ETHMINER_VERSION} \
    && mkdir /opt/ethminer/build \
    && cd /opt/ethminer/build \
    && cmake /opt/ethminer -DETHASHCUDA=ON -DETHASHCL=OFF -DETHSTRATUM=ON \
    && cmake --build /opt/ethminer/build \
    && cp /opt/ethminer/build/ethminer/ethminer /usr/local/bin/ \
    && rm -rf /opt/ethminer