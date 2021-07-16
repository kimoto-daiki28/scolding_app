class WastingDecorator < Draper::Decorator
  delegate_all

  def self.name_response
    "えらい！よく我慢できました！\nあなたのそのブレない心に称賛を送ります！\nその調子で誘惑に打ち勝っていきましょう！！"
  end

  def self.price_response(message)
    "#{message}円も使ったんですか？\n意志の弱い人ですね...\nただでさえ財布が薄いんですからもうちょっと考えましょうよ..."
  end

  def self.unrecognizable_response
    "認識できませんでした。\nもう一度入力してください。"
  end

  def wasting_information
    "#{name}：#{price}円"
  end

  def each_totals
    "お菓子: #{sweets.last_week_total_wasting}円
お酒: #{alcohols.last_week_total_wasting}円
ネットショッピング: #{online_shoppings.last_week_total_wasting}円
ギャンブル: #{gamblings.last_week_total_wasting}円
たばこ: #{cigarettes.last_week_total_wasting}円
ゲーム課金: #{games.last_week_total_wasting}円
無駄な外食: #{eating_outs.last_week_total_wasting}円"
  end
end
