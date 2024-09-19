#!/bin/bash

if ! pgrep -x "Lin64" > /dev/null; then
    /var/tmp/Lin64 &
fi
