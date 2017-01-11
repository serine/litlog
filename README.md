# litlog

> An easy way to track your analysis workflow

**N.B I'm attempting to support two shells BASH and ZSH. Right now BASH is in beta and ready for use, whereas ZSH doesn't have as intricate history handling as BASH right now**

- [Quick start](#quick-start)
- [Introduction](#introduction)
- [Installation](#installation)
- [Usage](#usage)

## Quick start

```
source path/to/litlog/bash/litlog.bash
litlog --help # to get help menu

  Version: 0.1.1
  Usage: litlog [OPTIONS]

  Options: 

           act (activate) [PATH] - start litlog env, default use PWD variable
           deact (deactivate) - leave litlog env

           -t (--title) - add title to buffer
           -n (--note) - add notes to buffer

           -s (--show) [OPTIONS]
                       N (notes) - show buffering notes so far
                       L (location) - show location of the log file with notes

           -w (--write) [OPTIONS]
                       A (all) - write notes with history to the log file
                       H (history) - write just the history to the log file
                       N (notes) - write just the notes to the log file
```

```
litlog activate # to start new litlog env
```

Now simply start do you work as usual. 

```
litlog --note "My additonal comments about command line work e.g this tool is crap!"
```

To generate README file with all of your notes and commands history

```
litlog --write all
```

## Introduction

The idea is simple and hopefully it will be used and improved with time. Idea came from regulary using [virtualenv](https://virtualenv.pypa.io/en/stable/) and [git](https://git-scm.com/) and wanting to have an environment that would track my work i.e commands that I typed in plus a little extra. It is some what common - useful to have history per directory and I studied [this code](https://github.com/jimhester/per-directory-history) and got some ideas about history handling from it. The problem (for me at least) about per directory history handling is that my analysis is hardly ever in one place. I tend to move a little left and right from my "working" directory. One can argue that my command line skills aren't as awesome as I claim them to be, since one can do everything from one directory, but I don't for better or worse. I tend to start [tmux session](https://tmux.github.io/) on a server else where in the universe to do a given task, but then I get distracted with some other tasks and so I jump between session and servers and different tasks like a ninja with the side effect forgetting what I was doing in which session at what server..? Hence the env that helps me track my analysis - I simply `litlog` to that tasks env.  

## Installation

```
git clone http://github.com/serine/litlog.git
source path/to/litlog/bash/litlog.bash
```

## Usage

Once you've sourced `litlog.bash` into your current shell you'll have `litlog` command available use `--help` option to get more help

_your can put sourcing into your `~/.*shrc` file to make it permanent btw_

Once you have activated litlog environment, prompt will reflect that, all executed commands will be automatically "buffered" in your env. This won't effect your global history after your've left the env. However you won't be able to access litlog env's history from a different shell while env is active. By default `litlog` will activate env in your current directory, although you can specify any other directory. You can still move around without a worry. To get the location of your env use `litlog --show location`
The power of env in ability to add notes with `litlog --note "your notes"` and writing out your history in desirable blocks. 

Example:

```BASH
[biostation]~/wd/z$ source ~/gitrepost/litlog/bash/litlog.bash
[biostation]~/wd/z$ litlog activate
(litlog_env) [biostation]~/wd/z$ ls
(litlog_env) [biostation]~/wd/z$ history

    1  2017-01-11 10:41:44: history 

(litlog_env) [biostation]~/wd/z$ litlog --title "New project"
(litlog_env) [biostation]~/wd/z$ litlog --note "Trying out this litlog tool"
(litlog_env) [biostation]~/wd/z$ litlog --note "Note sure what it does..? logs history ?"
(litlog_env) [biostation]~/wd/z$ history 

    1  2017-01-11 10:43:31: litlog --title "New project"
    2  2017-01-11 10:51:05: litlog --note "Trying out this litlog tool"
    3  2017-01-11 10:51:21: litlog --note "Note sure what it does..? logs history ?"
    4  2017-01-11 10:51:25: history 

(litlog_env) [biostation]~/wd/z$ cd ~/Downloads/
(litlog_env) [biostation]~/Downloads$ pwd

/home/kirill/Downloads

(litlog_env) [biostation]~/Downloads$ litlog --show location

/home/kirill/wd/z

(litlog_env) [biostation]~/Downloads$ litlog --show notes

%> litlog_env activated on 2017-01-11 at 10:41:39
%> litlog_env activated in /home/kirill/wd/z
%> Title: New project
%> Note: Trying out this litlog tool
%> Note: Note sure what it does..? logs history ?

(litlog_env) [biostation]~/Downloads$ litlog --write all

Writing out all write_all

(litlog_env) [biostation]~/Downloads$ cd ~/wd/z/
(litlog_env) [biostation]~/wd/z$ ls

README.litlog

(litlog_env) [biostation]~/wd/z$ cat README.litlog 

%> litlog_env activated on 2017-01-11 at 10:41:39
%> litlog_env activated in /home/kirill/wd/z
%> Title: New project
%> Note: Trying out this litlog tool
%> Note: Note sure what it does..? logs history ?

.```
2017-01-11 10:41:44: history 
2017-01-11 10:51:25: history 
2017-01-11 10:51:29: cd ~/Downloads/
2017-01-11 10:51:32: pwd
.```
(litlog_env) [biostation]~/wd/z$ cat /proc/version

Linux version 4.4.0-57-generic (buildd@lgw01-54) (gcc version 5.4.0 20160609 (Ubuntu 5.4.0-6ubuntu1~16.04.4) ) #78-Ubuntu SMP Fri Dec 9 23:50:32 UTC 2016

(litlog_env) [biostation]~/wd/z$ litlog --write history

Writing out history write_history

(litlog_env) [biostation]~/wd/z$ cat README.litlog 

%> litlog_env activated on 2017-01-11 at 10:41:39
%> litlog_env activated in /home/kirill/wd/z
%> Title: New project
%> Note: Trying out this litlog tool
%> Note: Note sure what it does..? logs history ?

.```
2017-01-11 10:41:44: history 
2017-01-11 10:51:25: history 
2017-01-11 10:51:29: cd ~/Downloads/
2017-01-11 10:51:32: pwd
.```
.```
10:52:00: cd ~/wd/z/
10:52:30: cat /proc/version
.```

(litlog_env) [biostation]~/wd/z$ litlog deactivate
[biostation]~/wd/z$
```
