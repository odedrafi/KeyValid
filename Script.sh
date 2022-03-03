#!/bin/bash

RED="\e[31m"
GREEN="\e[32m"
ENDCOLOR="\e[0m"

#A function to validate a password by four parameters
PasswordValidator() {

  # getting file from specifide directory

  if [ -f "${PasswordFile="$1"}" ]; then #checking if file is empty
    PASSWORD=$(cat "$PasswordFile")      #reading the password into a var. (assuming there is onle one line with a password)
  else
    echo -e "${RED}file is empty!${ENDCOLOR}"
    exit 1
  fi
  ##init flags for error massege
  ErrorFlag1="$null"
  ErrorFlag2="$null"
  ErrorFlag3="$null"

  ##init conditions
  condition1="[a-z]"
  condition2="[A-Z]"
  condition3="[0-9]"

  if [[ ! $PASSWORD =~ $condition1 ]]; then #checking for flag 3

    ErrorFlag1="[a-z]"

  fi
  if [[ ! $PASSWORD =~ $condition2 ]]; then #checking for flag 2

    ErrorFlag2="[A-Z]"

  fi
  if [[ ! $PASSWORD =~ $condition3 ]]; then

    ErrorFlag3="[0-9]"

  fi

  #if all the flags are down valid password(checking if flags are null or empty)
  if [[ ("$ErrorFlag1" == $null) && ("$ErrorFlag2" == $null) && ("$ErrorFlag3" == $null) ]]; then

    echo -e "${GREEN}Password is valid${ENDCOLOR}"

    exit 0

  #else print to screen error message according to flags
  else

    echo -e "${RED}Password need's to containe {$ErrorFlag1$ErrorFlag2$ErrorFlag3}${ENDCOLOR}"
    exit 1

  fi
}

#handaling flag -f with getops fuct
while getopts ":f:" FLAG; do

  if [[ ! "$FLAG" =~ "-f" ]]; then

    filedirectory=$OPTARG

  else
    echo -e "${RED}Wrong input!!${ENDCOLOR}"
    exit 1

  fi

done

PasswordValidator "$filedirectory"
