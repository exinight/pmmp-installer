#!/usr/bin/env bash

echo "[PMMP-Installer] PocketMine-MP установится в этот каталог. Установка начнется через 5 секунд"
sleep 5
echo "[PMMP-Installer] Установка началась!"

echo -n "[PMMP-Installer] Клонирование репозитория(pmmp/PocketMine-MP)..."
git clone -q --recurse-submodules https://github.com/pmmp/PocketMine-MP.git ./pmmp && cd ./pmmp
echo "готово!"

echo -n "[PMMP-Installer] Выберите версию PocketMine-MP..."
read
git checkout -q $REPLY
mv $(ls -A) ../ && cd ../ && rmdir ./pmmp/

echo -n "[PMMP-Installer] Клонирование репозитория(pmmp/php-build-scripts)..."
git clone -q https://github.com/pmmp/php-build-scripts.git
echo "готово!"

echo -n "[PMMP-Installer] PHP-компиляция. Это может занять много времени..."
bash php-build-scripts/compile.sh > /dev/null
rm -rf php-build-scripts/
echo "готово!"

echo -n "[PMMP-Installer] Загрузка Composer..."
wget -q getcomposer.org/composer-stable.phar
echo "готово!"

echo -n "[PMMP-Installer] Установка зависимостей..."
./bin/php7/bin/php composer-stable.phar --quiet install
echo "готово!"

echo -n "[PMMP-Installer] Копирование скрипта для запуска PocketMine-MP..."
cp "$(dirname $0)/start.sh" "start.sh"
echo "готово!"

echo -n "[PMMP-Installer] Удаление лишних файлов и каталогов..."
rm -rf changelogs/
rm -f composer.lock
rm -f composer.json
rm -f composer.phar
rm -f install.log
rm -f phpstan.neon.dist
rm -f start.ps1
rm -rf tests/
rm -rf build/
rm -rf doxygen/
rm -f start.cmd
rm -f CONTRIBUTING.md
rm -rf .git/
rm -rf .github/
rm -f .gitmodules
rm -f README.md
rm -f BUILDING.md
rm -f .editorconfig
rm -f .gitattributes
rm -f .gitignore
rm -f .travis.yml
rm -f LICENSE.md
rm -f LICENSE
echo "готово!"

echo "[PMMP-Installer] Установка завершена! Для запуска введите \"bash start.sh\""
echo -n "[PMMP-Installer] Запустить PocketMine-MP сейчас?(yes/no)..."
read ANSWER

if [[ $ANSWER == "yes" || $ANSWER == "y" ]]; then
  exec "bash" "start.sh"
fi
