#!/usr/bin/bash

##define color var##
RED="\e[31m"
GREEN="\e[32m"
ENDCOLOR="\e[0m"

PASSWORD="${1}"

if [[ ${#PASSWORD} -lt 10 ]]; then #First checking string len les than 10 return an error
  echo -e "${RED}Password is too short${ENDCOLOR}"
  exit 1
fi

PasswordValidator() {

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

PasswordValidator "$1"
