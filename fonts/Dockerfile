FROM python:3.6

ENV LANGUAGE='C.UTF-8' \
    LC_ALL='C.UTF-8' \
    LANG='C.UTF-8' \
    PYTHON='python3'

RUN apt-get update && apt-get upgrade -y \
    && apt-get install -y software-properties-common \
    && apt-get update \
    && apt-get install -y git autotools-dev libjpeg-dev libtiff5-dev libpng-dev libgif-dev \
        libxt-dev libfreetype6-dev autoconf automake libtool libltdl7-dev libxml2-dev libuninameslist-dev \
        libspiro-dev python-dev libpango1.0-dev libcairo2-dev unifont gettext

WORKDIR /home/app
RUN wget -qO - https://github.com/fontforge/fontforge/tarball/20190413 | tar xz
WORKDIR /home/app/fontforge-fontforge-b3f2758
RUN ./bootstrap && PYTHON=python3 ./configure --enable-pyextension --enable-python-scripting=3 && make && make install && ldconfig

WORKDIR /home/app
COPY ./requirements.txt /requirements.txt 

RUN pip3 install -U pip
RUN pip3 install -r /requirements.txt

COPY ./font_creator.py /home/app/font_creator.py
COPY ./flutefingering_v1_definition.yml /home/app/flutefingering_v1_definition.yml

ENV PYTHONPATH=/usr/lib/python3.6/site-packages:${PYTHONPATH}

CMD ["python3"]
