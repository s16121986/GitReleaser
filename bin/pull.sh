#!/bin/bash

set -e

git reset --hard && git clean -df
git pull

debug "Composer and npm update..."
composer install
npm install
npx browserslist@latest --update-db

if [ $# -eq 1 ]
then
	debug "Database migrations..."
	php bin/artisan release:migrate "${1}"
fi

debug "Translations update..."
php bin/artisan translation:sync
php bin/artisan translation:mix-locale

php bin/artisan queue:restart

debug "NPM run prod..."
npm run prod

#delete all local branches
git branch | grep -v "dev\|main" | xargs git branch -D

debug "Pull complete"

