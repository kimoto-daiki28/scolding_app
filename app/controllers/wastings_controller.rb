class WastingsController < ApplicationController
  require 'line/bot'
  protect_from_forgery except: :create
  before_action :validate_signature, only: :create
  before_action :set_wasting, only: %i[show edit update destroy]
  skip_before_action :login_require, only: :create

  def create
    events.each do |event|
      @user = User.find_by(line_id: event['source']['userId'])
      @today_wastings = @user.wastings.today_wastings
      @yesterday_wastings = @user.wastings.yesterday_wastings
      @message = event.message['text']
      case event
      when Line::Bot::Event::Message
        case event.type
        when Line::Bot::Event::MessageType::Text
          case @message
          when 'した', 'はい'
            message = Wasting.second_quick_reply
          when 'してない'
            response = WastingDecorator.name_response
          when 'お菓子', 'お酒', 'ネットショッピング', 'ギャンブル', 'たばこ', 'ゲーム課金', '無駄な外食'
            @wasting = @user.wastings.create(name: event['message']['text'])
            response = "いくらでしたか？\n1〜30000で入力してください。"
          when ('1'..'30000')
            wasting_find_and_save(event['message']['text'])
            message = Wasting.third_quick_reply
          when 'いいえ'
            response = WastingDecorator.price_response(@today_wastings, @yesterday_wastings)
          else
            response = WastingDecorator.unrecognizable_response
          end
          client.reply_message(event['replyToken'], message || message(response))
        end
      end
    end
    head :ok
  end

  def show; end

  def edit; end

  def update
    if @wasting.update(wasting_params)
      redirect_to @wasting, notice: '更新しました。'
    else
      render :edit
    end
  end

  def destroy
    @wasting.destroy
    redirect_to my_page_path, notice: '削除しました。'
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
      # config.channel_secret = ENV["DEVELOP_LINE_CHANNEL_SECRET"]
      # config.channel_token = ENV["DEVELOP_LINE_CHANNEL_TOKEN"]
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

  def set_wasting
    @wasting = current_user.wastings.find(params[:id])
  end

  def wasting_params
    params.require(:wasting).permit(:name, :price)
  end
end
