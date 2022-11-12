---
layout: post
title: "git commit message"
subtitle: "Rules to write commit message"
date: 2022-11-11
author: "MAI Minh"
header-img: "img/aditya-vyas-EPmJtn_lYs0-unsplash.jpg"
header-style: text
tags: [git]
catalog: true
permalink: /distilled/git/git-commit-message.html
katex: true
mathjax: true
---

[ds](/test/minh.html)

[ds](../../../test/minh.html)

> Writing a helpful msg makes it easier to work well in the team and check the git log (history) later

## Commit structure

```txt
git commit -m "<type>[optional scope]: <description> [optionals]"
```

### type and description

```txt
<type>[optional scope]: <description>
```

e.g.:
```txt
feat(lang): add vietnamese language
docs: correct spelling of CHANGELOG
```

- **`<type>`**:
    - **fix**: to fix bug
    - **feat (feature)**: to implement a new function
    - **refactor**: to clean up the code, eliminate code smells, without changing existing functionality
    - **docs**: to add/ modify the project's document
    - **style**: to make changes to the project's UI without affecting the logic
    - **perf**: to improve project performance (e.g.: remove duplicate query, etc.)
    - **vendor**: to perform version updates for packages and dependencies that the project is using
    - **chore**: to add minor changes in code (e.g.: text changes)
- `[optional scope]`: sphere of influence (as a noun)

- **description**: a brief, general description of the changes made
    
### optionals

> It is optional, but is used when details are needed

```txt
[optional body] [optional footer(s)]
```

- body:
    - divide description 1 page (blank line))
    - Additional detailed description to the above description of the changes made
    - Unlimited number of lines and not necessarily 1 format (free-form)
- footer(s):
    - behind the body (if there is a body) and separated by a blank line)
    - contains extended pull request information such as a list of reviewers, links/id's of related pull requests.
- **BREAKING CHANGE**:
    - if the code change in your pull request makes a major change that makes it no longer compatible with the previous version --> **BREAKING CHANGE**
    - by default **BREAKING CHANGE:** in footer or **!** after type/scope or use case 2

## when commit

- Each commit should have only one responsibility: Single Responsibility (**S** in **SOLID**): is a basic principle in software design (Creating Git commit is one of many other situations we can apply this principle)
- Each commit should only save small, directly related changes: instead of creating a commit with a lot of changes (hundreds of lines of code and dozens of files changed), we should split into many small commits.
- Avoid committing unnecessary changes, or should not be saved


## References
1. [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/?fbclid=IwAR1XtGOTAJk-w8aEq3v983ooN1jNsrspzLJXn-kY3xZmqWkOxbIPBs7bgTc)