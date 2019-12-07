#!/usr/bin/env bash

if [[ ! -f ./bin/php7/bin/php ]]; then
  echo -n "[PocketMine-MP] PHP for PocketMine-MP not installed. Compile?(yes/no)..."
  read ANSWER

  if [[ $ANSWER == "yes" || $ANSWER == "y" ]]; then
    if [[ ! -f /bin/git ]]; then
      echo -n "[PocketMine-MP] GIT not installed. Install GIT?(yes/no)..."
      read ANSWER
      if [[ $ANSWER == "yes" || $ANSWER == "y" ]]; then
        echo -n "[PocketMine-MP] GIT installing..."
        sudo apt-get install --yes -qq install > /dev/null
        echo "done!"
      fi
    fi
  fi
fi
unset ANSWER

PHP=./bin/php7/bin/php

if [[ -f ./PocketMine-MP.phar ]]; then
  POCKETMINE=./PocketMine-MP.phar
elif [[ -f ./src/pocketmine/PocketMine.php ]]; then
  POCKETMINE=./src/pocketmine/PocketMine.php
elif [[ -f ./src/PocketMine.php ]]; then
  POCKETMINE=./src/PocketMine.php
else
  echo "[PocketMine-MP] PocketMine-MP not found!"
fi

echo -n "[PocketMine-MP] Enable auto restart?(yes/no)..."
read ANSWER

if [[ $ANSWER == "yes" || $ANSWER == "y" ]]; then
  DO_LOOP=yes
else
  DO_LOOP=no
fi

if [[ $DO_LOOP == "yes" ]]; then
  "$PHP" "$POCKETMINE"
  while true; do
    echo "[PocketMine-MP] Rebooting...PocketMine-MP will start in 5 seconds..."
    sleep 5
    "$PHP" "$POCKETMINE"
  done
else
  exec "$PHP" "$POCKETMINE"
fi
