---
layout: post
title: "Disable gradient computation"
# subtitle: "This is a subtitle"
date: 2022-11-21
author: "MAI Minh"
header-img: "img/"
header-style: text
tags: [pytorch, deep learning]
catalog: true
permalink: /distilled/pytorch/disable-gradient-computation.html
# katex: true
mathjax: true
---
<b>Last modified: <script>document.write( document.lastModified );</script>

## Freeze a specific layer to update its weights/ bias

We need to set `requires_grad = False/ True` for each param to be enable to update:
- `requires_grad` is a flag, defaulting to false unless wrapped in a `nn.Parameter`, that allows for fine-grained exclusion of subgraphs from gradient computation.
- `param.requires_grad = False` is the same as `params.requires_grad(False)`.

It is also recommended to use `model.train()` when training and `model.eval()` when evaluating the model (validation/ testing). Some layers change state during validation/ testing phase compared to training phase:
- `torch.nn.functional.dropout(p=0.5)`: during training, **randomly zeroes** some of the elements of the input tensor with probability $p$ using samples from a Bernoulli distribution.
- `torch.nn.BatchNorm2d(C)`: `mean()`, `std()` calculated over [mini-batch](https://developers.google.com/machine-learning/glossary#mini-batch) $\gamma$ and $\beta$ are learnable parameter vectors of size C (where C is the input size). By default: $\gamma$=1, $\beta$=0. **During training this layer keeps running estimates of its computed mean and variance, which are then used for normalization during evaluation**.

$$
y = \frac{x - \mathrm{E}[x]}{\sqrt{\mathrm{Var}[x] + \epsilon}} *\gamma +\beta
$$

To show model's parameters:
```python
import torch
import torch.nn as nn
import torchvision

pretrained = torchvision.models.alexnet(pretrained=True)
class Net(nn.Module):
    def __init__(self, pretrained_model):
        super(Net, self).__init__()
        self.pretrained = pretrained_model
        self.add_layers = nn.Sequential(nn.Linear(1000, 100),
                                           nn.ReLU(),
                                           nn.Linear(100, 2))
        
    def forward(self, x):
        x = self.pretrained(x)
        x = self.add_layers(x)
        return x

net = Net(pretrained_model=pretrained)

for name, param in net.named_parameters():
    print('params: \t{}'.format(name))

# params: 	pretrained.features.0.weight
# params: 	pretrained.features.0.bias
# params: 	pretrained.features.3.weight
# params: 	pretrained.features.3.bias
# params: 	pretrained.features.6.weight
# params: 	pretrained.features.6.bias
# params: 	pretrained.features.8.weight
# params: 	pretrained.features.8.bias
# params: 	pretrained.features.10.weight
# params: 	pretrained.features.10.bias
# params: 	pretrained.classifier.1.weight
# params: 	pretrained.classifier.1.bias
# params: 	pretrained.classifier.4.weight
# params: 	pretrained.classifier.4.bias
# params: 	pretrained.classifier.6.weight
# params: 	pretrained.classifier.6.bias
# params: 	add_layers.0.weight
# params: 	add_layers.0.bias
# params: 	add_layers.2.weight
# params: 	add_layers.2.bias
```

To freeze all params in pretrained

```python
for name, param in net.named_parameters():
    if 'pretrained' in name.split('.'):
        param.requires_grad = False
    print('params: \t{}, \tgradient: {}'.format(name, param.requires_grad))

# params: 	pretrained.features.0.weight, 	gradient: False
# params: 	pretrained.features.0.bias, 	gradient: False
# params: 	pretrained.features.3.weight, 	gradient: False
# params: 	pretrained.features.3.bias, 	gradient: False
# params: 	pretrained.features.6.weight, 	gradient: False
# params: 	pretrained.features.6.bias, 	gradient: False
# params: 	pretrained.features.8.weight, 	gradient: False
# params: 	pretrained.features.8.bias, 	gradient: False
# params: 	pretrained.features.10.weight, 	gradient: False
# params: 	pretrained.features.10.bias, 	gradient: False
# params: 	pretrained.classifier.1.weight, 	gradient: False
# params: 	pretrained.classifier.1.bias, 	gradient: False
# params: 	pretrained.classifier.4.weight, 	gradient: False
# params: 	pretrained.classifier.4.bias, 	gradient: False
# params: 	pretrained.classifier.6.weight, 	gradient: False
# params: 	pretrained.classifier.6.bias, 	gradient: False
# params: 	add_layers.0.weight, 	gradient: True
# params: 	add_layers.0.bias, 	gradient: True
# params: 	add_layers.2.weight, 	gradient: True
# params: 	add_layers.2.bias, 	gradient: True
```

## References

1. <https://pytorch.org/docs/stable/notes/autograd.html#locally-disabling-gradient-computation>
2. <https://pytorch.org/docs/stable/generated/torch.nn.functional.dropout.html>
3. <https://pytorch.org/docs/stable/generated/torch.nn.BatchNorm2d.html>
