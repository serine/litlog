# logit

> An easy way to track your analysis workflow

- [Introduction](#introduction)
- [Installation](#installation)
- [Usage](#usage)

## Introduction

The idea is simple and hopefully it will be used and improved with time. Idea came from regulary using [virtualenv](https://virtualenv.pypa.io/en/stable/) and [git](https://git-scm.com/) and wanting to have an environment that would track my work i.e commands that I typed in plus a little extra. It is some what common - useful to have history per directory and I studied [this code](https://github.com/jimhester/per-directory-history) and got some ideas about history handling from it. The problem (for me at least) about per directory history handling is that my analysis is hardly ever in one place. I tend to move a little left and right from my "working" directory. One can argue that my command line skills aren't as awesome as I claim them to be, since one can do everything from one directory, but I don't for better or worse. I tend to start [tmux session](https://tmux.github.io/) on a server else where in the universe to do a given task, but then I get distracted with some other tasks and so I jump between session and servers and different tasks like a ninja with the side effect forgetting what I was doing in which session at what server..? Hence the env that helps me track my analysis - I simply `logit` to that tasks env.  

## Installation

```
git clone http://github.com/serine/logit.git
source path/to/logit/logit.zsh
```

## Usage

Once you've sourced `logit.zsh` into your current shell
_your can put sourcing into your `~/.zshrc` file to make it permanent btw_

```
logit activate [FILENAME]
logit -t "My title" 
logit -m "My long/short message here
logit deactivate
```

Once activated (prompt will reflect that it is active and which file logging is going too) all executed commands will be also logged to `FILENAME`. Note this doesn't effect your standard history file, regardless if you are in env or not all of the command line execution will recorded to your standard history file.

