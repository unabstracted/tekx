#!/bin/bash

function remote_exec {
	sshpass -p $MY_PE_PASSWORD ssh -o StrictHostKeyChecking=no -o GlobalKnownHostsFile=/dev/null -o UserKnownHostsFile=/dev/null nutanix@$MY_PE_HOST "$@"
}

function send_file {
	sshpass -p $MY_PE_PASSWORD scp -o StrictHostKeyChecking=no -o GlobalKnownHostsFile=/dev/null -o UserKnownHostsFile=/dev/null "$1" nutanix@$MY_PE_HOST:/home/nutanix/"$1"
}

function acli {
	remote_exec /usr/local/nutanix/bin/acli "$@"
}

function ncli {
	remote_exec /home/nutanix/prism/cli/ncli "$@"
}


for MY_LINE in `cat pocs.txt | grep -v ^#`
do
	set -f                      # avoid globbing (expansion of *).
	array=(${MY_LINE//|/ })
	MY_PE_HOST=${array[0]}
	MY_PE_PASSWORD=${array[1]}

	# Send a file
	send_file config.sh
	# Execute that file asynchroneously remotely (script keeps running on CVM in the background)
	remote_exec "MY_PE_PASSWORD=${MY_PE_PASSWORD} nohup bash /home/nutanix/config.sh >> config.log 2>&1 &"
done
