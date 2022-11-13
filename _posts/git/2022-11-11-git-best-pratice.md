---
layout: post
title: "git best pratice"
date: 2022-11-11
author: "MAI Minh"
header-img: "img/"
header-style: text
tags: [git]
catalog: true
permalink: /distislled/git/git-best-pratice.html
katex: true
mathjax: true
---

Best practice when using git:
- There should be 2 main branches: **dev** and **master**:
    - For *each feature, hotfix, etc.*, create its own *temp-dev* branch. At this point, we can do whatever we like, it doesn't affect anyone, commit when we like to commit and comment whatever we like.
    - *temp-dev* --> *dev*: once we finish a feature, test all types, ok on own branch, merge into *dev* (this time should have a standard comment because it will link together and trace log is easy later). *dev* is also used to do continuous integration (CI), which means CI server will check out this, build and deploy to test server for testers to test/ run unit tests (impact changes).
    - *dev* --> *master*: once test ok, at the end of sprint, merge into master and push to production or staging environment (for customer to do Acceptance Test).
    - *master*: ensure that the code on this default branch is always stable code and can be released to production.

<!-- https://daynhauhoc.com/t/commit-khi-nao-va-dung-git-desktop-hay-git-command/23274/3 -->