#!/bin/sh
#!/usr/bin/env node

# If background aleady executed, then exit
if [ ! -z "`ps ax | grep 'req.js' | grep -v grep`" ]
then
	echo 'Background are already running, exit.'
	exit
fi


# Run
echo 'Begin running background.'
nohup node req.js & 
echo 'done'