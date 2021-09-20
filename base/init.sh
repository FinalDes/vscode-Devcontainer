#!/bin/bash
socat UNIX-LISTEN:/var/run/docker.sock,fork,mode=660,user=vscode UNIX-CONNECT:/var/run/docker-host.sock
gosu vscode "$@"