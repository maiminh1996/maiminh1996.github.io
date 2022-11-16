---
layout: post
title: "Google colab"
subtitle: "google cloud notebook"
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

<b>Last modified: <script>document.write( document.lastModified );</script>

## Magic command

```txt
%paste # when code notebook formatting
%run <file.py> # == !python <file.py>
%timeit L = [n ** 2 for n in range(1000)] # single line code
%time 
%%timeit # multi line code
```

## Shell

```txt
!ls
!pwd
%cd == cd # !cd not working
%cat, %cp, %env, %ls, %man, %mkdir, %more, %mv, %pwd, %rm, and %rmdir
```

## Run & Debug

```txt
%run <file.py> # == !python <file.py>
%debug # up, down, quit
```

## Some useful setup

### Editor

`Menu > Tools > Settings`
    - `> Editor` font size: 12, space: 4, do not check `Automatically trigger code completions` to use Tab completion/ suggest: ctrl + space
    - `Github`: connect to github

### Change python env

#### Run on GPU 

`Menu > Runtime > change runtime type > GPU` (limited resource in terms of time)

#### Switch python version


## References

1. <https://colab.research.google.com/github/jakevdp/PythonDataScienceHandbook/blob/master/notebooks/Index.ipynb#scrollTo=j7L3GiLYp1hV>
