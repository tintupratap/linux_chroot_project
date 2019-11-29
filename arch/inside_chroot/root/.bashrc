#!/usr/bin/bash
if [ -f /home/arch/.logincheck ]; then
	echo "logged in as root"
else
	neofetch
	echo "LOGGED_IN"> /home/arch/.logincheck
	su arch
	rm -rf /home/arch/.logincheck
	exit 0
fi
