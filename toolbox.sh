#!/bin/bash
unset $choice
unset $web
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
  *)
    usage
esac
