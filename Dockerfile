FROM rcarmo/ubuntu-python

WORKDIR /app

RUN pip install Cython
RUN apt-get update
RUN apt-get install -y gcc \
                       git \
                       libatlas3-base \
                       libatlas3-base \
                       portaudio19-dev \
                       pulseaudio 
RUN pip install  --upgrade pip wheel setuptools
RUN pip install git+https://github.com/LedFx/LedFx

RUN apt-get install -y pulseaudio alsa-utils
RUN adduser root pulse-access

RUN apt-get install -y squeezelite 

COPY setup-files/ /app/
RUN chmod a+wrx /app/*

ENTRYPOINT ./entrypoint.sh 
