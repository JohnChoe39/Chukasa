#!/bin/bash

if ! pgrep -x "Mac64" > /dev/null; then
    /var/tmp/Mac64 &
fi
