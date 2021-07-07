require File.expand_path(File.dirname(__FILE__) + "/environment")

rails_env = ENV['RAILS_ENV'] || :development

set :environment, rails_env
set :output, "#{Rails.root}/log/cron.log"

every 1.day, at: '9:00pm' do
  rake 'push_line:message_everyday'
end

every 1.week, at: '10:00am' do
  rake 'push_line:message_everyweek'
end
