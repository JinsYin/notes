# docker build --build-arg EP_VERSION=0.0.5 -f Dockerfile -t dockerce/eth-proxy:0.0.5 .
# Usage1: docker run -it --rm -p 9090:9090 -v /opt/ethproxy/eth-proxy.conf:/opt/ethproxy/eth-proxy.conf dockerce/eth-proxy:0.0.5
# Usage2: docker run -it --rm -p 9090:9090 -e EP_WALLET='0x79e478b8825fc50d9fde647ccc97483b5174f66f' dockerce/eth-proxy:0.0.5
FROM python:2.7
LABEL maintainer="jinsyin@gmail.com"

ENV TZ=Asia/Shanghai
ARG EP_VERSION=0.0.5
ARG EP_REPO=https://github.com/Atrides/eth-proxy.git

# Install dependencies
RUN apt-get update \
    && apt-get install -y tzdata git \
    && pip install twisted

# Build eth-proxy
RUN git clone ${EP_REPO} /ethproxy \
    && cd /ethproxy \
    && git checkout tags/${EP_VERSION}

COPY chgconf.sh /chgconf.sh
RUN chmod +x /chgconf.sh

WORKDIR /ethproxy

# 传递 "EP_" 开头的环境变量可以改变配置文件
ENTRYPOINT ["/chgconf.sh"]
CMD ["python", "eth-proxy.py"]