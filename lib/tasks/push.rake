namespace :push_line do
  desc 'everyday_report'
  task message_everyday: :environment do
    message = Wasting.first_quick_reply

    # client = Line::Bot::Client.new { |config|
    #   config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
    #   config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
    # }
    # client.push_message(ENV["LINE_CHANNEL_USER_ID"], message)

    client = Line::Bot::Client.new { |config|
      config.channel_secret = ENV["DEVELOP_LINE_CHANNEL_SECRET"]
      config.channel_token = ENV["DEVELOP_LINE_CHANNEL_TOKEN"]
    }
    client.push_message(ENV["DEVELOP_LINE_CHANNEL_USER_ID"], message)
  end

  desc 'everyweek_report'
  task message_everyweek: :environment do
    users = User.all
    users.each do |user|
      message = user.wastings.weekly_report

      # client = Line::Bot::Client.new { |config|
      #   config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
      #   config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
      # }
      # client.push_message(ENV["LINE_CHANNEL_USER_ID"], message)

      client = Line::Bot::Client.new { |config|
        config.channel_secret = ENV["DEVELOP_LINE_CHANNEL_SECRET"]
        config.channel_token = ENV["DEVELOP_LINE_CHANNEL_TOKEN"]
      }
      client.push_message(ENV["DEVELOP_LINE_CHANNEL_USER_ID"], message)
    end
  end
end