cd "$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

rm -rf ./tmp/*
bundle
bundle exec rake db:drop
bundle exec rake db:create
bundle exec rake db:migrate
bundle exec rake db:seed

echo "" > ./log/development.log
echo "" > ./log/bullet.log

if [ "$1" == "start" ]; then
	rails s	
fi
