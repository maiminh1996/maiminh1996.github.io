---
layout: post
title: "git fuse commit"
subtitle: "This is a subtitle"
date: 2022-11-11
author: "MAI Minh"
header-img: "img/"
header-style: text
tags: [git]
catalog: true
permalink: /distilled/git/git-fuse-commit.html
katex: true
mathjax: true
---


## Gop commit
bat dau voi github viblo.asia

`git rebase -i <id_commit_end> || git rebase -i HEAD~<index>` 
- <id_commit_end>: la id cua commit cuoi cung trong nhom can gop
- <index>: so commit can gop. Sau do cua so lam viec hien len, ta co cac lua chon **pick | squash | fixup** cac commit truoc khi save

Sau do kiem tra lai bang lenh `git log --oneline` xem commit da duoc gop thanh cong hay chua
