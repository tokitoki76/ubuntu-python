FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update
RUN apt-get install -y build-essential g++ gcc autotools-dev \
    libicu-dev libbz2-dev libboost-all-dev zlib1g zlib1g-dev \
    libssl-dev libncurses5-dev libgdbm-dev libnss3-dev \
    libreadline-dev libffi-dev wget curl git vim less unzip \
    mecab libmecab-dev mecab-ipadic-utf8
RUN apt-get install -y nginx
RUN apt-get install -y procps
RUN apt-get -y install locales && \
    localedef -f UTF-8 -i ja_JP ja_JP.UTF-8
RUN apt-get clean && rm -rf /var/lib/apt/lists/*
    
ENV LANG ja_JP.UTF-8
ENV LANGUAGE ja_JP:ja
ENV LC_ALL ja_JP.UTF-8
ENV TZ JST-9
ENV TERM xterm

RUN useradd -r nginx

WORKDIR /app

RUN wget https://www.python.org/ftp/python/3.9.18/Python-3.9.18.tgz \
    && tar -xf Python-3.9.18.tgz

RUN cd Python-3.9.18 \
    && ./configure --enable-optimizations \
    && make -j $(nproc) \
    && make altinstall

RUN update-alternatives --install /usr/bin/python python3 /usr/local/bin/python3.9 1 \
    && update-alternatives --install /usr/bin/pip pip /usr/local/bin/pip3.9 1

RUN python -m ensurepip \
    && python -m pip install --upgrade pip

RUN rm Python-3.9.18.tgz
RUN rm -rf Python-3.9.18

COPY app/ /app/

RUN pip install -U pip
RUN pip install -U setuptools wheel
RUN pip install --no-cache-dir -r requirements.txt

COPY nginx.conf /etc/nginx/nginx.conf

COPY start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 5001

CMD ["/start.sh"]
