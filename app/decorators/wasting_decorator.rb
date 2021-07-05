class WastingDecorator < Draper::Decorator
  delegate_all

  def self.name_response
    "えらい！よく我慢できました！\nあなたのそのブレない心に称賛を送ります！\nその調子で誘惑に打ち勝っていきましょう！！"
  end

  def self.price_response(message)
    "#{message}円も使ったんですか？バカですか？"
  end

  def self.unrecognizable_response
    "認識できませんでした。\nもう一度入力してください。"
  end
end
