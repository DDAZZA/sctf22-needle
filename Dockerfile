FROM ubuntu:18.04

RUN apt-get update && apt-get install -y openssh-server vim man
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

RUN chmod -R a-w /tmp/
RUN chmod -R a-w /home/ctfuser/
RUN mkdir /home/ctfuser/.bin

RUN ln /bin/cat /home/ctfuser/.bin/cat
RUN ln /bin/ls /home/ctfuser/.bin/ls
RUN ln /usr/bin/clear /home/ctfuser/.bin/clear
RUN ln /usr/bin/find /home/ctfuser/.bin/find
RUN ln /usr/bin/file /home/ctfuser/.bin/file
RUN ln /usr/bin/man /home/ctfuser/.bin/man
RUN ln /bin/grep /home/ctfuser/.bin/grep

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
