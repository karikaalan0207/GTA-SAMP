FROM ubuntu:latest

# SA-MP server executable is a x86 application only
RUN dpkg --add-architecture i386

# Install packages
RUN apt-get update && apt-get install -y \
 lib32stdc++6 \
 wget \
 psmisc

# Download and extract server files
# Choose a more general directory name which does not contain any version
RUN wget http://files.sa-mp.com/samp037svr_R2-1.tar.gz \
 && tar -zxf samp037svr_R2-1.tar.gz \
 && rm -f samp037svr_R2-1.tar.gz \
 && mv samp03 samp-svr \
 && cd samp-svr \
 && mv samp03svr samp-svr \
 && chmod 700 * \
 && sed -i 's/changeme/9020/g' server.cfg \
 && sed -i 's/Server/IN_Server/g' server.cfg \
 && sed -i '11d' server.cfg \
 && cat server.cfg

COPY samp.sh /samp.sh

ENTRYPOINT ["/samp.sh"]
	
EXPOSE 7777/udp

