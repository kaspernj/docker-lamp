#!/bin/sh

docker run -d --restart=always --net [NET-NAME] --ip=[IP] --publish [SSH-PORT]:22 -v [SHARED-FOLDER]:/shared --name [CONTAINER-NAME] lamp
