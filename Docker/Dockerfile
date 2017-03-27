FROM centos:7

RUN set -x && yum update -y
RUN yum install -y git

COPY ssh /root/.ssh
COPY netrc /root/.netrc

WORKDIR /root/

#ENTRYPOINT ["/bin/bash", "--login", "-i"]
CMD ["/bin/bash", "--login", "-i"]

