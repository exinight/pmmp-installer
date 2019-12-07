#!/usr/bin/env bash

echo "[PMMP-Installer] PocketMine-MP install to this directory. Installation will begin 5 seconds"
sleep 5
echo "[PMMP-Installer] Installation was started!"

if [[ ! -f /bin/git ]]; then
  echo -n "[PMMP-Installer] PMMP-Installer use GIT. Install GIT?(yes/no)..."
  read ANSWER
  if [[ $ANSWER == "yes" || $ANSWER == "y" ]]; then
    echo -n "[PMMP-Installer] GIT installing..."
    sudo apt-get install --yes -qq install > /dev/null
    echo "done!"
  fi
  unset ANSWER
fi

echo -n "[PMMP-Installer] Repository cloning(pmmp/PocketMine-MP)..."
git clone --recurse-submodules -q https://github.com/pmmp/PocketMine-MP.git $(pwd)
echo "done!"

echo -n "[PMMP-Installer] Select version PocketMine-MP..."
git checkout -q --recurse-submodules $(read)

echo -n "[PMMP-Installer] Repository cloning(pmmp/php-build-scripts)..."
git clone -q https://github.com/pmmp/php-build-scripts.git
echo "done!"

echo -n "[PMMP-Installer] PHP compiling. It may take long a time..."
bash php-build-scripts/compile.sh > /dev/null
rm -rf php-build-scripts/
echo "done!"

echo -n "[PMMP-Installer] Composer downloading..."
wget -q getcomposer.org/composer.phar
echo "done!"

echo -n "[PMMP-Installer] Dependency installing..."
./bin/php7/bin/php composer.phar --quiet install
echo "done!"

echo -n "[PMMP-Installer] Copying script to run PocketMine-MP..."
cp "$(dirname $0)/start.sh" "start.sh"
echo "done!"

echo -n "[PMMP-Installer] Clearing excess files and directories..."
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
echo "done!"

echo "[PMMP-Installer] Installation was finished. Enter to start \"bash start.sh\""
echo -n "[PMMP-Installer] Start PocketMine-MP now?(yes/no)..."
read ANSWER

if [[ $ANSWER == "yes" || $ANSWER == "y" ]]; then
  exec "bash" "start.sh"
fi
