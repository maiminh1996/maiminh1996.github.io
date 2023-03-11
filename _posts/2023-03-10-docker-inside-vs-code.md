---
layout: post
title: "Docker inside VS Code"
# subtitle: "This is a subtitle"
date: 2023-03-10
author: "MAI Minh"
header-img: "img/"
header-style: text
tags: [docker, vs code]
catalog: true
permalink: /distilled/docker-inside-vs-code.html
# katex: true
mathjax: true
---
<!-- <b>Last modified: <script>document.write( document.lastModified );</script> -->

Contents
- [Docker in VS Code](#docker-in-vs-code)
- [Run and debug python within a docker container in VS Code](#run-and-debug-python-within-a-docker-container-in-vs-code)



### Docker in VS Code

Extensions:
- *ms-vscode-remote.remote-containers* (full-featured VS Code for Docker container)
- *ms-azuretools.vscode-docker* (Docker)

Docker (*Docker < Activity Bar*):
- Containers
- Images

Task with Container:
- `Ctrl+Shift+P` &rarr; *> Dev Containers: ...*
- Or, *Open a Remote Windown* (*Status Bar*) &rarr; 

### Run and debug python within a docker container in VS Code

We want to build/ run Docker container and then run/ debug python files using fully-featured VS Code. Let's take an example, we have a project and a simple Dockerfile located in the project root directory as below:
```bash
$ tree
├── Dockerfile
└── test.py
```
```Dockerfile
# Dockerfile
FROM ubuntu:20.04
RUN apt-get update && \
    apt-get install -y python3.9 python3.9-dev
COPY . /home
WORKDIR /home
```

- Build image: 
    - Right click on *Dockerfile* &rarr; *Build Image* &rarr; Set image tag name (e.g. testdocker:39)
    - Or, `docker build -t testdocker:39 .`

- Run Docker container and open project in VS Code:
    - Or, Run container by right click on the built image (e.g. testdocker:39) (*IMAGES < Docker < Activity Bar*) &rarr; *Run Interactive* &rarr; Right click on the running container (e.g. testdocker:39) (*CONTAINERS < Docker < Activity Bar*) &rarr; *Attach Visual Studio Code*
    - Or, `Ctrl+Shift+P` &rarr; *> Dev Containers: Reopen in container*
    - Or, `docker run -it testdocker:39` &rarr;  Right click on the running container (e.g. testdocker:39) (*CONTAINERS < Docker < Activity Bar*) &rarr; *Attach Visual Studio Code*

- Some setups:
    - *Open Folder* (`Ctrl+O`) &rarr; */home/*
    - *Extensions*: ms-python.python (python) &rarr; *Install in Dev Container: Existing Dockerfile*
    - Create `.vscode/launch.json` file for debugging
```json
// .vscode/launch.json
{
    "version": "0.2.0",
    "configurations": [
        {
            "name": "Python project",
            "type": "python",
            "request":  "launch",
            "program":  "test.py",
            "pythonPath": "/usr/bin/python3.9",
            "console":  "integratedTerminal",
            "cwd":  "${workspaceFolder}",
            // "args": ["", ""]
        }
    ]
}
```

Then, let's debug :D (break point, etc)

