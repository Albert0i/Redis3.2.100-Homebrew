FROM mcr.microsoft.com/windows/nanoserver:20H2

WORKDIR /Data

USER ContainerAdministrator
RUN setx /M PATH "%PATH%;C:\Redis" &&\
    mkdir \Redis &&\
    cd \Redis &&\
    curl -OL "https://github.com/MSOpenTech/redis/releases/download/win-3.2.100/Redis-x64-3.2.100.zip" &&\ 
    tar -xvf Redis-x64-3.2.100.zip &&\
    del Redis-x64-3.2.100.zip &&\
    dir 
USER ContainerUser
COPY redis.docker.conf /Redis

CMD ["redis-server.exe","C:\\Redis\\redis.docker.conf"]

EXPOSE 6379

#
# Build
#   docker build -t redis:3.2.100-nanoserver-1909 . 
#
# Test 
#   docker run -it --rm redis:3.2.100-nanoserver-1909 cmd 
#
# Run 
#   docker run -p 6379:6379 --rm --name redis -d -v c:\Docker\redis\data:c:\data redis:3.2.100-nanoserver-1909
#
# Cmd 
# docker run -it --name redis cmd
#
# Reference:
# 1. Cannot update PATH variable in a windows docker container
#    https://forums.docker.com/t/cannot-update-path-variable-in-a-windows-docker-container/30960
# 2. Multiple RUN vs. single chained RUN in Dockerfile, which is better?
#    https://stackoverflow.com/questions/39223249/multiple-run-vs-single-chained-run-in-dockerfile-which-is-better
# 3. How to unzip a file using the cmd?
#    https://superuser.com/questions/1314420/how-to-unzip-a-file-using-the-cmd
# 4. tar: Unrecognized archive format error when trying to unpack flower_photos.tgz, TF tutorials on OSX
#    https://stackoverflow.com/questions/42268180/tar-unrecognized-archive-format-error-when-trying-to-unpack-flower-photos-tgz
#

#
# EOF (2022/04/08)
#