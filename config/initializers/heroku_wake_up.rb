if Rails.env.production?
  require 'rufus/scheduler'
  scheduler = Rufus::Scheduler.start_new
  scheduler.every '30m' do
    require 'net/http'
    require 'uri'
    url = 'http://cloudapi.herokuapp.com'
    Net::HTTP.get_response(URI.parse(url))
  end
end