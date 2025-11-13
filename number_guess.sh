#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

read -p "Enter your username: " USER_NAME

if [[ -z $USER_NAME ]]
then
  echo -e "\nPlease enter your name\n"
  exit
fi

USER_IN_DATABASE=$($PSQL "SELECT * FROM users WHERE user_name='$USER_NAME'")

if [[ -z $USER_IN_DATABASE ]]
then
  echo -e "\nWelcome, $USER_NAME! It looks like this your first time here."
else
  IFS="|" read USER_ID, USER_NAME GAMES_PLAYED BEST_GAME <<< "$USER_IN_DATABASE"
  echo -e "\nWelcome back, $USER_NAME! You have played $GAMES_PLAYED game, and your best game took $BEST_GAME guesses."
fi
