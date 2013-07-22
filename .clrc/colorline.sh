#!/bin/bash
function loadline(){
   iswork=`echo $PROMPT_COMMAND |grep colorline`

   if [[ -n "$iswork" ]];then
       buildmessage
   else 
       #first load
       welcome
       line=`color "$" lightblue`
       export PS1=$line
       export PROMPT_COMMAND=~/.clrc/colorline.sh
   fi
}

function buildmessage(){
   p=`color [ green`
   q=`color ] green`
   llen=`tput cols`

   echo -ne '\e[6n';read -sdR pos
   pos=${pos#*[}
   line=${pos%%;*}
   col=${pos##*;}

   fmsg="$p`me`@`myhost`$q-$p`currentdir`$q"
   emsg="$p`now`$q"

   echo -n $fmsg
   skiped=`expr $llen - 10`
   if [[ $skiped -gt $col ]];then
       writemsg `expr $line - 1` $skiped $emsg
   fi
   echo
}

function writemsg(){
    l=$1
    c=$2
    context=$3
    tput sc
    tput cup $l $c
    echo -n `color "$context" blue`
    tput rc
}


function welcome(){
   echo `color "welcome to colorline! enjoy it." lightred`
   echo `color "created by mawenjin" lightred`
}

function color(){
     context=$1
     color=$2

     case "$color" in
     "green") echo -e "\033[32;49;1m${context}\033[39;49;0m";;
     "lightred") echo -e "\033[33;49;1m${context}\033[39;49;0m";;
     "blue") echo -e "\033[34;49;1m${context}\033[39;49;0m";;
     "purple") echo -e "\033[35;49;1m${context}\033[39;49;0m";;
     "lightblue") echo -e "\033[36;49;1m${context}\033[39;49;0m";;
     "gray") echo -e "\033[37;49;1m${context}\033[39;49;0m";;
     "red") echo -e "\033[31;49;1m${context}\033[39;49;0m";;
     esac
}

function now(){
  now=`date +%k:%M:%S`
  echo `color ${now} purple`
}

function currentdir(){
    dir=`pwd`
    echo `color $dir purple`
}

function me(){
    me=`whoami`
    echo `color ${me} purple`
}

function myhost(){
    myhost=`hostname`
    echo `color ${myhost} purple`
}

loadline
