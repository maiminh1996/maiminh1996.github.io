---
layout: post
title: "Mastering Google Colab: Tips and Tricks"
subtitle: "Boost Your Productivity and Take Full Advantage of Google Colab's Powerful Features"
date: 2022-11-16
author: "MAI Minh"
header-img: "img/"
header-style: text
tags: [python, machine learning, deep learning]
catalog: true
permalink: /distilled/python/google-colab.html
# katex: true
mathjax: true
---

<!-- <b>Last modified: <script>document.write( document.lastModified );</script> -->

### Introduction

Google colab is a free Jupyter notebook environment provided by Google. It offers a great way to write and run code, and it comes with many powerful features. In this blog post, we will explore some of the magic commands and tips that can help you to be more productive in Colab.
### Magic command

Magic commands are special commands that start with a percent sign `%` or two percent signs %% and are used to perform various operations. Here are some useful magic commands in Colab:

```txt
%paste # when code notebook formatting
%run <file.py> # == !python <file.py>
%timeit L = [n ** 2 for n in range(1000)] # single line code
%time 
%%timeit # multi line code
```

### Shell commands

You can also use shell commands in Colab by prefixing them with an exclamation mark `!`. Here are some of the most common ones:

```txt
!ls
!pwd
%cd == cd # !cd not working
%cat, %cp, %env, %ls, %man, %mkdir, %more, %mv, %pwd, %rm, and %rmdir
```

### Run and debug

Colab makes it easy to run and debug your code. Here are some of the commands you can use:

```txt
%run <file.py> # == !python <file.py>
%debug # up, down, quit
```

### Useful setup
To make your Colab experience even better, here are some tips for setting up your environment:

#### Editor

Go to `Menu > Tools > Settings` and adjust the following settings:
- `Editor` font size: 12, space: 4, do not check `Automatically trigger code completions` to use Tab completion/ suggest: ctrl + space
- `Github`: connect to github

#### Change python env

Run on GPU:
- To run your code on a GPU, go to `Menu > Runtime > change runtime type > GPU` (limited resource in terms of time).

Switch python version
- Open a new or existing notebook in Colab.
- Click on `Runtime` in the menu bar, then click on `Change runtime type`.
- In the `Runtime type` dropdown, select `Python` as the runtime type.
- In the `Python version` dropdown, select the version of Python you want to use. Colab currently supports Python 2.7, 3.6, 3.7, and 3.8.
- Click on `Save` to apply the changes.
### Conclusion

These tips and tricks will help you to be more productive in Colab and get the most out of this great tool. Happy coding!
### References

1. <https://colab.research.google.com/github/jakevdp/PythonDataScienceHandbook/blob/master/notebooks/Index.ipynb#scrollTo=j7L3GiLYp1hV>
