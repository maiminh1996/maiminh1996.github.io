---
layout: post
title: "Python testing with pytest"
subtitle: "A Guide to Writing Automated Tests in Python"
date: 2023-03-12
author: "MAI Minh"
header-img: "img/"
header-style: text
tags: vs-code python testing
catalog: true
# permalink: /distilled/python/python-testing-with-pytest.html
# katex: true
mathjax: true
disqus_comments: true
toc:
  sidebar: left
---

---

### Introduction

Testing frameworks play an important role in software development, allowing developers to write automated tests that can quickly and reliably check whether their code is working as expected. In Python, two popular testing frameworks are `unittest` and `pytest`. While `unittest` is a solid testing framework that comes with the Python standard library, `pytest` offers a more modern and flexible approach to testing (more concise and expressive, automatic test discovery, reused across multiple test cases, etc.) that can save time and effort in the long run.

### Why pytest?

pytest offers several advantages:
- **Simplicity**: concise syntax and easy to understand.
- **Rich Set of Features**: assertion methods, fixture management, test discovery, and test parameterization.
- **Integration and Extensibility**: support test coverage, plugins for test reporting, and compatibility with continuous integration systems.

### Getting started with pytest via an example

To demonstrate how pytest works, let's start by setting up a simple python project. We create a directory called mymath that contains Python modules called `module1.py` and `module2.py`, which defines several math functions, and a directory called `tests/` that contains Python test modules called `test_module1.py`, `test_module2.py`.

```bash
$ tree
.
├── Dockerfile
├── docs/
├── README.md
├── requirements.txt
├── src/
│   ├── main.py
│   └── mymath/
│       ├── __init__.py
│       ├── module1.py
│       └── module2.py
└── tests/
    ├── __init__.py
    ├── test_module1.py
    └── test_module2.py
```
```python
# src/mymath/__init__.py
```

```python
# src/mymath/module1.py
class Arithmetic:
    def __init__(self):
        pass
    def add(self, a, b):
        return a + b

    def subtract(self, a, b):
        return a - b

    def division(self, a, b):
        return a / b

    def multiply(self, a, b):
        return a * b
```

```python
# src/mymath/module2.py
def factorial_int(num):
    factorial = 1
    if num < 0:
        # raise ValueError("value must be <= 0")
        return 0 # TRY DOING STH WRONG HERE #
    elif num == 0:
        return 1
    else:
        for i in range(1,num + 1):
            factorial = factorial*i
        return factorial
```

```python
# tests/__init__.py
import os, sys

current_dir = os.path.dirname(os.path.abspath(__file__))
root_dir = os.path.dirname(current_dir)
src_dir = os.path.join(root_dir, 'src')
sys.path.insert(0, src_dir)
```

```python
# tests/test_module1.py 
import mymath.module1 as module1

def test_add():
    test = test.Arithmetic()
    assert test.add(2, 3) == 5
    assert test.add(0, 0) == 0
    assert test.add(-1, 1) == 0
    assert test.add(-1, -1) == -2


def test_mul():
    test = module1.Arithmetic()
    assert test.multiply(2, 3) == 6
    assert test.multiply(0, 0) == 0
    assert test.multiply(-1, 1) == -1
    assert test.multiply(-1, -1) == 1
```

```python
# tests/test_module2.py 
import pytest
import mymath.module2 as module2

def test_factorial_int():
    assert module2.factorial_int(4) == 24
    assert module2.factorial_int(0) == 1
    assert module2.factorial_int(1) == 1

    with pytest.raises(ValueError) as excinfo:
        module2.factorial_int(-1)
    assert str(exc_info.value) == "value must be <= 0"
```

