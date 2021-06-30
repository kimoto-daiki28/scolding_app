class LineBotController < ApplicationController
  require 'line/bot'
  protect_from_forgery except: [:callback]

  def callback
    body = request.body.read
    signature = request.env['HTTP_X_LINE_SIGNATURE']
    unless client.validate_signature(body, signature)
      return head :bad_request
    end
    events = client.parse_events_from(body)
    events.each do |event|
      @message = event.message['text']
      case event
      when Line::Bot::Event::Message
        case event.type
        when Line::Bot::Event::MessageType::Text
          case @message
          when 'した'
            message = ::LineClient.second_quick_reply
          when 'してない'
            response = "えらい！よく我慢できました！\nあなたのそのブレない心に称賛を送ります！\nその調子で誘惑に打ち勝っていきましょう！！"
            message = {
              type: 'text',
              text: response
            }
          when 'お菓子', 'お酒', 'ネットショッピング', 'ジュース'
            response = "いくらでしたか？"
            message = {
              type: 'text',
              text: response
            }
          when ('1'..'30000')
            response = "#{@message}円も使ったんですか？バカですか？"
            message = {
              type: 'text',
              text: response
            }
          else
            response = '認識できませんでした。もう一度入力してください。'
            message = {
              type: 'text',
              text: response
            }
          end
          client.reply_message(event['replyToken'], message)
        end
      end
    end
    head :ok
  end

  private

  def client
    @client ||= Line::Bot::Client.new { |config|
      config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
      config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
    }
  end
end
