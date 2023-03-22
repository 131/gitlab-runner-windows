FROM mcr.microsoft.com/windows/servercore:ltsc2019
WORKDIR c:/apps/bin
RUN curl -L -o docker-20.10.21.zip https://download.docker.com/win/static/stable/x86_64/docker-20.10.21.zip && tar -xvf docker-20.10.21.zip && move docker\docker.exe docker.exe && del docker-20.10.21.zip && rd /s /q docker
RUN curl -L -o gitlab-runner.exe  "https://s3.amazonaws.com/gitlab-runner-downloads/v15.10.0/binaries/gitlab-runner-windows-amd64.exe"

RUN setx /M PATH "%PATH%;c:/apps/bin"

RUN net accounts /MaxPWAge:unlimited
RUN net user admin /add
RUN net localgroup Administrators /add admin
USER admin
ENTRYPOINT c:/apps/bin/gitlab-runner.exe
CMD run
LABEL "org.opencontainers.image.version"="0.0.1"
