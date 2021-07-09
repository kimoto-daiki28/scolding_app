class WastingsController < ApplicationController
  require 'line/bot'
  protect_from_forgery except: :create
  before_action :validate_signature, only: :create
  skip_before_action :login_require, only: :create

  def create
    events.each do |event|
      @user = User.find_by(line_id: event['source']['userId'])
      @message = event.message['text']
      case event
      when Line::Bot::Event::Message
        case event.type
        when Line::Bot::Event::MessageType::Text
          case @message
          when 'した'
            message = Wasting.second_quick_reply
          when 'してない'
            response = WastingDecorator.name_response
          when 'お菓子', 'お酒', 'ネットショッピング', 'ギャンブル', 'たばこ'
            @wasting = @user.wastings.create(name: event['message']['text'])
            response = "いくらでしたか？\n1〜30000で入力してください。"
          when ('1'..'30000')
            response = WastingDecorator.price_response(@message)
            wasting_find_and_save(event['message']['text'])
          else
            response = WastingDecorator.unrecognizable_response
          end
          client.reply_message(event['replyToken'], message || message(response))
        end
      end
    end
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
      # config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
      # config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
      config.channel_secret = ENV["DEVELOP_LINE_CHANNEL_SECRET"]
      config.channel_token = ENV["DEVELOP_LINE_CHANNEL_TOKEN"]
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

  def wasting_find_and_save(message)
    wasting = @user.wastings.last
    wasting[:price] = message
    wasting.save
  end
end
