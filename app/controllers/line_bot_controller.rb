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
      if ['した', 'してない'].include?(event.message['text'])
        case event.message['text']
        when 'した'
          response = '何を無駄遣いしましたか？'
          buttons = first_quick_button
          set_buttons(buttons)
        when 'してない'
          response = "えらい！よく我慢できました！\nあなたのそのブレない心に称賛を送ります！\nその調子で誘惑に打ち勝っていきましょう！！"
        end
      elsif ['お菓子', 'お酒', 'ネットショッピング', 'ジュース'].include?(event.message['text'])
        response = 'いくらですか？'
      elsif ('1'..'30000').include?(event.message['text'])
        response = "#{event.message['text']}円も使ったんですか？バカですか？"
      else
        response = '認識できませんでした。もう一度入力してください。'
      end

      case event
      when Line::Bot::Event::Message
        case event.type
        when Line::Bot::Event::MessageType::Text
          message = {
            type: 'text',
            text: response,
          }
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

  def set_buttons(buttons)
    buttons.each do |button|
      puts button.class
    end
  end

  def first_quick_button
    {
      "type": "text",
      "text": "Select your favorite food category or send me your location!",
      "quickReply": {
        "items": [
          {
            "type": "action",
            "imageUrl": "https://example.com/sushi.png",
            "action": {
              "type": "message",
              "label": "した",
              "text": "した"
            }
          },
          {
            "type": "action",
            "imageUrl": "https://example.com/tempura.png",
            "action": {
              "type": "message",
              "label": "してない",
              "text": "してない"
            }
          }
        ]
      }
    }
  end
end
