---
layout: post
title: "git Commit Message"
subtitle: "Guidelines for Creating Clear and Helpful Commit Messages in Team Collaboration"
date: 2022-11-11
author: "MAI Minh"
header-img: "img/"
header-style: text
tags: [git]
catalog: true
permalink: /distilled/git/git-commit-message.html
# katex: true
mathjax: true
---

### Introduction

Writing good commit messages is an essential part of collaborating on code with a team or contributing to an open-source project. A clear and informative message helps team members understand what changes were made, why they were made, and when they were made. It also helps when looking back at the project's history. Here are some rules and guidelines for writing effective commit messages.

### Commit message structure

To write a good commit message, it is recommended to follow a specific structure. You can either use the command `git commit -m "<msg>"` to write a short message or use `git commit` to open an editor where you can write a longer message.

The recommended structure for a commit message is as follows:
```txt
<type>[optional scope]: <description> [optional body] [optional footer(s)]
```

#### Type and description


```txt
<type>[optional scope]: <description>
```
For example:
```txt
feat(lang): add vietnamese language
docs: correct spelling of CHANGELOG
```

The **type** field describes the type of change that was made. Here are some examples of types:
- **fix**: fixing a bug
- **feat (feature)**: adding a new feature
- **refactor**: cleaning up the code, eliminating code smells without changing existing functionality
- **docs**: adding or modifying the project's documentation
- **style**: making changes to the project's UI without affecting the logic
- **perf**: to improve project performance (e.g.: remove duplicate query, etc.)
- **vendor**: performing version updates for packages and dependencies that the project is using
- **chore**: making minor changes to the code (e.g., text changes)

The **optional scope** is a sphere of influence (as a noun)

The **description** field is a brief, general description of the changes made.
#### Optionals

```txt
[optional body] [optional footer(s)]
```

The **body field** is an optional, more detailed description of the changes made. It should be separated from the description field by a blank line and can consist of an unlimited number of lines in a free-form format.

The **footer(s) field** contains extended pull request information, such as a list of reviewers or links/IDs of related pull requests. If the code change in your pull request makes a major change that makes it no longer compatible with the previous version, use **BREAKING CHANGE** in the footer. It should be separated from the body field by a blank line.

### Best practices

When committing, keep the following best practices in mind:
- Each commit should have only one responsibility: Single Responsibility (**S** in **SOLID**). It is a basic principle in software design, and creating a Git commit is one of many other situations where we can apply this principle.
- Each commit should only save small, directly related changes. Instead of creating a commit with a lot of changes (hundreds of lines of code and dozens of files changed), we should split them into many small commits.
- Avoid committing unnecessary changes or changes that should not be saved.

### Conclusion

By following these guidelines, you can help ensure that your commit messages are clear, informative, and easy to understand. For more information, you can also refer to the Conventional Commits specification.


### References
1. [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/?fbclid=IwAR1XtGOTAJk-w8aEq3v983ooN1jNsrspzLJXn-kY3xZmqWkOxbIPBs7bgTc)