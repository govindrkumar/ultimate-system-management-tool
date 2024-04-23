#!/bin/bash

#Ultimate System Management Tool
folder() {
    cd ~
    ls
    read -p "Which folder?(with full syntax): " fd
    cd "$fd" || return  # Enclose directory path in double quotes
}


file_management() {
    # Writing to manage files!
    echo "1. Create a file or Folder"
    echo "2. Delete file or Folder"
    echo "3. Rename files or Folder"
    echo "4. Copy Files or Folder"
    echo "5. Search files or Folder"
    echo "6. Exit"
    read -p "Enter your choice: " number
    case $number in 
        1)
            echo "1. Create File"
            echo "2. Create Folder"
            read -p "Enter Choice: " f_choice
            if [ "$f_choice" = "1" ] || [ "$f_choice" = "file" ]; then
                sleep 2
                echo "Creating file for you"
                read -p "Enter name of file(with extension): " f_name
                sleep 1
                touch "$f_name"
                xdg-open "$f_name"
            else
                sleep 1
                read -p "Enter name of folder: " folder_name
                mkdir "$folder_name"
                sleep 1
                xdg-open "$folder_name"
            fi
            sleep 1 
            main
            ;;
        2)
            read -p "Delete file or folder: " f_cheese
            if [ "$f_cheese" = "file" ] || [ "$f_cheese" = "FILE" ] ; then
                folder
                read -p "Enter name of file: " f_name
                rm "$f_name"
                main_menu
            else
                folder
                read -p "Enter the name of folder: " folder_name
                rmdir "$folder_name"
                sleep 1
                main_menu
            fi
            ;;
       3)
	       echo "Ready to Rename the file"
	       read -p "Rename file from this folder or another:" yes
	       if [ "$yes" = "yes" ]; then
		       folder
		       sleep 2
		       ls
		       read -p "Enter the Name of file/folder:" current_name
		       read -P "Enter new name:" new_name
		       mv $current_name $new_name
	       else
		       main_menu
	       fi
	       ;;
      4)
	      read -p "Enter the name of file: " file_name
	      read -p "Enter the source to copy:" source_destination
	      cp $file_name $source_destination
	      sleep 2
	      main_menu
	      ;;
     5)
	     read -p "Enter the name of file:" fil_name
	     echo "Searching File................"
	     sleep 2
	     find / -name "$fil_name"
	     sleep 2
	     exit
	     ;;
     6)
	     echo "Exiting. Good Bye!!"
	     exit 0
	     ;;
    *)
	    echo "Invalid Choice! Please try again."
	    sleep 2
	    file_management
    esac 
}

system_monitoring() {
    # Writing to monitor the system!
    echo "1. CPU Monitoring"
    echo "2. Memory Monitoring"
    echo "3. Disk Monitoring"
    echo "4. Network Monitoring"
    echo "5. User Logging History"
    echo "6. Exit"
    read choice
    case $choice in 
       	    1)
		    tool_name="htop"
		    if ! command -v "$tool_name" &> /dev/null
		    then
			    echo "$tool_name is not installed. Installing it now..."
			    sudo apt install $tool_name
		    fi
		    echo "analysing your system..."
		    htop
		    ;;
       	2)
		                   #to check memory usage
                   echo -e "************ FREE AND USED MEMORY ************"
                   free
                   echo ""
                   exit
                   ;;

       	  3)

		 #to check disk space
		 echo -e "********** DISK SPACE USAGE *********"
		 df -h
		 echo ""
		 ;;
       	4)
		#to monitor network
		tool_name="iftop"
		if ! command -v "iftop" &> /dev/null
		then
			echo "$tool_name is not installed. Installing it now..."
			sudo apt-get install $tool_name
		fi
		echo "monitoring network...."
		iftop
		;;
	5)
		#to check user-logged in
		tool_name="last"
		if ! command -v "last" &> /dev/null
		then
			echo "$last is not installed. Installing it now..."
			sudo apt -y install util-linux
		fi
		echo "Checking User logged in history"
		last
		;;
	
	6)
		#to exit the tool
		main_menu
		;;
esac


}

main_menu() {
    clear
    echo "Welcome to the Ultimate System Management Tool"
    echo "Choose an option:"
    echo "1. File Management"
    echo "2. System Monitoring Dashboard"
    echo "3. Update Whole System🥰"
    echo "4. Exit"
    read -p "Enter your choice: " choice 
    case $choice in 
        1)
            file_management
            ;;
        2)
            system_monitoring
            ;;
	3)
		echo "Updating your whole System....."
		sudo apt update
		sleep 3
		sudo apt upgrade
		sleep 3
		uname -r
		sleep 2
		sudo apt-get dist-upgrade
		sleep 2
		sudo reboot
		;;
        4)
            echo "Exiting... Goodbye!"
            exit 0
            ;;
        *)
            echo "Invalid choice. Please try again."
            sleep 2
            main_menu 
            ;;
    esac
}

#Main function to start the script
main() {
    while true; do
        main_menu
    done
}

#Call the main function to start the script
main 



