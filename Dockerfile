FROM ubuntu

MAINTAINER mecab <mecab@misosi.ru>

RUN apt-get update \
	&& apt-get install -y git \
		software-properties-common \
		wget \
	&& apt-get clean

RUN git clone https://github.com/torch/distro.git /root/torch --recursive
WORKDIR /root/torch
RUN apt-get update \
	&& ./install-deps \
	&& ./install.sh -b \
	&& apt-get clean

RUN git clone https://github.com/satoshiiizuka/siggraph2016_colorization.git /root/siggraph2016_colorization
WORKDIR /root/siggraph2016_colorization
RUN	./download_model.sh

RUN mkdir /root/bin
COPY colorize /root/bin/

ENTRYPOINT ["/root/bin/colorize"]
CMD [""]

