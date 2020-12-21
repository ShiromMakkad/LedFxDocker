FROM rcarmo/ubuntu-python

WORKDIR /app

RUN pip install Cython
RUN apt-get update
RUN apt-get install -y portaudio19-dev
RUN pip install ledfx

RUN apt-get install -y pulseaudio alsa-utils
RUN adduser root pulse-access

COPY setup-files /app
RUN chmod a+wrx /app

ENTRYPOINT ./entrypoint.sh 