#! /bin/bash
PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c" 


MAIN_MENU(){
echo -e "Please enter a phone number\n"
read CUSTOMER_PHONE


CHECK_PHONE_NUMBER=$($PSQL "SELECT phone FROM customers WHERE phone = '$CUSTOMER_PHONE'")

if [[ -z $CHECK_PHONE_NUMBER ]]
then 
echo -e "There is no record of you're phone number, please enter your name"
read CUSTOMER_NAME
NAME=$CUSTOMER_NAME

INSERT_CUSTOMER=$($PSQL "INSERT INTO customers(phone, name) VALUES('$CUSTOMER_PHONE', '$CUSTOMER_NAME')")
echo "I have enterd you into our system"

else 
NAME=$($PSQL "SELECT name FROM customers WHERE phone = '$CUSTOMER_PHONE'")
fi

echo -e "What time would you like your $SERVICE_SELECTED, $NAME?"
read SERVICE_TIME

CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone = '$CUSTOMER_PHONE'")

INSERT_APPOINTMENT=$($PSQL "INSERT INTO appointments(time, customer_id, service_id) VALUES('$SERVICE_TIME', $CUSTOMER_ID, $SERVICE_ID_SELECTED)")

echo -e "I have put you down for a $SERVICE_SELECTED at $SERVICE_TIME, $NAME."
}

SERVICE_MENU(){
echo -e "\n~~~~~ MY SALON ~~~~~\n"

if [[ $1 ]] 
then 
echo -e "\n$1\n"
fi

SERVICES=$($PSQL "SELECT * FROM services")

echo "$SERVICES" | while read ID BAR NAME
do
echo -e "$ID) $NAME\n"
done

read SERVICE_ID_SELECTED
SERVICE_SELECTED=$($PSQL "SELECT name FROM services WHERE service_id = $SERVICE_ID_SELECTED")


if [[ -z $SERVICE_SELECTED ]]
then 
SERVICE_MENU "I could not find that service. What would you like today?"
else 
MAIN_MENU
fi

}
SERVICE_MENU "Welcome to My Salon, how can I help you?"
