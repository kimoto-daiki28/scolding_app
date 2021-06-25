namespace :push_line do 
  desc "push_line"
  task message_everyday: :environment do
    message = {
      type: 'text',
      text: '本日は何か無駄遣いをしましたか？した場合は「した」、してない場合は「してない」と入力してください。'
    }
    client = Line::Bot::Client.new { |config|
      config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
      config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
    }
    response = client.push_message(ENV["LINE_CHANNEL_USER_ID"], message)
  end
end