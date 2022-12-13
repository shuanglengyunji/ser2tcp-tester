#!/bin/bash

# TCP ECHO (PORT 2000)
socat -dd tcp-l:2000,fork exec:'/bin/cat' 1> /dev/null &

# SERIAL ECHO
socat -dd pty,raw,echo=0,link=/tmp/serial0 exec:'/bin/cat' 1> /dev/null &

# TCP (PORT 3000) <> Serial (/tmp/serial1) ECHO
socat -dd pty,raw,echo=0,link=/tmp/serial1 pty,raw,echo=0,link=/tmp/serial2 &
ser2net -C 3000:raw:0:/tmp/serial2:115200
