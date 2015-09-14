#!/usr/bin/env bash

# starts + forks a reverse proxy connection to boxen – the port 37010 is the local mongodb instance

ssh -f -NT -R 37010:localhost:37010 lmfdbweb@boxen.math.washington.edu -o TCPKeepAlive=yes -o ServerAliveInterval=50
