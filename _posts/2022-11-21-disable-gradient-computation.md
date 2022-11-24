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

It is also recommended to use `model.train()` when training and `model.eval()` when evaluating the model (validation/ testing). Some layers like <a href="/distilled/glossary.html#dropout">dropout</a>, <a href="/distilled/glossary.html#batchnorm">batchnorm</a> change state during validation/ testing phase compared to training phase: 


```python
import torch
import torch.nn as nn
import torchvision

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
```
To show model's parameters:
```python
pretrained = torchvision.models.alexnet(pretrained=True)
net = Net(pretrained_model=pretrained)

optimizer = ...

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

# Training
net = net.train()
for data, target in enumerate(trainLoader):
    ...
    output = net(data)
    optimizer.zero_grad()
    loss_train = ...
    loss_train.backward()
    optimizer.step() 
# Validation
net.eval()    
with torch.no_grad():
    for data, target in enumerate(trainLoader):
        ...
        output = net(data)
        loss_val = ...
        acc_val = ...
```

## References

1. <https://pytorch.org/docs/stable/notes/autograd.html#locally-disabling-gradient-computation>
2. <https://pytorch.org/docs/stable/generated/torch.nn.functional.dropout.html>
3. <https://pytorch.org/docs/stable/generated/torch.nn.BatchNorm2d.html>
