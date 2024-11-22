---
layout: post
title: "Good advice and tips"
subtitle: "From multiple sources"
date: 2022-12-04
author: "MAI Minh"
header-img: "img/"
header-style: text
tags: advice
catalog: true
# permalink: /distilled/good-advice-and-tips.html
# katex: true
mathjax: true
disqus_comments: true
toc:
  sidebar: left
---
<!-- <b>Last modified: <script>document.write( document.lastModified );</script> -->

## Scientific paper
Credit to [`@Michael_J_Black`](https://twitter.com/Michael_J_Black/status/1598957619301187584)
- In the LLM-science discussion, I see a common misconception that science is a thing you do and that writing about it is separate and can be automated. I’ve written over 300 scientific papers and can assure you that science writing can’t be separated from science doing. Why? 1/18
- Anyone who has taught knows the following is true. You think you understand something until you go to teach it. Explaining something to others reveals gaps in your understanding that you didn’t know you had. Well, writing a scientific paper is a form of teaching. 2/18
- Your paper is teaching your reader about your hypothesis, problem, method, the prior work in the field, your results, and what it all means for future work. When you write up your work and find it challenging, this is typically because you don’t yet fully understand it. 3/18
- The writing reveals what you don’t know. Years ago, Michal Irani gave me good advice. She said you can write the introduction to your paper long before the science is done and that this helps structure your thinking. 4/18
- Of course, you have to rewrite it once you know the outcome of your work but she’s right. You can tell the story before the ending is known. I am constantly training my students how to structure a story because doing so leads to good science. 5/18
- What’s the problem in the world? Why isn’t it solved? What's your key insight that lets you solve it when others couldn’t? Why is it novel? What’s your solution? Who’s your audience? What do they care about? What do they know? 6/18
- None of these questions are about grammar. None are about English proficiency. They're about “thinking proficiency”. They're about understanding your contribution and why it’s important. They help structure an argument that's logical. 7/18
- Use Grammarly, please. It's not cheating unless you’re taking a grammar test. By trying to write your story, you find the holes in your story. If you do this early, you have time to go back and let this drive your science. 8/18
- Because people often have trouble getting started writing, I tell them to make a talk instead. The idea of telling a story to a room full of people makes it easier to get the structure right. If you have a really great talk, turning it into a great paper is relatively easy. 9/18
- I have my students write a “shitty first draft”. All I care about is structure, logic, and story. We often sketch the figures and plots that we imagine on a whiteboard, take a photo, and put them in the paper. We build the whole structure before the work is done. 10/18
- I guarantee that this leads to better science and better papers than rushing to write up something after you finish all the experiments. The early writing process leads to you realizing that you are missing experiments. 11/18
- Most students would love for me to write their paper for them. They know I can do it faster. They also know that I’ll rewrite a lot of what they’ve written.  So why should they do it? Because, it will help them become good scientists. 12/18
- A good scientist has to be a good communicator. We don’t do science as a private activity. Imagine I structured all the papers and wrote them all and the students just coded and ran experiments. Or imagine an LLM did this. 13/18
- One of the hardest things I ask them to do is to come up with an “elevator pitch”. This requires distilling something huge and complex into a sentence. To do so, you really have to understand the core of your contribution. 14/18
- What about related work? Nobody reads that right? That could be automated, right? I think it's one of the most important parts of a paper for both the author and the field. 15/18
- I am often grappling with a sprawling literature and my job is to organize it in some way that provides insight. This may let others see the field in a new light and can lead them to new discoveries. 16/18
- I know that I’m fortunate. I’m a native English speaker, raised by literate parents, and the mechanics of writing come naturally. But I don’t care about grammar. I care about ideas, logic, and story. It’s your argument that matters. 17/18
- Summary: science thinking, writing, and doing are inseparable. Focus on story. Write early. Write a shitty first draft. And do yourself a favor: write it yourself. I promise that writing about your science will improve your science. 18/18

## Project meeting

Credit to [`Prof. Minh Hoai`](https://www3.cs.stonybrook.edu/~minhhoai/guideline/meeting.html)

Project meetings are when we discuss about our project. But I have multiple on-going projects, so it is very likely that I don't remember much about our previous meeting. In fact, my memory is so short-lived that I would forget about what we discussed the day after the meeting. Don't assume that I remember the goal, the roadmap, and the progress of the project. To get the most out of the meetings, you need to help me. You need to be organized and prepared. Here are some guidelines.

Keep a single document for all meetings:
- Each week, new content for each meeting must be added, and it should include:
    - your presentation during the meeting; notes of the discussion during the meetings;
    - a list of actionable items
- Use GoogleSlide or PPTX (stored on Google Drive) and give me and everyone in the project the permission to edit your document. You can also use GoogleDoc, but I strongly recommend slides.

Before the meeting:
- Prepare several slides to help you present during the meeting
- Use figures, tables, and graphs to show your idea, the architecture of your network, and the results.
- Draw the process diagram for the steps that you did or how the components of your method connect with each other. Trust me, this will be much clearer than saying I did this, that, and then or saying the output of A is fed into B and then C.

During the meeting:
- Start by reminding me about your project:
    - make sure I understand where we were and where we are heading to summarize the hypothesis and the main idea
    - Show the list of actionable items from the last meeting
- Present your slides:
    - Describe what you did and show the results
    - Don't just merely show the numerical values such as accuracy. You must interpret and analyze the results
- Note down the key points of our discussion
- Write down the list of actionable items

After the meeting:
- Add more details to the meeting notes, and complete the list of actionable items
- Convince yourself that you should do the items in the list of actionable items. Don't do them because I told you to do them. You must see the strong reasons why you should do them.

Templates:
- [example_project_meeting](https://docs.google.com/presentation/d/1zNAMMDwdRNPi2zJP2p27ydKesgFMDFwf3-azNLabxQ4/edit?usp=sharing)
- [example_detailed_project_meeting](https://docs.google.com/presentation/d/1txUYAsJUUBKnzIMJeqvcDdMWaBfcUElEi80hlhagHuk/edit?usp=sharing)

## Debugging 

Credit to [`Prof. Minh Hoai`](https://www3.cs.stonybrook.edu/~minhhoai/guideline/scientific_debug.html)

During a project meeting, you should report what you have done and the results that you achieve since the last meeting. Don't just show the boring numbers such as accuracy. You must interpret and analyze the results:
- It's great when you have **positive results** and your idea works. But, even in this case, you should temporarily set the excitment aside, doubt it, and **try to find another way to validate your results**. How can you convince me that there was no silly mistakes, e.g., not having independent train and test data? For example, can you validate your quantitative results with qualitiative results?
- If you **get negative results**, i.e., you implemented an idea but it performed worse than the method you hoped to beat. In this case, can you **analyze why**? **Before you implemented an idea, you must have a strong reason for why it would outperform the competing method, and that reason should be based on some assumption. Can you see now why your assumption was wrong**?

In my experience, you will get negative results 80% of the time. Don't be ashamed to report that "I made no progress this week", as long as it was not due to the lack of effort to do the work and analyze why it fails. 