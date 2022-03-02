#!/usr/bin/bash

#A function to validate a password by four parameters
PasswordValidator() {

  #PASSWORD="$1"#note form previous version
  PasswordFile="$1" # getting file from specifide directory

  if [ -f $PasswordFile ]; then     #checking if file is empty
    PASSWORD=$(cat "$PasswordFile") # reading the password into a var. (assuming there is onle one line with a password)
  else
    echo "file is empty!"
    exit 1
  fi

  Condition1=[a-z] # init the condition
  Condition2=[A-Z]
  Condition3=[0-9]

  if [ ${#PASSWORD} -lt 10 ]; then #First checking string len les than 10 return an error
    echo "Password is too short"
    exit 1
  fi

  # going over all the condition permutations inorder to present the wanted error message

  if [[ ! $PASSWORD =~ $Condition1 ]]; then     # if password dosn't answer 1 then chack next
    if [[ ! $PASSWORD =~ $Condition2 ]]; then   # and password dosn't answer 2 then chack next conditions
      if [[ ! $PASSWORD =~ $Condition3 ]]; then # and password dosn't answer 3 then exit with the propper error
        echo "Password need's to containe "{$Condition1+ $Condition2+ $Condition3}" "
        exit 1
      else
        echo "Password need's to containe "{$Condition1+$Condition2}" " # when only 3 is ok then an error on the other 2 is returnd
        exit 1
      fi
    else                                                    # when 1 is missing 2 is ok we check to see about  3
      if [[ $PASSWORD =~ $Condition3 ]]; then               # when 3 is ok
        echo "Password need's to containe "{$Condition1}" " # we return the error only 1
        exit 1
      else
        echo "Password need's to containe "{$Condition1+ $Condition3}" " # unless 3 is also missing we return 1+3
        exit 1
      fi
    fi
  else                                        # when the 1'st is ok we start again to check the other two
    if [[ $PASSWORD =~ $Condition2 ]]; then   # nuber 2 is ok so
      if [[ $PASSWORD =~ $Condition3 ]]; then # we check if 3 is ok too is so the password is valid
        echo "valid Password"                 #return the propper value and massage
        exit 0
      else
        echo "Password need's to containe "{$Condition3}" " # else the only one missing is 3 so we return the propper error
        exit 1
      fi
    else                                                    # 1 is ok but 2 is not so we need to check 3 again
      if [[ $PASSWORD =~ $Condition3 ]]; then               # 1 and 3 are ok
        echo "Password need's to containe "{$Condition2}" " # return error of condition2
        exit 1
      else
        echo "Password need's to containe "{$Condition2+$Condition3}" " # finally when only 1 is ok we return an error for the other two
        exit 1
      fi
    fi
  fi
}

PasswordValidator "$1"
