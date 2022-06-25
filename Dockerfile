FROM ubuntu:18.04

RUN apt-get update && apt-get install -y openssh-server
RUN mkdir /run/sshd

# create ctfuser
RUN useradd --shell /bin/rbash --create-home ctfuser
RUN echo 'ctfuser:Gcepd4vMYL299RJX' | chpasswd

# remove default MOTD
RUN touch /home/ctfuser/.hushlogin

# copy tasks
COPY src/haystack /opt/haystack
COPY src/bashrc /home/ctfuser/.bashrc

# COPY src/task5.txt 
COPY src/README.txt /home/ctfuser/
COPY src/task2.txt /home/ctfuser/
COPY src/task3.txt /home/ctfuser/.task3.txt
COPY src/task4.txt /tmp/
COPY src/task5.txt /opt/haystack/


EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
