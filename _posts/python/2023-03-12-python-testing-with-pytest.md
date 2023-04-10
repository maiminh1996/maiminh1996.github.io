---
layout: post
title: "Python testing with pytest"
subtitle: "Streamlining Python Testing with Pytest: A Guide to Writing Automated Tests"
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

### Introduction

Testing frameworks play an important role in software development, allowing developers to write automated tests that can quickly and reliably check whether their code is working as expected. In Python, two popular testing frameworks are `unittest` and `pytest`. While `unittest` is a solid testing framework that comes with the Python standard library, `pytest` offers a more modern and flexible approach to testing (more concise and expressive, automatic test discovery, reused across multiple test cases, etc.) that can save time and effort in the long run.

### Code example

To demonstrate how pytest works, let's start by setting up a simple directory structure. We'll create a directory called calculator that contains a Python module called arithmetic.py, which defines several arithmetic functions, and a directory called testing that contains a Python test module called test_calculator.py.

```bash
$ tree
├── calculator
│   ├── __init__.py
       └── arithmetic.py
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

To run the tests using `pytest`, we simply need to execute the following command from the command line:

```bash
$ pytest
```

`pytest` will automatically search for all the test functions `test_*` that are defined in any `*_test.py` or `test_*.py` files in the current root directory `./`, and run them as test cases. In this case, it will find *test_calculator.py* and execute the *test_add function*, which checks that the add function from *arithmetic.py* works correctly.

Alternatively, we can run `pytest`inside VS Code as follow (`ms-python.python` extension + `pytest` package):

In *Testing* (*Activiry Bar*): *Configure Python Tests* > *pytest* > *. Root directory*, all functions `test_` under . root directory will be appear in Testing and we then can:
- Run test
- Show output (`Ctrl+; Ctrl+O`)
- Set break point to debug on failure cases.

### Conclusion

In summary, pytest offers a more modern and flexible approach to testing in Python, making it easier and faster to write and run automated tests. By following this simple example, you can start using pytest in your own projects and see the benefits for yourself.