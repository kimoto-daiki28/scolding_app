class LineBotController < ApplicationController
  require 'line/bot'
  protect_from_forgery except: :callback
  before_action :validate_signature, only: :callback
  # before_action :set_user, only: :callback

  def callback
    @wasting = Wasting.create
    events.each do |event|
      @user = User.find_by(line_id: event['source']['userId'])
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
          when 'お菓子', 'お酒', 'ネットショッピング', 'ジュース'
            response = "いくらでしたか？"
            @wasting_name = event['message']['text']
          when ('1'..'30000')
            response = "#{@message}円も使ったんですか？バカですか？"
            @wasting_price = event['message']['text']
          else
            response = '認識できませんでした。もう一度入力してください。'
          end
          client.reply_message(event['replyToken'], message || message(response))
        end
      end
    end
    @wasting.user = @user
    @wasting.name = @wasting_name
    @wasting.price = @wasting_price
    # binding.pry
    head :ok
  end

  private

  def body
    @body ||= request.body.read
  end

  def events
    @events ||= client.parse_events_from(body)
  end

  def client
    @client ||= Line::Bot::Client.new { |config|
      config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
      config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
    }
  end

  def message(response)
    @message = {
      type: 'text',
      text: response
    }
  end

  def validate_signature
    signature = request.env['HTTP_X_LINE_SIGNATURE']
    head :bad_request unless client.validate_signature(body, signature)
  end

  def set_user
    binding.pry
    @user = User.find_by(line_id: events.source[:userId])
    # binding.pry
  end
end
