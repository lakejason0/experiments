#!/bin/bash
unset $choice
unset $web
unset $exitstatus
unset $option
usage (){
  echo "Usage: toolbox command [parameter] "
  echo "upgrade - Run 'apt update' and 'apt upgrade'."
  echo "find [directory] [name] - Find files in the directory."
  echo "eng - Set Language to 'en-US'."
  echo "mail - Mail."
  echo "browser - Run 'w3m'."
  echo "music - Run 'cmus'."
  echo "picture - Run 'timg'."
  echo "fbterm - Run 'fbterm'."
  echo "disk - Run 'gparted'."
  echo "memory - Drop caches."
  echo "clean - Release your disk usage."
  exit 1
}

permission (){
  echo "You will run this command as root."
  echo "To continue, type 'I know what I am doing.' (default:N)"
  read -p "Choice:" choice
  if [[ "$choice" = "I know what I am doing." ]]; then
    return 0
  else
    echo "You chose to cancel."
    return 1
  fi
}

#if [ -z $1 ]; then
#  usage
#fi
case $1 in
  upgrade)
    permission
    if [[ $? -eq 0 ]]; then
      sudo apt update
      sudo apt-fast upgrade
    else
      exit 1
    fi
    ;;
  find)
    if [[ -e "/home/sunliyuan/filefind.sh" && -x "/home/sunliyuan/filefind.sh" && -z $2 ]]; then
      /home/sunliyuan/filefind.sh
      exit
    elif [[ -n $2 && -d $2 ]]; then
      if [[ -n $3 ]]; then
        F=$(find $2 -name "*$3*" -print)
        N=$(find $2 -name "*$3*" | wc -l)
        whiptail --title "$N files found" --msgbox "$F" 0 0
        exit
      else
        echo "Missing parameters! Filename required."
        usage
        exit 1
      fi
    elif [[ -n $2 && ! -d $2 ]]; then
      echo "Is ${2} a directory?"
      usage
      exit 1  
    else
      echo "Missing file 'filefind.sh'."
      exit
    fi
    ;;
  disk)
    permission
    if [[ $? -eq 0 ]]; then
      pkexec gparted &
    else
      exit 1
    fi
    ;;
  eng)
    echo "Run 'export LANG=en_US.UTF-8'."
    exit
    ;;
  mail)
    mail
    exit
    ;;
  browser)
    if [[ -n $2 ]]; then
      w3m $2
    else
      read -p 'Where? ( URL | IP Address ):' web
      w3m $web
    fi
    exit
    ;;
  music)
    cmus
    exit
    ;;
  picture)
    if [[ -n $2 ]]; then
      timg $2
    else
      echo "Open what?"
      exit 1
    fi
    exit
    ;;
  fbterm)
    fcitx-fbterm-helper -l
    exit
    ;;
  memory)
    permission
    if [[ $? -eq 0 ]]; then
      option=$(whiptail --title "Select a mode" --menu "There are 3 modes you can choose." 15 60 4 \
      "0" "Do nothing. Don't drop any caches." \
      "1" "Drop pagecache." \
      "2" "Drop dentries and inodes." \
      "3" "Drop pagecache, dentries and inodes." 3>&1 1>&2 2>&3)
      exitstatus=$?
      if [ $exitstatus = 0 ]; then
        sync
        sudo su -c "echo $option > /proc/sys/vm/drop_caches"
      else
        echo "You chose to cancel."
      fi
    else
      echo "You chose to cancel."
    fi
    ;;
  clean)
    permission
    if [[ $? -eq 0 ]]; then
      option=$(whiptail --title "Options" --menu "There are 5 options you can choose." 15 60 6 \
      "0" "Do nothing. Exit immediately." \
      "1" 'Open "bleachbit".' \
      "2" 'Run "sudo apt clean".' \
      "3" 'Run "sudo apt autoclean".' \
      "4" 'Run "sudo apt autoremove".' 3>&1 1>&2 2>&3)
      exitstatus=$?
      if [ $exitstatus = 0 ]; then
        case $option in
          1)
            pkexec bleachbit
            ;;
          2)
            sudo apt clean
            ;;
          3)
            sudo apt autoclean
            ;;
          4)
            sudo apt autoremove
            ;;
          *)
            echo "You chose to cancel."
        esac
      else
        echo "You chose to cancel."
      fi
    else
      echo "You chose to cancel."
    fi
    ;;
  *)
    usage
esac
