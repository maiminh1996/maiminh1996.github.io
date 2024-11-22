---
layout: post
title: "Enabling image copy-paste in markdown"
date: 2024-11-22 13:14:00
tags: markdown
categories: tricks
featured: false
disqus_comments: true
toc:
  sidebar: left
---

In 2023, VS Code supports copying and pasting images directly into Markdown files starting from [Stable v1.79](https://code.visualstudio.com/updates/v1_79#_copy-external-media-files-into-workspace-on-drop-or-paste-for-markdown).

### Upgrade VS Code  

To use this feature, ensure your VS Code is updated. Use the following commands to upgrade on Ubuntu:  

```bash
sudo add-apt-repository -y "deb https://packages.microsoft.com/repos/vscode stable main"
sudo apt update
sudo apt -y install code
```

### Configure Settings

Add the following configuration to your `.vscode/settings.json` file to enable this feature and customize file destinations:

```json
{
    // Enable pasting files into the Markdown editor to create Markdown links.
    "markdown.editor.filePaste.copyIntoWorkspace": "mediaFiles",
    
    // Define destination folders for pasted files.
    "markdown.copyFiles.destination": {
      "**/*": "../assets/img/${documentBaseName}/"
    }
}
```

Now, when you paste an image into a Markdown file, it will automatically save to the specified directory and generate the corresponding Markdown link.
