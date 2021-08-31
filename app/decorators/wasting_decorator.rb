class WastingDecorator < Draper::Decorator
  delegate_all

  def self.name_response
    "えらい！よく我慢できました！\nあなたのそのブレない心に称賛を送ります！\nその調子で誘惑に打ち勝っていきましょう！！"
  end

  def self.price_response(today_wastings, yesterday_wastings)
    day_difference = today_wastings.pluck(:price).sum - yesterday_wastings.pluck(:price).sum
    if day_difference.negative?
      "本日の無駄遣い総額は#{today_wastings.pluck(:price).sum}円でした。\n昨日より#{day_difference}円減りました\nこの調子で少しずつ減らしていきましょう！"
    elsif day_difference.positive?
      "本日の無駄遣い総額は#{today_wastings.pluck(:price).sum}円でした。\n昨日より#{day_difference}円増えましたね...\n明日は期待してます..."
    else
      "本日の無駄遣い総額は#{today_wastings.pluck(:price).sum}円でした。\n昨日と同額ですね。"
    end
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
無駄な外食: #{eating_outs.last_week_total_wasting}円
その他: #{others.last_week_total_wasting}円"
  end
end
