#!/bin/bash

# MacOS Command Line Encrption Utility


#set log location
LOG=~/.scripts/log/encrypt.log

#set filename varible
original_file=$1

#timestamp function
timestamp() {
     date +"%Y-%m-%d:%H:%M:%S"
}

#write initiaion message to log
printf "\n$(timestamp) - Encryption app started\n" >> $LOG

#file encryption function
encrypt_file() {
	
	#check if user provided a filename or if the specified file exisits
	echo "$(timestamp) - Checking if Input File was Specified" >> $LOG
	if [ -z "$original_file" -o ! -f "$original_file" ]
	   then
	       #write error to log, notify user and exit
	       printf "$(timestamp) - "  >> $LOG
	       printf "Input File Not Specified Or Doesn't Exist.  Exiting...\n" | tee -a $LOG
	       exit
	fi
	#append .encrypted to the output filename
	output_file=$original_file.encrypted
	
	#check to see if output file with the same name already exisits to prevent overwriting
	if [ -f "$output_file" ] 
	  then 
	     #write error to log, notify user that the file already exists and exit
	     printf "$(timestamp) - " >> $LOG
	     printf "The output file already exisits.  Exiting \n" | tee -a $LOG
	     printf "$output_file \n"
	     exit	
	fi
	
	#notify user of attempt and write to log
	echo "$(timestamp) - Attempting to encrypt file" >> $LOG
	echo "Encrypting $original_file using AES-256-CBC..."
        #encrypt the file
	openssl enc -aes-256-cbc -e -in "$original_file" -out "$output_file"
	
	#write sucess message to log
	echo "$(timestamp) - File Successfully Encrypted!" >> $LOG
	echo "File Output: "$output_file
}

encrypt_file
