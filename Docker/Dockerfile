FROM centos:7

RUN set -x && yum update -y
RUN yum install -y sudo man unzip

# ansible
COPY .ssh /root/.ssh
WORKDIR /root/work
RUN curl https://raw.githubusercontent.com/yakisuzu/provisioning-ansible/master/script/download.sh | bash
RUN provisioning-ansible/init.sh
RUN provisioning-ansible/run_ansible.sh

COPY netrc /root/.netrc


WORKDIR /root
#ENTRYPOINT ["/bin/bash", "--login", "-i"]
CMD ["/bin/bash", "--login", "-i"]

