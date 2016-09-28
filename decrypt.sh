#!/bin/bash

# MacOS Command Line Decrption Utility


#set log location
LOG=~/.scripts/log/encrypt.log

#set filename varible
original_file=$1
output_file=$2

#timestamp function
timestamp() {
     date +"%Y-%m-%d:%H:%M:%S"
}

#write initiaion message to log
printf "\n$(timestamp) - Decryption app started\n" >> $LOG

#file encryption function
decrypt_file() {
	
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
	#output=$original_file.encrypted
	
	#check to see if output file with the same name already exisits to prevent overwriting
	if [ -f "$output_file" ] 
	  then 
	     #write error to log, notify user that the file already exists and exit
	     printf "$(timestamp) - The output file already exisits.  Exiting \n" | tee -a $LOG
	     printf "$output_file \n"
	     exit	
	fi
	
	#notify user of attempt and write to log
	echo "$(timestamp) - Attempting to decrypt file" >> $LOG
	echo "Decrypting $original_file using AES-256-CBC..."
        #decrypt the file
	openssl enc -aes-256-cbc -d -in "$original_file" -out "$output_file"
	
	#write sucess message to log
	echo "$(timestamp) - File Successfully Decrypted!" >> $LOG
	echo "File Output: "$output_file
}

decrypt_file
