


[string]$File=$args[0]
[string]$Arg=$args[1]#getting param from user and deciding what to do





if ( $File -ceq "-f"){

    [string]$FileDirectory=$Arg
    $password = Get-Content $FileDirectory
}
else{

 [string]$password=$File#waiting for password from user 
}



 function PasswordValidator(){
   ##init flags for error massege
    $ErrorString1=$null
    $ErrorString2=$null
    $ErrorString3=$null

    if ( ( $password -notmatch '\d') -eq $true ){#checking for flag 3

        [string]$ErrorString3="[0-9]"

    }
    if ( ( $password -cmatch '[A-Z]') -ne $true){#checking for flag 2

        [string]$ErrorString2="[A-Z]"

    }
    if ( ( $password -cmatch '[a-z]') -ne $true){#checking for flag 1

            [string]$ErrorString1="[a-z]"

        } 


        #if all the flags are down valid password(checking if flags are null or empty)
        if( [string]::IsNullOrEmpty($ErrorString1) -and  [string]::IsNullOrEmpty($ErrorString2) -and [string]::IsNullOrEmpty($ErrorString3)){

            Write-host "Password Valid"-ForegroundColor Green

            exit 0
        
        }
        #else print to screen error message according to flags
        else{

            Write-host "Password need's to containe {$ErrorString1$ErrorString2$ErrorString3}" -ForegroundColor Red
            exit 1

        }


}




   PasswordValidator($key)
