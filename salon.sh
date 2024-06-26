#! /bin/bash
PSQL="psql  --username=freecodecamp --dbname=salon --tuples-only -c"

echo -e "\n~~~~~ MY SALON ~~~~~\n"

MAIN_MENU(){
echo -e "\n$1\n"

echo "$($PSQL"SELECT * FROM services;")"  | while read ID BAR NAME 
 do
  echo  "$ID) $NAME"
  done

read SERVICE_ID_SELECTED
SERVICE_ID="$($PSQL"SELECT service_id FROM services WHERE service_id=$SERVICE_ID_SELECTED;")"

if [[ -z $SERVICE_ID ]]
then 
MAIN_MENU "I could not find that service. What would you like today?"
else
echo -e "\nWhat's your phone number?"
read CUSTOMER_PHONE
CUSTOMER_ID=$($PSQL"SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE'")
if [[  -z $CUSTOMER_ID ]]
then
echo -e "\nI don't have a record for that phone number, what's your name?"
read CUSTOMER_NAME
INSERT_CUSTOMER_RESULT=$($PSQL"INSERT INTO customers(phone,name) VALUES('$CUSTOMER_PHONE','$CUSTOMER_NAME')")
fi
CUSTOMER_ID=$($PSQL"SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE'")
NAME=$($PSQL"SELECT name FROM customers WHERE phone='$PHONE'"|sed 's/^ //')
echo -e "\nWhat time would you like your cut, $NAME?"
read SERVICE_TIME
INSERT_APPOINTMENT_RESULT=$($PSQL"INSERT INTO appointments(service_id,customer_id,time) VALUES($SERVICE_ID,$CUSTOMER_ID,'$SERVICE_TIME')")
SERVICE_NAME=$($PSQL"SELECT name FROM services WHERE service_id=$SERVICE_ID_SELECTED"|sed 's/^ //')
echo -e "\nI have put you down for a $SERVICE_NAME at $SERVICE_TIME, $CUSTOMER_NAME."
fi
}
MAIN_MENU "Welcome to My Salon, how can I help you?"