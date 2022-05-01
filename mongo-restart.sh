#!/bin/bash
#ver. 2

##this script will check whatever services 
##you want to keep an eye on
##if that service is not running
##it will (try to) start the service and send 
##an email to you

##set your email address 
EMAIL="team@spotfixcrew.com"

##list your services you want to check
##you can add as many as you like
SERVICES=('mongod')

#### DO NOT CHANGE anything BELOW ####


 for i in "${SERVICES[@]}"
  do
    ###IF SERVICE IS NOT RUNNING####

    service $i status;
    STATS=$(echo $?)
    if [[  $STATS == 3  ]]

    then
       ##TRY TO RESTART THAT SERVICE###
    service $i start

        ##IF RESTART WORKED###
        service $i status;
        RESTART=$(echo $?)
       if [[  $RESTART == 0  ]]

    then
        ##SEND AN EMAIL###
    MESSAGE="$(tail -10 /var/log/mongodb/mongod.log)"
    SUBJECT="$i down -but restarted-  on $(hostname) $(date) "
    echo "   $i  $MESSAGE "  | mail -s "$SUBJECT" "$EMAIL"
       else

        ##IF RESTART DID NOT WORK SEND A DIFFERENT EMAIL##
    MESSAGE="$(tail -5 /var/log/mongodb/mongod.log)"
    SUBJECT="$i down on $(hostname) $(date) "
    echo "   $i  $MESSAGE  . I tried to restart but it did not work"  | mail -s "$SUBJECT" "$EMAIL"

       fi
    fi

  done

