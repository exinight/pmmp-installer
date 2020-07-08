#!/usr/bin/env bash

if [[ ! -f ./bin/php7/bin/php ]]; then
  echo -n "[PocketMine-MP] PHP для PocketMine-MP не установлен. Работа скрипта остановлена!"
  exit
fi

PHP=./bin/php7/bin/php

if [[ -f ./PocketMine-MP.phar ]]; then
  POCKETMINE=./PocketMine-MP.phar
elif [[ -f ./src/pocketmine/PocketMine.php ]]; then
  POCKETMINE=./src/pocketmine/PocketMine.php
elif [[ -f ./src/PocketMine.php ]]; then
  POCKETMINE=./src/PocketMine.php
else
  echo "[PocketMine-MP] PocketMine-MP не найден! Работа скрипта остановлена!"
  exit
fi

echo -n "[PocketMine-MP] Включить автоматический перезапуск?(yes/no)..."
read ANSWER

if [[ $ANSWER == "yes" || $ANSWER == "y" ]]; then
  DO_LOOP=yes
else
  DO_LOOP=no
fi
unset ANSWER

if [[ $DO_LOOP == "yes" ]]; then
  "$PHP" "$POCKETMINE"
  while true; do
    echo "[PocketMine-MP] Перезагрузка ... PocketMine-MP запустится через 5 секунд ..."
    sleep 5
    "$PHP" "$POCKETMINE"
  done
else
  exec "$PHP" "$POCKETMINE"
fi