FROM scratch
MAINTAINER Jose Manuel Moreno Gavira <josem.moreno.gavira@gmail.com>

ADD files/20150429_ubuntu.tar.gz /

EXPOSE 8000 9090

RUN apt-get update \
	&& apt-get -y install libharfbuzz0b inotify-tools \
	&& apt-get clean all \
	&& easy_install -U pip \
	&& yes | pip uninstall watchdog && pip install pyinotify

# 0.68
RUN apt-get update && apt-get -y install libgdal-dev build-essential \
	&& pip install Fiona==1.5.1 Cython==0.22 \
	&& apt-get -y remove libgdal-dev build-essential \
	&& apt-get clean all
ENV LD_PRELOAD /usr/local/lib/libgdal.so.1

# 0.74
RUN pip install PPyGIS==0.2

# 0.81
RUN pip install Pillow==2.3.0

# 0.88
RUN apt-get -y install python-cffi

WORKDIR	/app/icom-tilesrenderer
ENV DATA_MANAGER_ZIPFILES /data/aemet
ENV DATA_MANAGER_UNZIPPED /data/input
ADD bin/ /usr/local/bin/
RUN chmod +x /usr/local/bin/meteo-*

