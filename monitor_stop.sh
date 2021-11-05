#!/bin/sh

# Kill
echo 'Begin stop background.'
id=$(ps axuf | grep 'req.js' | grep -v 'grep' | awk '{print $2}')
kill $id
echo 'done'