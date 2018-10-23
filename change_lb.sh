#!/bin/bash

AC="your account"
PASS="password"

ARR_WEB_SVR=("web1" "web2" "web3")

ARR_AP_SVR=("dummy" "ap1" "ap2" "ap3")

CURL=`which curl`

status(){
  date
  for i in ${ARR_WEB_SVR[@]}
  do

  echo  ""
  echo "server:$i"
  curl -s "http://$AC:$PASS@$i/balancer-manager" | grep "b=application" | sed "s/<[^>]*>/ /g"

  done
}

request(){

  for ((i=0;i<${#ARR_WEB_SVR[@]};i++))
  do
    echo "$3 ${ARR_WEB_SVR[$i]} ${ARR_AP_SVR[$2]} ..."

    nonce=`curl -s "http://$AC:$PASS@${ARR_WEB_SVR[$i]}/balancer-manager" | grep "b=application" | sed "s/.*nonce=\(.*\)['\"].*/\1/" |tail -n 1`

    $CURL -s -o /dev/null "http://$AC:$PASS@${ARR_WEB_SVR[$i]}/balancer-manager?lf=10&ls=0&wr=&rr=&dw=$3&b=application&w=http://${ARR_AP_SVR[$2]}:8080/application/&nonce=${nonce}"
    sleep 2
  done
}


if [ $# -ne 2 ]; then
  echo "Usage: $0 {enable|disable} {1|2|3}" 1>&2
  echo ""
  echo "example: $0 enable 1"

  status
  exit 1
else

case "$1" in
 enable)
  request $1 $2 enable
  status
    ;;

 disable)
  request $1 $2 disable
  status
    ;;
esac

fi

