---
layout: post
title: "Docker inside VS Code"
subtitle: "Running and debugging Python in Docker with Visual Studio Code"
date: 2023-03-10
author: "MAI Minh"
header-img: "img/"
header-style: text
tags: [docker, vs code]
catalog: true
permalink: /distilled/ide/docker-inside-vs-code.html
# katex: true
mathjax: true
---


Developers often use Docker to build, ship, and run applications in a consistent environment. And the integration of Docker with VSCode provides a streamlined development experience for them. In this article, we'll show you how to use Docker within VS Code to build, run, and debug Python applications.

Contents
- [Installing the necessary extensions](#installing-the-necessary-extensions)
- [Building and running a Docker container](#building-and-running-a-docker-container)
- [Debugging inside Docker container](#debugging-inside-docker-container)
- [Conclusion](#conclusion)

### Installing the necessary extensions

First, we need to install two VS Code extensions:
- *ms-vscode-remote.remote-containers* (to have a full-featured VS Code environment inside a Docker container)
- *ms-azuretools.vscode-docker* (to manage Docker images and containers directly from the editor)

Once you've installed these extensions, you should see a new Docker icon in the left-hand Activity Bar of VS Code:
- Containers
- Images

Task with Container:
- `Ctrl+Shift+P` &rarr; *> Dev Containers: ...*
- Or, *Open a Remote Windown* (*Status Bar*) &rarr; 


### Building and running a Docker container

To build a Docker container for our Python project, we need to create a Dockerfile that specifies the container's environment. In this example, we'll create a simple Dockerfile that installs Python 3.9:

```Dockerfile
# Dockerfile
FROM ubuntu:20.04
RUN apt-get update && \
    apt-get install -y python3.9 python3.9-dev
COPY . /home
WORKDIR /home
```

In the same directory as our Dockerfile, we also have a Python file called test.py.
```bash
$ tree
├── Dockerfile
└── test.py
```

To build the Docker image, we can 
- Right-click on the *Dockerfile* &rarr; *Build Image* &rarr; Set image tag name (e.g. testdocker:39)
- Or, we can run the following command in the terminal `docker build -t testdocker:39`

Once we've built the image, we can run a container using the following command:
- Or, Run container by right click on the built image (e.g. testdocker:39) (*IMAGES < Docker < Activity Bar*) &rarr; *Run Interactive* &rarr; Right click on the running container (e.g. testdocker:39) (*CONTAINERS < Docker < Activity Bar*) &rarr; *Attach Visual Studio Code*
- Or, `Ctrl+Shift+P` &rarr; *> Dev Containers: Reopen in container*
- Or, `docker run -it testdocker:39` &rarr;  Right click on the running container (e.g. testdocker:39) (*CONTAINERS < Docker < Activity Bar*) &rarr; *Attach Visual Studio Code*

### Debugging inside Docker container

Once we're inside the container, we can open the project folder in VS Code by using the *Open Folder* (`Ctrl+O`). Then, we can install the `ms-python.python` (&rarr; *Install in Dev Container: Existing Dockerfile*) extension for Python and set up a launch configuration `.vscode/launch.json` for debugging.

Here's an example launch configuration for a Python file called test.py:

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

With the launch configuration set up, we can use VS Code's debugging tools to step through our Python code and troubleshoot any issues.

### Conclusion

By using Docker with VS Code, we can build, run, and debug Python applications in a consistent environment that's isolated from our host machine. This approach can save time and effort, and it helps ensure that our applications will run correctly in any environment.