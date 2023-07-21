FROM mcr.microsoft.com/windows/servercore:ltsc2019 AS builder
ARG DOCKER_VERSION=24.0.4
ADD "https://download.docker.com/win/static/stable/x86_64/docker-${DOCKER_VERSION}.zip" docker.zip
ADD "https://gitlab.com/131/gitlab-runner/-/jobs/4689824664/artifacts/download" gitlab-runner.zip
RUN tar -xvf docker.zip
RUN mkdir tmp && tar -xvf gitlab-runner.zip -C tmp

FROM mcr.microsoft.com/windows/servercore:ltsc2019
COPY --from=builder docker/docker.exe docker.exe
COPY --from=builder tmp/out/binaries/gitlab-runner-windows-amd64.exe gitlab-runner.exe
RUN setx /M PATH "%PATH%;c:/apps/bin"

RUN net accounts /MaxPWAge:unlimited
RUN net user admin /add
RUN net localgroup Administrators /add admin
USER admin
ENTRYPOINT c:/apps/bin/gitlab-runner.exe
CMD run
LABEL "org.opencontainers.image.version"="0.1.0"
