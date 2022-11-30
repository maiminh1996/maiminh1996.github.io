---
layout: post
title: "Loss function"
# subtitle: "This is a subtitle"
date: 2022-11-24
author: "MAI Minh"
header-img: "img/"
header-style: text
tags: [pytorch, deep learning, machine learning]
catalog: true
permalink: /distilled/loss-function.html
# katex: true
mathjax: true
---
<!-- <b>Last modified: <script>document.write( document.lastModified );</script> -->


Some basic loss defined in pytorch. Sometimes loss definition in `torch.nn` (`nn`) and `torch.nn.functional` (`F`) can confuse us.

Notes:
- regression: predict a real-value quantity
- classification: predict a probability (need a non-linear activation function)

## Negative Log Likelihood Loss

> [classification] It is useful to train a classification problem with C classes.

`nn.NLLLoss(input, target)` == `F.nll_loss()`
- input: (N, C), or $(N, C, d_{1}, d_{2}, ..., d_K)$ with $K \geq 1$ in the case of K-dimensional loss.
- target: (N), or $(N, d_{1}, d_{2}, ..., d_{K})$ with $K \geq 1$ in the case of K-dimensional loss.
- output: scalar. If reduction is none, then the same size as the target: (N), or $(N, d_{1}, d_{2}, ..., d_{K})$ with $K \geq 1$ in the case of K-dimensional loss.

```python
N, C = 3, 5
m = nn.LogSoftmax(dim=1)
loss = nn.NLLLoss()
# input is of size N x C = 3 x 5
input = torch.randn(N, C, requires_grad=True)
# each element in target has to have 0 <= value < C
target = torch.empty(N, dtype=torch.long).random_(0, C)
output = loss(m(input), target) # scalar
```

```python
# 2D loss example (used, for example, with image inputs)
N, C = 5, 4
loss = nn.NLLLoss()
data = torch.randn(N, 16, 10, 10) # (N, C, H, W)
conv = nn.Conv2d(16, C, (3, 3))
m = nn.LogSoftmax(dim=1) # dim -->
# each element in target has to have 0 <= value < C
target = torch.empty(N, 8, 8, dtype=torch.long).random_(0, C) # (N, 8, 8)
output = m(conv(data)) # (N, C, 8, 8)
l = loss(output, target) # scalar
```

```python
# loss example (used, for example, with pcl inputs)
N, L, C = 4, 10, 6
loss = nn.NLLLoss()
m = F.log_softmax(dim=-1)#, feature_transform
pcl = torch.randn(N, L, 3) # (N, L, 3), 3: x, y, z
fc1 = nn.Linear(3, 64)
fc2 = nn.Linear(64, C)
output = m(fc2(fc1(pcl))) # (N, L, C), m dim: -1 or 2
target = torch.empty(N, L, dtype=torch.long).random_(0, C) # (N, L)
target = target.view(-1) # (N*L)
output = output.view(-1, C) # (N*L, C)
l = loss(output, target) # scalar
```

<!-- ## poisson_nll_loss

> Poisson negative log likelihood loss. -->

## Cross Entropy Loss

> [classification] Cross Entropy Loss, also called logarithmic loss, log loss or logistic loss

$$
L_{CE} = - \sum_{i=1}^{n} t_{i}log(p_{i}),
$$

where, $t_{i}$ is the truth label and $p_{i}$ is the softmax probability for $i^{th}$ class.



`nn.CrossEntropyLoss(input, target)`<br>== `F.cross_entropy()` == `F.nll_loss(F.log_softmax(input, 1), target)`. <span style="color:red">In Pytorch, these criterion combines `log_softmax` and `nll_loss` in a single function</span>.
- input: (N, C), (N, C, H, W)
- target: (N) where each value is $0 \leq \text{targets}[i] \leq C-1$, or $(N, d_1, d_2, ..., d_K)$ where $K \geq 1$ for K-dimensional loss. 
- output: scalar. If reduction is none, then the same size as the target (N), or $(N, d_1, d_2, ..., d_K)$ with $K \geq 1$ in the case of K-dimensional loss.

```python
N, C = 16, 5

# Example of target with class indices
loss = nn.CrossEntropyLoss()
input = torch.randn(N, C, requires_grad=True)
target = torch.empty(N, dtype=torch.long).random_(C)
output = loss(input, target) # scalar

# Example of target with class probabilities
input = torch.randn(N, C, requires_grad=True)
target = torch.randn(N, C).softmax(dim=1)
output = loss(input, target)
```

