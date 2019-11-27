if [ -f /home/arch/.logincheck ]; then
	echo "logged in as root"
else
	neofetch
	su arch
	exit 0
fi
