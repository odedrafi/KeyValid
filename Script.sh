#!/usr/bin/bash

#A function to validate a password by four parameters
PasswordValidator() {

  ##define color var##
  RED="\e[31m"
  GREEN="\e[32m"
  ENDCOLOR="\e[0m"

  PASSWORD="${1}"

  Condition1=[a-z] # init the condition
  Condition2=[A-Z]
  Condition3=[0-9]

  if [ ${#PASSWORD} -lt 10 ]; then #First checking string len les than 10 return an error
    echo "${RED}Password is too short${ENDCOLOR}"
    exit 1
  fi

  # going over all the condition permutations inorder to present the wanted error message

  if [[ ! $PASSWORD =~ $Condition1 ]]; then     # if password dosn't answer 1 then chack next
    if [[ ! $PASSWORD =~ $Condition2 ]]; then   # and password dosn't answer 2 then chack next conditions
      if [[ ! $PASSWORD =~ $Condition3 ]]; then # and password dosn't answer 3 then exit with the propper error
        echo -e "${RED}Password need's to containe "{$Condition1+ $Condition2+ $Condition3}" ${ENDCOLOR}"
        exit 1
      else
        echo -e "${RED}Password need's to containe "{$Condition1+$Condition2}"${ENDCOLOR} " # when only 3 is ok then an error on the other 2 is returnd
        exit 1
      fi
    else                                                                        # when 1 is missing 2 is ok we check to see about  3
      if [[ $PASSWORD =~ $Condition3 ]]; then                                   # when 3 is ok
        echo -e "${RED}Password need's to containe "{$Condition1}"${ENDCOLOR} " # we return the error only 1
        exit 1
      else
        echo -e "${RED}Password need's to containe "{$Condition1+ $Condition3}"${ENDCOLOR} " # unless 3 is also missing we return 1+3
        exit 1
      fi
    fi
  else                                              # when the 1'st is ok we start again to check the other two
    if [[ $PASSWORD =~ $Condition2 ]]; then         # nuber 2 is ok so
      if [[ $PASSWORD =~ $Condition3 ]]; then       # we check if 3 is ok too is so the password is valid
        echo -e "${GREEN}valid Password${ENDCOLOR}" #return the propper value and massage
        exit 0
      else
        echo -e "${RED}Password need's to containe "{$Condition3}"${ENDCOLOR} " # else the only one missing is 3 so we return the propper error
        exit 1
      fi
    else                                                                        # 1 is ok but 2 is not so we need to check 3 again
      if [[ $PASSWORD =~ $Condition3 ]]; then                                   # 1 and 3 are ok
        echo -e "${RED}Password need's to containe "{$Condition2}"${ENDCOLOR} " # return error of condition2
        exit 1
      else
        echo -e "${RED}Password need's to containe "{$Condition2+$Condition3}"${ENDCOLOR} " # finally when only 1 is ok we return an error for the other two
        exit 1
      fi
    fi
  fi
}

PasswordValidator "$1"