## Binary Cross Entropy

> [classification] Cross Entropy Loss, also referred as Logarithmic loss

The problem is framed as predicting the likelihood of an example belonging to class one, e.g. the class that you assign the integer value 1, whereas the other class is assigned the value 0.

`nn.BCELoss(input, target)` == `F.binary_cross_entropy()`
- input: Tensor of arbitrary shape
- target: Tensor of the same shape as input

```python
input = torch.randn((3, 2), requires_grad=True)
target = torch.rand((3, 2), requires_grad=False)
loss = F.binary_cross_entropy(F.sigmoid(input), target)
```

Function that measures Binary Cross Entropy between target and output logits. This loss combines a `Sigmoid` layer and the `BCELoss` in one single

`nn.BCEWithLogitsLoss(input, target)` == `F.binary_cross_entropy_with_logits()`

```python
input = torch.randn((3, 2), requires_grad=True)
target = torch.rand((3, 2), requires_grad=False)
loss = nn.BCEWithLogitsLoss(input, target)
```

## Smooth L1 Loss

> [regression]

Function that uses a [squared term](#mse-loss) if the absolute element-wise error falls below $\beta$ (1 by default) and an [L1 term](#mae-loss) otherwise. It is less sensitive to outliers than the [MSELoss](#mse-loss) and in some cases prevents exploding gradients (e.g. see Fast R-CNN paper by Ross Girshick).

$$
L_{Smooth\ L1} = \frac{1}{n} \sum_{i} z_{i}
$$

where $z_{i}$ is given by:

$$
z_{i} =
\begin{cases}
0.5 (x_i - y_i)^2 / \beta, & \text{if } |x_i - y_i| < \beta \\
|x_i - y_i| - 0.5 * \beta, & \text{otherwise }
\end{cases}
$$

$x$ and $y$ arbitrary shapes with a total of $n$ elements each the sum operation still operates over all the elements, and divides by $n$.


`nn.SmoothL1Loss(input, target)` == `F.smooth_l1_loss()`
- input: (*)
- target: (*), same shape as the input.
- output: scalar. If reduction is 'none', then (*), same shape as the input.

```python
N, C = 16, 5

loss = nn.SmoothL1Loss() # default reduction='mean'
input = torch.randn(N, C, requires_grad=True)
target = torch.randn(N, C)
output = loss(input, target) # scalar
```

## MSE Loss

> [regression] Mean Squared Error (MSE) Loss, also called L2 norm

$$
L_{MSE} = \frac{1}{n}\sum_{i=1}^{n}\left ( Y_{i} - \hat{Y}_{i} \right )^{2}
$$

`nn.MSELoss(input, target)` == `F.mse_loss()`
- input: (N, *)
- target: (N, *)
- ouput: scalar

```python
N, C = 16, 5

loss = nn.MSELoss() # default reduction='mean'
input = torch.randn(N, C, requires_grad=True)
target = torch.randn(N, C)
output = loss(input, target) # scalar
# torch.square(input-target).mean()

# loss1 = nn.MSELoss(reduction='sum')
# output1 = loss1(input, target) # scalar
# torch.square(input-target).sum()
```

## L2 Loss

L2 loss is another name for [Mean Squared Error (MSE) Loss](#mse-loss).

## MAE Loss

> [regression] Mean Absolute Error (MAE) Loss, also called L1 norm

$$
L_{MAE} = \frac{1}{n}\sum_{i=1}^{n}\left | Y_{i} - \hat{Y}_{i}  \right |
$$

`nn.L1Loss(input, target)` == `F.l1_loss()` == `nn.L1Loss()`
- input: (N, *)
- target: (N, *)
- ouput: scalar

```python
N, C = 16, 5

loss = nn.L1Loss()
input = torch.randn(N, C, requires_grad=True)
target = torch.randn(N, C)
output = loss(input, target)
# torch.abs(input-target).mean()

# loss1 = nn.L1Loss(reduction='sum')
# output1 = loss1(input, target) # scalar
# torch.abs(input-target).sum()
```

## L1 Loss

L1 loss is another name for [Mean Absolute Error (MAE) Loss](#mae-loss).

## References

1. <https://pytorch.org/docs/stable/nn.functional.html#loss-functions>