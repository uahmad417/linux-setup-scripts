FROM ubuntu
RUN apt update && apt install sudo
RUN useradd --create-home --shell /bin/bash -G sudo newuser
USER newuser
WORKDIR /home/newuser/
COPY ./setup.sh
CMD ["bash", "setup.sh"]