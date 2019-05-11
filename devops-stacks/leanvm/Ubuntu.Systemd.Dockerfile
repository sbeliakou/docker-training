FROM ubuntu:18.04

RUN apt-get update && apt-get install -y systemd && apt-get clean

CMD ["/lib/systemd/systemd"]
