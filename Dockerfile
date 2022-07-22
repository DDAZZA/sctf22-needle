FROM ubuntu:18.04

RUN yes | unminimize
RUN apt-get update && apt-get install -y openssh-server vim man manpages-posix
RUN mkdir /run/sshd

# create ctfuser
RUN useradd --shell /bin/rbash --create-home ctfuser
RUN echo 'ctfuser:Gcepd4vMYL299RJX' | chpasswd

# remove default MOTD
RUN touch /home/ctfuser/.hushlogin

RUN locale-gen en_GB

# copy tasks
COPY src/haystack /opt/haystack
COPY src/bashrc /home/ctfuser/.bashrc

# COPY src/task5.txt 
COPY src/README.txt /home/ctfuser/
COPY src/task2.txt /home/ctfuser/
COPY src/task3.txt /home/ctfuser/.task3.txt
COPY src/task4.txt /tmp/
COPY src/task5.txt /opt/haystack/

ENV HOME /home/ctfuser

RUN chmod -R a-w /tmp/
RUN chmod -R a-w $HOME
RUN mkdir $HOME/.bin

RUN ln -s /bin/cat $HOME/.bin/cat
RUN ln -s /bin/ls $HOME/.bin/ls
RUN ln -s /usr/bin/clear $HOME/.bin/clear
RUN ln -s /usr/bin/find $HOME/.bin/find
RUN ln -s /usr/bin/file $HOME/.bin/file
# RUN ln -s /usr/bin/man $HOME/.bin/man
RUN ln -s /bin/grep $HOME/.bin/grep
RUN ln -s /usr/bin/base32 $HOME/.bin/base32
RUN ln -s /usr/bin/tail $HOME/.bin/tail
RUN ln -s /usr/bin/head $HOME/.bin/head
RUN ln -s /bin/more $HOME/.bin/more
RUN ln -s /usr/bin/less $HOME/.bin/less
RUN ln -s /usr/bin/awk $HOME/.bin/awk
RUN ln -s /usr/bin/sed $HOME/.bin/sed
RUN ln -s /usr/bin/groff $HOME/.bin/groff
RUN ln -s /usr/bin/nroff $HOME/.bin/nroff
RUN ln -s /usr/bin/whoami $HOME/.bin/whoami
RUN ln -s /bin/dir $HOME/.bin/dir
RUN ln -s /bin/which $HOME/.bin/which

WORKDIR $HOME
RUN echo "set disable-completion on" > $HOME/.inputrc

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
