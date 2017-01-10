# logit

> An easy way to track your analysis workflow

**N.B I'm attempting to support two shells BASH and ZSH. Right now BASH is in beta and ready for use, whereas ZSH doesn't have as intricate history handling as BASH right now**

- [Quick start](#quick-start)
- [Introduction](#introduction)
- [Installation](#installation)
- [Usage](#usage)

## Quick start

```
source path/to/logit/bash/logit.bash
logit --help # to get help menu

  Version: 0.1.1
  Usage: logit [OPTIONS]

  Options: 

           act (activate) [PATH] - start logit env, default use PWD variable
           deact (deactivate) - leave logit env

           -t (--title) - add title to buffer
           -n (--note) - add notes to buffer

           -s (--show) [OPTIONS]
                       T (text) - show buffering notes so far
                       L (location) - show location of the log file with notes

           -w (--write) [OPTIONS]
                       A (all) - write notes with history to the log file
                       H (history) - write just the history to the log file
                       N (notes) - write just the notes to the log file
```

```
logit activate # to start new logit env
```

Now simply start do you work as usual. 

```
logit --note "My additonal comments about command line work e.g this tool is crap!"
```

To generate README file with all of your notes and commands history

```
logit --write all
```

## Introduction

The idea is simple and hopefully it will be used and improved with time. Idea came from regulary using [virtualenv](https://virtualenv.pypa.io/en/stable/) and [git](https://git-scm.com/) and wanting to have an environment that would track my work i.e commands that I typed in plus a little extra. It is some what common - useful to have history per directory and I studied [this code](https://github.com/jimhester/per-directory-history) and got some ideas about history handling from it. The problem (for me at least) about per directory history handling is that my analysis is hardly ever in one place. I tend to move a little left and right from my "working" directory. One can argue that my command line skills aren't as awesome as I claim them to be, since one can do everything from one directory, but I don't for better or worse. I tend to start [tmux session](https://tmux.github.io/) on a server else where in the universe to do a given task, but then I get distracted with some other tasks and so I jump between session and servers and different tasks like a ninja with the side effect forgetting what I was doing in which session at what server..? Hence the env that helps me track my analysis - I simply `logit` to that tasks env.  

## Installation

```
git clone http://github.com/serine/logit.git
source path/to/logit/bash/logit.bash
```

## Usage

Once you've sourced `logit.bash` into your current shell you'll have `logit` command available use `--help` option to get more help

_your can put sourcing into your `~/.*shrc` file to make it permanent btw_

Once you have activated logit environment, prompt will reflect that, all executed commands will be automatically "buffered" in your env. This won't effect your global history after your've left the env. However you won't be able to access logit env's history from a different shell while env is active. By default `logit` will activate env in your current directory, although you can specify any other directory. You can still move around without a worry. To get the location of your env use `logit --show location`
The power of env in ability to add notes with `logit --note "your notes"` and writing out your history in desirable blocks. 

Example:

Start my env session

```
logit activate
```

```
logit --title "New project"
logit --note "This is test project to see how logit works"
```

```
[biostation]~/wd/z$ source ~/gitrepost/logit/bash/logit.bash                                                                                                   
[biostation]~/wd/z$ logit activate
(logit_env) [biostation]~/wd/z$ ls
(logit_env) [biostation]~/wd/z$ history 
    1  2017-01-11 10:41:44: history 
(logit_env) [biostation]~/wd/z$ logit --title "New project"
(logit_env) [biostation]~/wd/z$ logit --note "Trying out this logit tool"
(logit_env) [biostation]~/wd/z$ logit --note "Note sure what it does..? logs history ?"                                                                        
(logit_env) [biostation]~/wd/z$ history 
    1  2017-01-11 10:43:31: logit --title "New project"
    2  2017-01-11 10:51:05: logit --note "Trying out this logit tool"
    3  2017-01-11 10:51:21: logit --note "Note sure what it does..? logs history ?"
    4  2017-01-11 10:51:25: history 
(logit_env) [biostation]~/wd/z$ cd ~/Downloads/
(logit_env) [biostation]~/Downloads$ pwd
/home/kirill/Downloads
(logit_env) [biostation]~/Downloads$ logit --show location
/home/kirill/wd/z
(logit_env) [biostation]~/Downloads$ logit --show notes
%> logit_env activated on 2017-01-11 at 10:41:39
%> logit_env activated in /home/kirill/wd/z
%> Title: New project
%> Note: Trying out this logit tool
%> Note: Note sure what it does..? logs history ?
(logit_env) [biostation]~/Downloads$ logit --write all
Writing out all write_all
(logit_env) [biostation]~/Downloads$ cd ~/wd/z/
(logit_env) [biostation]~/wd/z$ ls
README.logit
(logit_env) [biostation]~/wd/z$ cat README.logit 
%> logit_env activated on 2017-01-11 at 10:41:39
%> logit_env activated in /home/kirill/wd/z
%> Title: New project
%> Note: Trying out this logit tool
%> Note: Note sure what it does..? logs history ?

```
2017-01-11 10:41:44: history 
2017-01-11 10:51:25: history 
2017-01-11 10:51:29: cd ~/Downloads/
2017-01-11 10:51:32: pwd
```
(logit_env) [biostation]~/wd/z$ cat /proc/version
Linux version 4.4.0-57-generic (buildd@lgw01-54) (gcc version 5.4.0 20160609 (Ubuntu 5.4.0-6ubuntu1~16.04.4) ) #78-Ubuntu SMP Fri Dec 9 23:50:32 UTC 2016
(logit_env) [biostation]~/wd/z$ logit --write history
Writing out history write_history
(logit_env) [biostation]~/wd/z$ cat README.logit 
%> logit_env activated on 2017-01-11 at 10:41:39
%> logit_env activated in /home/kirill/wd/z
%> Title: New project
%> Note: Trying out this logit tool
%> Note: Note sure what it does..? logs history ?

```
2017-01-11 10:41:44: history 
2017-01-11 10:51:25: history 
2017-01-11 10:51:29: cd ~/Downloads/
2017-01-11 10:51:32: pwd
```
```
10:52:00: cd ~/wd/z/
10:52:30: cat /proc/version
```
(logit_env) [biostation]~/wd/z$ logit deactivate
[biostation]~/wd/z$
```
