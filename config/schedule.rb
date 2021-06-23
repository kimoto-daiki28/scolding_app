require File.expand_path(File.dirname(__FILE__) + "/environment")

rails_env = ENV['RAILS_ENV'] || :development

set :environment, rails_env
set :output, "#{Rails.root}/log/cron.log"

# every 1.day, at: ['9:00 pm'] do # タスクを処理するペースを記載する。（毎21時に実行）
every 10.minutes do
  rake 'push_line:push_line_message_evening'
end
