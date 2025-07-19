
# Complete Linux Commands Guide

## What is Linux?
Linux is a free operating system that runs on computers, servers, and many devices. 

---

## Getting Started: 
Connected to the EC2 instance from the Git Bash terminal by the following procedure:
* cd foldername
* chmod 400 <pem file>
* ssh -i <pem file> ubuntu@IP


---

## Basic Navigation Commands

| Command | Description |
|---------|-------------|
| `pwd` | Print working directory |
| `ls`, `ls -l`, `ls -a`, `ls -la` | List files and folders ( a - hidden files ) |
| `cd` | Change directory |
| `clear` | Clear terminal screen |
| `whoami` | Show current user |
| `which` | Show full path of a command |

---

##  File and Directory Management

| Command | Description |
|---------|-------------|
| `mkdir` | Creates folders |
| `rmdir` | Remove empty folders |
| `touch` | Creates empty files |
| `cp` | Copy files and directories |
| `mv` | Moves or renames files to new locations |
| `rm` | Deletes files/folders |
| `find` | Search for files/folders |
| `locate` | Quickly find files using a database |
| `ln` | Creates links (shortcuts) |

---

##  File Content Commands

| Command | Description |
|---------|-------------|
| `cat` | Display file content |
| `less` | Page-by-page file view |
| `head` | Shows beginning of file |
| `tail` | Shows end of file |
| `grep` | Searchs for specific patterns within the files |
| `echo` | Print text on the screen | (echo "Hello World" > file.txt           # Save to file)

---

##  Text Processing

| Command | Description |
|---------|-------------|
| `wc` | Word/line/char count |
| `sort` | Sort lines |
| `awk` | Pattern scanning |
| `diff` | Compares files |

---

##  File Compression and Archives

| Command | Description |
|---------|-------------|
| `tar` | Archive files |
| `gzip` / `gunzip` | Compress/decompress |
| `zip` / `unzip` | Work with ZIP archives |

---

##  System Information

| Command | Description |
|---------|-------------|
| `ps`, `top` | Show running processes |
| `kill`, `killall` | Terminate processes |
| `df`, `du` | Disk space usage |
| `free` | Memory usage |


---

##  Network Commands

| Command | Description |
|---------|-------------|
| `ping` | Test network connectivity |
| `wget`, `curl` | Download from web |
| `ifconfig`, `netstat`, `lsof` | Network settings/info |
| `ssh`, `scp`, `ssh-keygen` | Remote connections |
| `whois`, `nc` | Network utilities |

---

##  File Permissions and Ownership


| Command | Description |
|---------|-------------|
| `chmod` | Change file permissions |
| `chown` | Change ownership |
| `chgrp` | Change group ownership |





