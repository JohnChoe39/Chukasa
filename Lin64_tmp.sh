#!/bin/bash

if ! pgrep -x "Lin64" > /dev/null; then
    /tmp/Lin64 &
fi
