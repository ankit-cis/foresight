# Be sure to restart your server when you modify this file.

if Rails.env.development?
  puts "*************************************************"
  puts "**       Running in Development Mode...        **"
  puts "*************************************************"
  Rails.application.config.session_store :cookie_store, key: '_four_sight_plus_rails_session', :domain => ".autologistic.co.uk"
elsif Rails.env.test?
  puts "*************************************************"
  puts "**          Running in Test Mode...            **"
  puts "*************************************************"
  Rails.application.config.session_store :cookie_store, key: '_four_sight_plus_rails_session', :domain => ".foursightplus-rails.test"
elsif Rails.env.production?
  puts "*************************************************"
  puts "**       Running in Production Mode...         **"
  puts "*************************************************"
  Rails.application.config.session_store :cookie_store, key: '_four_sight_plus_rails_session', :domain => ".4sightplus.co.uk"
else
  puts "*************************************************"
  puts "**      Running in an unknown mode?            **"
  puts "*************************************************"
end
