#!/bin/bash
# Script to add a user to Linux system

#if the user does not exist
if [ $(id -u) -eq 0 ]; then
        read -p "Enter username : " username
        read -s -p "Enter password : " password
        read -p "Sudo access [y/n] : " sudo
        egrep "^$username" /etc/passwd >/dev/null
        if [ $? -eq 0 ]; then
                echo "$username exists!"
                exit 1
        else
                pass=$(perl -e 'print crypt($ARGV[0], "password")' $password)
                #mkdir /home/$username
                #chown $username:$usernmae /home/$username
                useradd -m -p $pass $username -s /bin/bash -d /home/$username
                [ $? -eq 0 ] && echo "User has been added to system!" || echo "Failed to add a user!"
                userDir=/home/$username/.ssh
                mkdir $userDir
                cat /home/ubuntu/userkeys/$username.pub > $userDir/authorized_keys
                chown -R $username:$username /home/$username
                chmod 600 $userDir/*
                chmod 700 $userDir

                if [ $sudo = 'y' ]; then
                        echo "  $username ALL=(ALL) ALL" >> /etc/sudoers
                else
                        echo " sudo access not granted for $username"
                fi

                #chown $username:$usernmae /home/$username
        fi
else
        echo "Only root may add a user to the system"
        exit 2
fi