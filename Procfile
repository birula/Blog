web: bundle exec unicorn -p $PORT -c ./config/unicorn.rb
worker: bundle exec rake resque:work QUEUE=*
#web: bundle exec rails server thin -p $PORT