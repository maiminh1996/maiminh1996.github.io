---
layout: post
title: "Python testing with pytest"
# subtitle: "This is a subtitle"
date: 2023-03-12
author: "MAI Minh"
header-img: "img/"
header-style: text
tags: [vs code, python, testing]
catalog: true
permalink: /distilled/python/python-testing-with-pytest.html
# katex: true
mathjax: true
---
<!-- <b>Last modified: <script>document.write( document.lastModified );</script> -->

Two popular testing frameworks in Python are `unittest` and `pytest`. While `unittest` is a solid testing framework that comes with the Python standard library, `pytest` offers a more modern and flexible approach to testing that can save you time and effort in the long run. `pytest`: more concise and expressive, automatic test discovery, reused across multiple test cases, etc.

```bash
$ tree
├── calculator
│   ├── __init__.py
│   └── arithmetic.py
└── testing
    ├── __init__.py
    └── test_calculator.py
```

```python
# calculator/__init__.py
# from .arithmetic import add, subtract, division, multiply
# __all__ = ['add', 'subtract', 'division', 'multiply']
```

```python
# calculator/arithmetic.py
def add(a, b):
    return a + b

def subtract(a, b):
    return a - b

def division(a, b):
    return a / b

def multiply(a, b):
    return a * b
```

```python
# testing/__init__.py
import os, sys
sys.path.insert(0, os.path.join(os.path.dirname(os.path.abspath(__file__)), '../'))
```

```python
# testing/test_calculator.py
# from calculator import add, minus, division, multiply
# from calculator.arithmetic import add, minus, division, multiply
import calculator.arithmetic as arithmetic

def test_add():
    assert arithmetic.add(2, 3) == 5
    assert arithmetic.add(0, 0) == 0
    assert arithmetic.add(-1, 1) == 0
    assert arithmetic.add(-1, -1) == -2
```

By executing `pytest`, it searches for all the test functions `test_*` in the current root directory `./` that be defined any `*_test.py` or `test_*.py`, and runs them as test cases.

```bash
$ pytest
```

Alternatively, we can run `pytest`inside VS Code as follow (`ms-python.python` extension + `pytest` package):

In *Testing* (*Activiry Bar*): *Configure Python Tests* > *pytest* > *. Root directory*, all functions `test_` under . root directory will be appear in Testing and we then can:
- Run test
- Show output (`Ctrl+; Ctrl+O`)
- Set break point to debug on failure cases.


