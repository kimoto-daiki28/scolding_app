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
        when 'してない'
          response = "えらい！よく我慢できました！
          \nあなたのそのブレない心に称賛を送ります！
          \nその調子で誘惑に打ち勝っていきましょう！！"
        else
          response = '「した」か「してないか」を入力してください！'
        end
      elsif ['お菓子', 'お酒', 'ネットショッピング', 'ジュース'].include?(event.message['text'])
        case event.message['text']
        when 'お菓子' || 'お酒' || 'ネットショッピング' || 'ジュース'
          response = 'いくらですか？'
        else
          response = '認識できませんでした。'
        end
      elsif ('1'..'30000').include?(event.message['text'])
        case event.message['text']
        when '1'..'30000'
          response = "#{event.message['text']}円も使ったんですか？バカですか？"
        else
          response = '1〜30000で入力してください'
        end
      end

      case event
      when Line::Bot::Event::Message
        case event.type
        when Line::Bot::Event::MessageType::Text
          message = {
            type: 'text',
            text: response
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

  # def first_res(message)
  #   case message
  #   when 'した'
  #     response = '何を無駄遣いしましたか？'
  #   when 'してない'
  #     response = "えらい！よく我慢できました！
  #     \nあなたのそのブレない心に称賛を送ります！
  #     \nその調子で誘惑に打ち勝っていきましょう！！"
  #   else
  #     response = '「した」か「してないか」を入力してください！'
  #   end
  # end

  # def second_res(message)
  #   case message
  #   when 'お菓子' || 'お酒' || 'ネットショッピング' || 'ジュース'
  #     response = 'いくらですか？'
  #   else
  #     response = '認識できませんでした。'
  #   end
  # end

  # def third_res(message)
  #   case message
  #   when '1'..'30000'
  #     response = "#{event.message['text']}円も使ったんですか？バカですか？"
  #   else
  #     response = '1〜30000で入力してください'
  #   end
  # end
end
