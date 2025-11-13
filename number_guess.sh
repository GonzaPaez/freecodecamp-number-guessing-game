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

SECRET_NUMBER=$(( RANDOM % 1000 + 1 ))
NUMBER_OF_GUESSES=0

echo "Guess the secret number between 1 and 1000:"

while true
do
  read GUESS
  ((NUMBER_OF_GUESSES++))

  if [[ ! $GUESS =~ ^[0-9]+$ ]]
  then
    echo "That is not an integer, guess again:"
  elif (( GUESS < SECRET_NUMBER ))
  then
    echo "It's higher than that, guess again:"
  elif (( GUESS > SECRET_NUMBER ))
  then
    echo "It's lower than that, guess again:"
  else
    echo "You guessed it in $NUMBER_OF_GUESSES tries. The secret number was $SECRET_NUMBER. Nice job!"
    break
  fi
done