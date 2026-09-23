---
date: 2026-09-20 00:00
title: Code Review in TestFlight
description: New App in TestFlight that wants to optimize your Code Reviews - try it out and send me your feedback.
shouldSkip: false
tags: app, macos, swift
---

## tl;dr

My new App [Code Review](/codereview) is available in [TestFlight](https://testflight.apple.com/join/bJQhUAFQ) – I would love to get your feedback! 😊

<p align="center">
<img src="/img/code-review-testflight-app.webp" width="100%"/>
</p>

## Time spent in code reviews

I work as a developer and see myself doing more and more Code Reviews.
On the one hand, colleagues are more productive, which results in more PRs from them.
On the other hand, my “engineering time” also shifted from *typing code myself* to *reviewing and adjusting some output of an agent*.
And this also results in *more code reviews*.

So we have these two processes which are quite similar:

- Reviewing a pull request (PR)
- Reviewing local code

In a PR you write a comment for someone else.
In a local code review, you write a todo for yourself or for an agent that picks it up later.

## Optimization

But still, I think this could be optimised:

I really love terminal tools like [LazyGit](https://github.com/jesseduffield/lazygit) because (if you know the shortcuts) they make you really fast in achieving a task.
But while LazyGit is really good at “making git stuff”, it does not really fit for PRs.
But one thing I wanted to reuse: shortcuts.

<p align="center">
<img src="/img/code-review-testflight-meme.jpg" width="66%"/>
</p>

I also like **platform-native UIs** and nice UX.
And I really tried to achieve that.

So these ideas combined let me start with CodeReview.
An intuitive and native UI with shortcuts so that your hands don’t have to leave the keyboard.

## Flow

You start by choosing a local repository with changes or a PR.
Afterwards you can switch between three modes:

- File mode
- Hunk mode
- Line mode

You can move up or deeper in the hierarchy by using the left or right arrow key (or `h` / `l`).
Switching files can be done using the up/down arrows (or `j` / `k`).

Depending on the mode, you stage (`SPACE`) a file, hunk, or line in a local repository.
Or mark it as viewed in a PR – the same way you do on GitHub.

When you're finished with the review, just hit `CMD` + `ENTER` to commit locally.
Or approve/reject/comment a GitHub PR.

There are several other shortcuts (see `?`) and a handy Xcode integration.
Just play with it and try it out. ☺️

A mockup of the UI can be found [here](/codereview).

I hope you want to give it a try and test it.
Every feedback is welcome.
Where does it help?
Is there something that could be improved?
I'd love to hear from you: [CodeReview@juliankahnert.de](mailto:CodeReview@juliankahnert.de)

*Written by a human 🤓*