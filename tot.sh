#/bin/bash

setup()
{
	path=`dirname $0`
	cd $path
	bundle install
	RAILS_ENV=production rake db:create
	RAILS_ENV=production rake db:migrate
	RAILS_ENV=production rake db:seed;
}

start()
{
	path=`dirname $0`
	cd $path
	RAILS_ENV=production rails server;
}

rootuser()
{
	path=`dirname $0`
	cd $path
	RAILS_ENV=production rake db:seed;
}

resetdb()
{
	echo 'resetting db'
	path=`dirname $0`
	cd $path
	RAILS_ENV=production rake db:reset;
	rm -rf ./public/uploads/*
}

if [[ "$1" = "start" ]]; then
	start
elif [[ "$1" = "setup" ]]; then
	setup
elif [[ "$1" = "reset" ]] && [[ "$2" = "rootuser" ]]; then
	rootuser
elif [[ "$1" = "reset" ]] && [[ "$2" = "db" ]]; then
	resetdb
else
	start
fi