FROM centos:7

COPY ssh /root/.ssh
RUN set -x && yum update -y
RUN yum install -y git

WORKDIR /root/

#ENTRYPOINT ["/bin/bash", "--login", "-i"]
CMD ["/bin/bash", "--login", "-i"]

