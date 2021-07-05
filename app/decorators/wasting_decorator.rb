class WastingDecorator < Draper::Decorator
  delegate_all

  def self.price_response(message)
    "#{message}円も使ったんですか？バカですか？"
  end
end
