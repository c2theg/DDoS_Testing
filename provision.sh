#!/bin/sh
clear
echo "
 _____             _         _    _          _                                   
|     |___ ___ ___| |_ ___ _| |  | |_ _ _   |_|                                  
|   --|  _| -_| .'|  _| -_| . |  | . | | |   _                                   
|_____|_| |___|__,|_| |___|___|  |___|_  |  |_|                                  
                                     |___|                                       
                                                                                 
 _____ _       _     _           _              _____    __    _____             
|     | |_ ___|_|___| |_ ___ ___| |_ ___ ___   |     |__|  |  |   __|___ ___ _ _ 
|   --|   |  _| |_ -|  _| . | . |   | -_|  _|  | | | |  |  |  |  |  |  _| .'| | |
|_____|_|_|_| |_|___|_| |___|  _|_|_|___|_|    |_|_|_|_____|  |_____|_| |__,|_  |
                            |_|                                             |___|
\r\n \r\n
Version:  0.6.13                             \r\n
Last Updated:  2/22/2020
\r\n \r\n
This is meant for Ubuntu 16.04+  \r\n \r\n"
#---------------------------------------------------------------------------------------------------------
if [ -s "update_attacks.sh" ]; then
	echo "Deleting old configs...  "
	rm install_gen_data.sh
	rm gen_data.sh
	rm update_attacks.sh
fi

echo "\r\n \r\n Downloading install_gen_data script.. "
wget -O "install_gen_data.sh" "https://raw.githubusercontent.com/c2theg/DDoS_Testing/master/install_gen_data.sh"

echo "\r\n \r\n Downloading Sample Data Generator.. "
wget -O "gen_data.sh" "https://raw.githubusercontent.com/c2theg/DDoS_Testing/master/gen_data.sh"

echo "\r\n \r\n Downloading Attack Script Updater "
wget -O "update_attacks.sh" "https://raw.githubusercontent.com/c2theg/DDoS_Testing/master/update_attacks.sh"

sudo chmod u+x *.sh

./update_attacks.sh

echo "DONE! \r\n "