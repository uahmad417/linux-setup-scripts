FROM ubuntu
COPY ./setup.sh /
CMD ["bash", "setup.sh"]