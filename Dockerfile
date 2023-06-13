FROM ubuntu:22.04

WORKDIR /home
RUN apt-get install -y libc6-amd64-cross
RUN ln -s /usr/x86_64-linux-gnu/lib64/ /lib64
ENV LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/lib64:/usr/x86_64-linux-gnu/lib"
RUN apt-get -y update && apt-get install -y python3 python3-pip python-is-python3
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt
