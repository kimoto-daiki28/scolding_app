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
      # case event 
      # when Line::Bot::Event::Message
      @message = event.message['text']
      # if ['した', 'してない'].include?(event.message['text'])
      #   case event.message['text']
      #   when 'した'
      #     message = ::LineClient.fiest_quick_reply
      #     client.reply_message(event['replyToken'], message)
      #     # response = '何を無駄遣いしましたか？'
      #   when 'してない'
      #     response = "えらい！よく我慢できました！\nあなたのそのブレない心に称賛を送ります！\nその調子で誘惑に打ち勝っていきましょう！！"
      #   end
      # elsif ['お菓子', 'お酒', 'ネットショッピング', 'ジュース'].include?(event.message['text'])
      #   response = 'いくらですか？'
      # elsif ('1'..'30000').include?(event.message['text'])
      #   response = "#{event.message['text']}円も使ったんですか？バカですか？"
      # else
      #   response = '認識できませんでした。もう一度入力してください。'
      # end

      case event
      when Line::Bot::Event::Message
        case event.type
        when Line::Bot::Event::MessageType::Text
          case @message
          when 'した'
            message = ::LineClient.second_quick_reply
            client.reply_message(event['replyToken'], message)
          when 'してない'
            response = "えらい！よく我慢できました！\nあなたのそのブレない心に称賛を送ります！\nその調子で誘惑に打ち勝っていきましょう！！"
            message = {
              type: 'text',
              text: response
            }
            client.reply_message(event['replyToken'], message)
          when ['お菓子', 'お酒', 'ネットショッピング', 'ジュース'].include?(@message)
            response = "いくらでしたか？"
            message = {
              type: 'text',
              text: response
            }
            client.reply_message(event['replyToken'], message)
          when ('1'..'30000').include?(@message)
            response = "#{@message}円も使ったんですか？バカですか？"
            message = {
              type: 'text',
              text: response
            }
          else
            response = "いくらでしたか？"
            
            client.reply_message(event['replyToken'], message)
          end
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

  # def message_type(response)
  #   message = {
  #     type: 'text',
  #     text: response
  #   }
  # end
end