Check [PyTest how to write and report assertions in tests](https://docs.pytest.org/en/7.3.x/how-to/assert.html) or [PyTest API reference](https://docs.pytest.org/en/7.1.x/reference/reference.html) (such as approx, fail, skip, raises, warns, etc.) to know how to write test cases.
##### pytest in command line
Install `pytest`:
```bash
pip install -U pytest
```
Run the tests using `pytest`, we simply need to execute the following command from the command line:

```bash
pytest
```
`pytest` will automatically search for all the *`test_*`* functions that are defined in any `*_test.py` or `test_*.py` files in the current root directory `./`, and run them as test cases. In this case, it will find *`test_module*1.py`* and execute the *`test_add()`* function, which checks that the add function from *`module1.py`* works correctly and so on for `module2.py`.

![](../../../assets/img/pytest_output.png)

Pytest shows that we have 2 passed and 1 failed which comes from the function `factorial_int()` taking the -1 as input `tests/test_module2.py`. We fix this by modifing `tests/test_module2.py` 
Pytest reports 2 passing tests and 1 failing test originating from the `factorial_int()` function in `tests/test_module2.py`, where the input -1 resulted in the failure. To address this, we make modifications to `src/module2.py`.

```python
# src/module2.py 
def factorial_int(num):
   factorial = 1
   if num < 0:
      raise ValueError("value must be <= 0") # FIX IS HERE
      # return 0
   elif num == 0:
      return 1
   else:
      for i in range(1,num + 1):
         factorial = factorial*i
      return factorial
```

Then rerun `pytest` and it will report 3 passing test and show:
![](../../../assets/img/pytest_output2.png)


Note that if a test case fails or raises an exception, `pytest` might stop executing further test cases. Fixing the failures or errors might allow `pytest` to proceed with running the remaining test cases.


##### pytest in VS Code

Alternatively, we can run `pytest`inside VS Code as follow (`ms-python.python` extension + `pytest` package):

In <kbd>Testing</kbd> (<kbd>Activiry Bar</kbd>): <kbd>Configure Python Tests</kbd> > <kbd>pytest</kbd> > <kbd>. Root directory</kbd>, all functions `test_` under root directory will be appear in Testing and we then can:
- Run test
- Show output (`Ctrl+; Ctrl+O`)
- Set break point to debug on failure cases.

![](../../../assets/img/pytest_vscode.png)

### Writing effective test cases

To write effective test cases with pytest, consider the following best practices:
- Test Naming: Use descriptive and meaningful names for your test functions to clearly convey their purpose and expected behavior.
- Assertion Methods: assertion methods, such as assert, assertEqual, assertRaises.
- Test Organization: test cases into logical groups, pytest markers and tags.
- Fixtures: pytest fixtures.

Check out some advanced pytest features such as [parametrized tests](https://docs.pytest.org/en/7.3.x/how-to/parametrize.html), [test discovery](https://docs.pytest.org/en/7.1.x/example/pythoncollection.html), mocking and patching.

In addition, pytest can integrate with other tools and frameworks such as CI, test coverage, test reporting.

### Conclusion

In summary, pytest offers a more modern and flexible approach to testing in Python, making it easier and faster to write and run automated tests. By following this simple example, you can start using pytest in your own projects and see the benefits for yourself.

### References

1. PyTest docs [docs.pytest.org](https://docs.pytest.org)
2. PyTest how to write and report assertions in tests [docs.pytest.org/en/7.3.x/how-to/assert.html](https://docs.pytest.org/en/7.3.x/how-to/assert.html)
3. PyTest API reference [docs.pytest.org/en/7.1.x/reference/reference.html](https://docs.pytest.org/en/7.1.x/reference/reference.html)

### Appendix

#### Error keywords in Python

Some commonly used error keywords in Python:
- `ZeroDivisionError`: Raised when dividing a number by zero.
- `TypeError`: Raised when an operation or function is applied to an object of an inappropriate type.
- `ValueError`: Raised when a function receives an argument of the correct type but an invalid value.
- `IndexError`: Raised when trying to access an index that is out of range.
- `KeyError`: Raised when trying to access a dictionary key that doesn't exist.
- `FileNotFoundError`: Raised when a file or directory is not found.
- `AssertionError`: Raised when an assert statement fails.
- `ImportError`: Raised when an imported module or attribute cannot be found.
- `AttributeError`: Raised when an attribute reference or assignment fails.
- `RuntimeError`: Raised when a generic runtime error occurs.
