---
layout: post
title: "Disable gradient computation"
subtitle: "How to Freeze a Specific Layer to Update its Weights/Bias in PyTorch"
date: 2022-11-21
author: "MAI Minh"
header-img: "img/"
header-style: text
tags: pytorch deep-learning
catalog: true
# permalink: /distilled/pytorch/disable-gradient-computation.html
# katex: true
mathjax: true
disqus_comments: true
toc:
  sidebar: left
---


**Freezing layers** in deep learning refers to the practice of *fixing the weights of certain layers during the training process*. Typically, this is done in transfer learning scenarios, where we use a pre-trained model as a starting point for a new task. Freezing some layers can be useful in several ways:
- **Computational efficiency**: when we *freeze some layers, we don't need to compute their gradients during backpropagation*, which can save a significant amount of computation time and memory.
- **Preventing overfitting**: if we have a limited amount of training data, a deep model with many parameters can easily overfit to the training set. By freezing some of the layers, we *reduce the number of parameters that the model can learn*, which can help prevent overfitting.
- **Transfer learning**: in transfer learning scenarios, we can use *a pre-trained model that has already learned useful features from a large dataset*. By freezing some of the layers that have learned these features, we can use them as fixed feature extractors and only train the remaining layers for the new task.

In general, freezing layers in deep learning can be a useful technique for improving the efficiency, generalization, and accuracy of deep models, especially in transfer learning scenarios. This post will show how to freeze a specific layer in PyTorch.



### Setting requires_grad to False/True

To freeze a specific layer, we need to set `requires_grad = False/ True` for each parameter that we want to freeze/update. The `requires_grad` flag is a boolean that allows for fine-grained exclusion of subgraphs from gradient computation. By default, `requires_grad` is set to False for all parameters unless wrapped in a `nn.Parameter`.

Here's an example of how to set `requires_grad` to False for all parameters in the pretrained model. Firstly, we need to show model parameters name:

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

pretrained = torchvision.models.alexnet(pretrained=True)
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

And then set `requires_grad = False` to disable the gradient of specific parameters.
```python
for name, param in net.named_parameters():
    if 'pretrained' in name.split('.'): # params that match the "pretrained" pattern
        # params.requires_grad(False)
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

### Train and Evaluation Mode

When training the model, it's important to set it to train mode using `model.train()`. Similarly, during validation or testing, it's important to set it to evaluation mode using `model.eval()`. Some layers like [dropout](/distilled/glossary-ml.html#dropout) or [batch normalization](/distilled/glossary-ml.html#batchnorm) change state during the validation/testing phase compared to the training phase.

Here's an example of how to switch between training and evaluation modes in PyTorch:
```python
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
- `net.train()` sets the network to training mode. During training, the network will update its parameters based on the loss calculated during backpropagation. This means that the network will make use of techniques like dropout and batch normalization to prevent overfitting and improve generalization.
- `net.eval()` sets the network to evaluation mode. During evaluation, the network will not update its parameters and will instead use them to make predictions. This means that the network will not use dropout or batch normalization during evaluation to ensure consistent and accurate predictions.
- `torch.no_grad()` is used in conjunction with `net.eval()` to disable gradient tracking during evaluation. This can help to save memory and speed up computations by telling PyTorch not to compute gradients or store intermediate values during forward passes.

### Code Example

Here's an example of how to freeze a layer in a PyTorch model assuming the existence of trainLoader and testLoader, which are data loaders for the training and test sets, respectively.

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

# Create a pre-trained model
pretrained = torchvision.models.alexnet(pretrained=True)

# Create a new model
net = Net(pretrained_model=pretrained)

# Freeze all parameters in the pretrained model
for name, param in net.named_parameters():
    # print('params: \t{}'.format(name)) # Show model's parameters
    if 'pretrained' in name.split('.'):
        param.requires_grad = False

# Define the loss function and optimizer
criterion = nn.CrossEntropyLoss()
optimizer = torch.optim.Adam(net.parameters(), lr=0.001)

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

### Conclusion

In this post, we learned how to freeze a specific layer in PyTorch by setting `requires_grad` to False for each parameter we want to freeze. We also discussed the importance of switching between training and evaluation modes by using `.train()`/ `.eval()` functions PyTorch.

### References

1. <https://pytorch.org/docs/stable/notes/autograd.html#locally-disabling-gradient-computation>
2. <https://pytorch.org/docs/stable/generated/torch.nn.functional.dropout.html>
3. <https://pytorch.org/docs/stable/generated/torch.nn.BatchNorm2d.html>
