#!/bin/bash

killall -9 qs
qs -p "$XDG_CONFIG_HOME/quickshell" &

