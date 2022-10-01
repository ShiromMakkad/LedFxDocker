FROM python:3.9-buster

WORKDIR /app

RUN pip install Cython
RUN dpkg --add-architecture armhf
RUN apt-get update
RUN apt-get install -y gcc \
                       git \
                       libatlas3-base \
		       libavformat58 \
		       portaudio19-dev \
		       avahi-daemon \
		       pulseaudio
RUN pip install --upgrade pip wheel setuptools
RUN pip install lastversion
RUN pip install git+https://github.com/LedFx/LedFx

RUN apt-get install -y alsa-utils
RUN adduser root pulse-access

# https://gnanesh.me/avahi-docker-non-root.html
RUN apt-get install -y libnss-mdns
RUN echo '*' > /etc/mdns.allow \
	&& sed -i "s/hosts:.*/hosts:          files mdns4 dns/g" /etc/nsswitch.conf \
	&& printf "[server]\nenable-dbus=no\n" >> /etc/avahi/avahi-daemon.conf \
	&& chmod 777 /etc/avahi/avahi-daemon.conf \
	&& mkdir -p /var/run/avahi-daemon \
	&& chown avahi:avahi /var/run/avahi-daemon \
	&& chmod 777 /var/run/avahi-daemon

RUN apt-get install -y wget \
                       libavahi-client3:armhf \
                       libavahi-common3:armhf \
                       apt-utils \
		       libvorbisidec1:armhf

RUN apt-get install -y squeezelite 

ARG TARGETPLATFORM
RUN if [ "$TARGETPLATFORM" = "linux/arm/v7" ]; then ARCHITECTURE=armhf; elif [ "$TARGETPLATFORM" = "linux/arm64" ]; then ARCHITECTURE=armhf; else ARCHITECTURE=amd64; fi \
    && lastversion download badaix/snapcast --format assets --filter "^snapclient_(?:(\d+)\.)?(?:(\d+)\.)?(?:(\d+)\-)?(?:(\d)(_$ARCHITECTURE\.deb))$" -o snapclient.deb

RUN apt-get install -fy ./snapclient.deb

COPY setup-files/ /app/
RUN chmod a+wrx /app/*

ENTRYPOINT ./entrypoint.sh
