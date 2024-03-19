#!/bin/bash

if [ "$(id -u)" != "0" ]; then
	    echo "Error! This script must be run as root!"
	        exit 1
fi

#1
request_1(){
echo "1. Home directory:"
awk -F: '{print $6}' /etc/passwd
}

#2
request_2(){
echo "2. Usrnames:"
awk -F: '{print $1}' /etc/passwd
}

#3
request_3(){
echo "3. Number of users:"
awk -F: 'END {print NR}' /etc/passwd
}

#4
request_4(){
read -p "4. Enter username: " username
echo "Home directory for $username:"
awk -F: -v user="$username" '$1 == user {print $6}' /etc/passwd
}

#5
request_5(){
read -p "5. Enter first value of UID range: " first_value
read -p "Enter second value of UID range: " second_value
echo "Users with UID range $first_value-$second_value:"
awk -F: -v lower="$first_value" -v upper="$second_value" '$3 >= lower && $3 <= upper {print $1}' /etc/passwd
}

#6
request_6(){
echo "6. Users with standard shells (/bin/bash or /bin/sh):"
awk -F: '$7 == "/bin/bash" || $7 == "/bin/sh" {print $1}' /etc/passwd
}

#7
request_7(){
echo "7. Replacing '/' with '\' in /etc/passwd"
awk '{gsub("/", "\\", $0); print}' /etc/passwd > passwd_new
}

#8
request_8(){
echo "8. Private IP:"
hostname -I
}

#9
request_9(){
echo "9. Public IP:"
curl ifconfig.me
echo ""
}

#10
request_10(){
echo "10. Switching to user 'john':"
su -c "echo \$HOME" john
}

#11
request_11(){
echo "11. Home directory of current user:"
echo $HOME
}

request_1
request_2
request_3
request_4
request_5
request_6
request_7
request_8
request_9
request_10
request_11
