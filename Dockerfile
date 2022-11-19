FROM ubuntu
RUN apt update && apt install sudo
RUN useradd --create-home --shell /bin/bash -G sudo docker
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
USER docker
WORKDIR /home/docker/
COPY ./setup.sh ./
CMD ["bash", "setup.sh"]