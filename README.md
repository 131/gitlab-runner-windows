Use with

[![Image pulls](https://img.shields.io/docker/pulls/131hub/gitlab-runner-windows)](https://hub.docker.com/r/131hub/gitlab-runner-windows)
[![Image version](https://img.shields.io/docker/v/131hub/gitlab-runner-windows)](https://hub.docker.com/r/131hub/gitlab-runner-windows)
[![Image size](https://img.shields.io/docker/image-size/131hub/gitlab-runner-windows)](https://hub.docker.com/r/131hub/gitlab-runner-windows)



# Motivation

[`131hub/gitlab-runner-windows`](https://hub.docker.com/r/131hub/gitlab-runner-windows) is a **docker image** bringing simple gitlab-runner windows container.



# Usage in a swarm
```
services:
  shellwin-ivscloud-local:
    image: 131hub/gitlab-runner-windows

    entrypoint: ["powershell.exe", "-command"]
    command: |
      # connect to local NAT and change default route to it
      # yet, we keep all overlay traffic to ingress route AND from local area -10.26/10.24 & co-
      route delete 0.0.0.0;
      route add 10.0.0.0 MASK 255.0.0.0 10.0.4.1 METRIC 1;
      docker network connect nat $$(hostname);
      gitab-runner run;

    networks:
      - default

    volumes:
      - type: npipe
        source: \\.\pipe\docker_engine
        target: \\.\pipe\docker_engine

      - type: bind
        source: c:\gitlab
        target: c:\gitlab

```
