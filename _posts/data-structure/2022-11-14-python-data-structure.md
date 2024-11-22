---
layout: post
title: "Python data structure"
# subtitle: "This is a subtitle"
date: 2022-11-14
author: "MAI Minh"
header-img: "img/"
header-style: text
tags: python
categories: Data-Structure
catalog: true
# permalink: /distilled/data-structure/python-data-structure.html
# katex: true
mathjax: true
disqus_comments: true
toc:
  sidebar: left
---
<!-- <b>Last modified: <script>document.write( document.lastModified );</script> -->


## Built-in data structure

### Short comparison

[List](#list), [Tuple](#tuple), [Set](#set), [Dictionary](#dictionary)

```txt
|       | Ordered | Changeable | Allow Duplicate | Indexed | Notes                                       |
|-------|---------|------------|-----------------|---------|---------------------------------------------|
| List  | x       | x          | x               | x       |                                             |
| Tuple | x       |            | x               | x       |                                             |
| Set   |         |            |                 |         | unchangeable, but can remove/ add new items |
| Dict  | x       | x          |                 | x       | ordered, python > 3.6                       |
```

```python
# init
data_string = "I love deep learning"
data_list = ["I", "love", "deep learning"]
weekdays_tuple = ("monday", "tuesday", "wednesday", "thursday", "friday", "saturday", "sunday")
fruits_set = {"apple", "banana", "cherry"}
data_dict = {"I": "Minh", "love": 3000, "deep learning": "pytorch"}

# methods
family_age_temp = {"dad": 26, "mom": 24}
family_age = family_age.copy() # not new_dict = data_dict
family_age_temp.clear() 
```

### List

```txt
                               Complexity
Operation     | Example      | Class         | Notes
--------------+--------------+---------------+-------------------------------
Index         | l[i]         | O(1)	     |
Store         | l[i] = 0     | O(1)	     |
Length        | len(l)       | O(1)	     |
Append        | l.append(5)  | O(1)	     | mostly: ICS-46 covers details
Pop	      | l.pop()      | O(1)	     | same as l.pop(-1), popping at end
Clear         | l.clear()    | O(1)	     | similar to l = []

Slice         | l[a:b]       | O(b-a)	     | l[1:5]:O(l)/l[:]:O(len(l)-0)=O(N)
Extend        | l.extend(...)| O(len(...))   | depends only on len of extension
Construction  | list(...)    | O(len(...))   | depends on length of ... iterable

check ==, !=  | l1 == l2     | O(N)          |
Insert        | l[a:b] = ... | O(N)	     | 
Delete        | del l[i]     | O(N)	     | depends on i; O(N) in worst case
Containment   | x in/not in l| O(N)	     | linearly searches list 
Copy          | l.copy()     | O(N)	     | Same as l[:] which is O(N)
Remove        | l.remove(...)| O(N)	     | 
Pop	      | l.pop(i)     | O(N)	     | O(N-i): l.pop(0):O(N) (see above)
Extreme value | min(l)/max(l)| O(N)	     | linearly searches list for value
Reverse	      | l.reverse()  | O(N)	     |
Iteration     | for v in l:  | O(N)          | Worst: no return/break in loop

Sort          | l.sort()     | O(N Log N)    | key/reverse mostly doesn't change
Multiply      | k*l          | O(k N)        | 5*l is O(N): len(l)*l is O(N**2)
```

### Tuple

> Tuple: Similar to List, the difference is that the list is immutable and cannot be changed. That is, right after defining the tuple, we cannot change it.

Tuple: "write-protect" data cannot store a specific block of memory, and List often has to change storage space --> <span style="color:red">Tuple faster than List</span>. Tuple is also used as a key in Dictionary because it contains constant values, List cannot be used as a key for Dictionary.

Tuples support all operations that do not mutate the data structure (and they have the same complexity classes).

### Set

> set is a data structure related to set math, also known as set theory (union, intersection, difference, etc)

```txt
                               Complexity
Operation     | Example      | Class         | Notes
--------------+--------------+---------------+-------------------------------
Length        | len(s)       | O(1)	     |
Add           | s.add(5)     | O(1)	     |
Containment   | x in/not in s| O(1)	     | compare to list/tuple - O(N)
Remove        | s.remove(..) | O(1)	     | compare to list/tuple - O(N)
Discard       | s.discard(..)| O(1)	     | 
Pop           | s.pop()      | O(1)	     | popped value "randomly" selected
Clear         | s.clear()    | O(1)	     | similar to s = set()

Construction  | set(...)     | O(len(...))   | depends on length of ... iterable
check ==, !=  | s != t       | O(len(s))     | same as len(t); False in O(1) if
      	      	     	       		       the lengths are different
<=/<          | s <= t       | O(len(s))     | issubset
>=/>          | s >= t       | O(len(t))     | issuperset s <= t == t >= s
Union         | s | t        | O(len(s)+len(t))
Intersection  | s & t        | O(len(s)+len(t))
Difference    | s - t        | O(len(s)+len(t))
Symmetric Diff| s ^ t        | O(len(s)+len(t))

Iteration     | for v in s:  | O(N)          | Worst: no return/break in loop
Copy          | s.copy()     | O(N)	     |
```

--> <span style="color:red">Set has many more operations that are O(1)</span> compared with [list](#List) and [Tuple](#tuple). Not needing to keep values in a specific order in a set (while lists/ tuples require an order) allows for faster implementations of some set operations.

Frozen sets support all operations that do not mutate the data structure (and they have the same complexity classes).

### Dictionary

> HashMaps are similar to dictionaries in Python. 

```txt
                               Complexity
Operation     | Example      | Class         | Notes
--------------+--------------+---------------+-------------------------------
Index         | d[k]         | O(1)	     |
Store         | d[k] = v     | O(1)	     |
Length        | len(d)       | O(1)	     |
Delete        | del d[k]     | O(1)	     |
get/setdefault| d.get(k)     | O(1)	     |
Pop           | d.pop(k)     | O(1)	     | 
Pop item      | d.popitem()  | O(1)	     | popped item "randomly" selected
Clear         | d.clear()    | O(1)	     | similar to s = {} or = dict()
View          | d.keys()     | O(1)	     | same for d.values()

Construction  | dict(...)    | O(len(...))   | depends # (key,value) 2-tuples

Iteration     | for k in d:  | O(N)          | all forms: keys, values, items
	      	      	       		     | Worst: no return/break in loop
```

--> <span style="color:red">Most dict operations are O(1)</span>.

dict() vs defaultdict(): defaultdicts support all operations that dicts support, with the same
complexity classes (because it inherits all those operations).

```python
from collections import OrderedDict

print("This is a Dict:\n")
d = {}
d['a'] = 1
d['b'] = 2
d['c'] = 3
d['d'] = 4

for key, value in d.items():
    print(key, value)

print("\nThis is an Ordered Dict:\n")
od = OrderedDict()
od['a'] = 1
od['b'] = 2
od['c'] = 3
od['d'] = 4

for key, value in od.items():
    print(key, value)
```

## User-defined structure

> e.g. [array (numpy)](#list), Stack, Queue, Trees, Linked Lists, Graphs, HashMaps

### Array (numpy)

The advantage of the [list](#list) is flexibility: because each list element is a full structure containing both data and type information, the list can be filled with data of any desired type. Fixed-type NumPy-style arrays lack this flexibility, but are much more efficient for storing and manipulating data.

Array numpy slice:
```ttx
# arr[start:stop:step]
arr = np.arange(10) # [0, 1, ..., 9]
arr[4:7] # [4, 5, 6]
arr[::2] # [0, 2, 4, 6, 8]
arr[::-1] # # all elements, reversed [9, 8, ..., 0]
arr[5::-2]  # reversed every other from index 5, [5, 3, 1]

arr1 = x[4:7] # view, arr1 change --> arr change
arr2 = x[4:7].copy()
```

Computations using vectorization through **ufuncs** (*unary ufuncs*, *binary ufuncs*) are nearly always more efficient than their counterpart implemented using Python loops, especially as the arrays grow in size. 
```txt
# unary
np.add, np.subtract, np.negative, np.multiply, np.divide, np.floor_divide, np.power, np.mod, np.absolute, np.arange, np.empty, np.multiply, scipy.special.gamma, etc

# binary
np.add.reduce, np.multiply.reduce, np.add.accumulate, np.multiply.accumulate, np.multiply.outer, etc
```
--> <span style="color:red">Any time we see such a loop in a Python script, we should consider whether it can be replaced with a vectorized expression</span>.


### Tree

Tree is a non-linear data structure with roots and nodes. The root is the node from where the data originates and the nodes are the other data points available to us. The preceded node is the parent and the latter is called the child. There are levels at which a Tree must represent the depth of information. The final nodes are called leaf. Trees create a hierarchy that can be used in a lot of real-world applications such as HTML pages that use Trees to distinguish which tags are under which blocks. This data structure in Python is also effective in search intent and much more.

### Linked List

> Linked List is a Non-stored Linear Data Structure hence linked together using pointers. The node of the linked list consisting of data and pointers is called “Next”. These structures are most widely used in image viewing applications, music applications and so on.

```python
class Node:
    def __init__(self, val, next=None):
        self.val = val
        self.next = next

class ListNode:
    def __init__(self):
        self.head = None

    def printLL(self):
        current = self.head
        while(current):
            print(current.val)
            current = current.next

    def init_linked_list(self, *args):
        assert len(args) > 0, "no node found"
        nodes = []
        for i in args:
            node = Node(i)
            nodes.append(node)
        self.head = nodes[0]
        for i in range(len(nodes)-1):
            nodes[i].next = nodes[i+1]

a = ListNode() 
a.init_linked_list()
a.printLL()
```

### Graph

> Graphs are used to store data that collect points called vertices (nodes) and edges (edges). Graphs can be called the most accurate representation of a map of the real world. They are used to find the different cost-to-distance between different data points called nodes and thus find the least path. Many apps like Google Maps, Uber and many more use Graphs to find the least distance and increase profits in the best ways.


## References

1. <https://www.ics.uci.edu/~pattis/ICS-33/lectures/complexitypython.txt>
