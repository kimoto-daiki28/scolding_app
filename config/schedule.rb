require File.expand_path(File.dirname(__FILE__) + "/environment")

rails_env = ENV['RAILS_ENV'] || :development

set :environment, rails_env
set :output, "#{Rails.root}/log/cron.log"

every 1.day, at: '9pm' do
  rake 'push_line:message_everyday'
end

every :monday, at: '10am' do
  rake 'push_line:message_everyweek'
end
