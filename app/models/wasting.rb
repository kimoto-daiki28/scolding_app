class Wasting < ApplicationRecord
  belongs_to :user

  validates :price, numericality: { greater_than_or_equal_to: 0 }

  # day
  scope :today_wastings, -> { where(created_at: Date.today.in_time_zone.all_day) }
  scope :yesterday_wastings, -> { where(created_at: 1.day.ago.in_time_zone.all_day) }

  # week
  scope :this_week, -> { where(created_at: (Date.today.beginning_of_week)..(Date.today.end_of_week))}
  scope :this_week_total_wasting, -> { this_week.pluck(:price).sum }
  scope :last_week, -> { where(created_at: (0.days.ago.prev_week(:monday))..(0.days.ago.prev_week(:sunday).end_of_day)) }
  scope :last_week_total_wasting, -> { last_week.pluck(:price).sum }
  scope :the_week_before_last, -> { where(created_at: (0.days.ago.prev_week.prev_week(:monday))..(0.days.ago.prev_week.prev_week(:sunday).end_of_day)) }
  scope :the_week_before_last_total_wasting, -> { the_week_before_last.pluck(:price).sum }

  # quickReply
  scope :sweets, -> { where(name: 'お菓子') }
  scope :alcohols, -> { where(name: 'お酒') }
  scope :online_shoppings, -> { where(name: 'ネットショッピング') }
  scope :gamblings, -> { where(name: 'ギャンブル') }
  scope :cigarettes, -> { where(name: 'たばこ') }
  scope :games, -> { where(name: 'ゲーム課金') }
  scope :eating_outs, -> { where(name: '無駄な外食') }
  scope :others, -> { where(name: 'その他') }


  def self.weekly_difference
    last_week_total_wasting - this_week_total_wasting
  end

  def self.last_week_difference
    last_week_total_wasting - the_week_before_last_total_wasting
  end

  def self.first_quick_reply
    {
      "type": "text",
      "text": "本日は何か無駄遣いをしましたか？",
      "quickReply": {
        "items": [
          {
            "type": "action",
            "action": {
              "type": "message",
              "label": "した",
              "text": "した"
            }
          },
          {
            "type": "action",
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

  def self.second_quick_reply
    {
      "type": "text",
      "text": "何を無駄遣いしましたか？",
      "quickReply": {
        "items": [
          {
            "type": "action",
            "imageUrl": "https://illust8.com/wp-content/uploads/2021/02/shopping_cart_sweet_12432.png",
            "action": {
              "type": "message",
              "label": "お菓子",
              "text": "お菓子"
            }
          },
          {
            "type": "action",
            "imageUrl": "https://illust8.com/wp-content/uploads/2019/11/beer_bin_5813.png",
            "action": {
              "type": "message",
              "label": "お酒",
              "text": "お酒"
            }
          },
          {
            "type": "action",
            "imageUrl": "https://illust8.com/wp-content/uploads/2020/06/smartphone_pay_9871.png",
            "action": {
              "type": "message",
              "label": "ネットショッピング",
              "text": "ネットショッピング"
            }
          },
          {
            "type": "action",
            "imageUrl": "https://illust8.com/wp-content/uploads/2019/09/keiba_baken_4824.png",
            "action": {
              "type": "message",
              "label": "ギャンブル",
              "text": "ギャンブル"
            }
          },
          {
            "type": "action",
            "imageUrl": "https://illust8.com/wp-content/uploads/2019/09/tabako_suigara_haizara_4682.png",
            "action": {
              "type": "message",
              "label": "たばこ",
              "text": "たばこ"
            }
          },
          {
            "type": "action",
            "imageUrl": "https://illust8.com/wp-content/uploads/2021/06/bitcoin_smartphone_13660.png",
            "action": {
              "type": "message",
              "label": "ゲーム課金",
              "text": "ゲーム課金"
            }
          },
          {
            "type": "action",
            "imageUrl": "https://illust8.com/wp-content/uploads/2020/07/familyrestaurant_10036.png",
            "action": {
              "type": "message",
              "label": "無駄な外食",
              "text": "無駄な外食"
            }
          },
          {
            "type": "action",
            "imageUrl": "https://illust8.com/wp-content/uploads/2018/12/fuda_batsu_illust_2444.png",
            "action": {
              "type": "message",
              "label": "その他",
              "text": "その他"
            }
          },
        ]
      }
    }
  end

  def self.third_quick_reply
    {
      "type": "text",
      "text": "他に無駄遣いをしましたか？",
      "quickReply": {
        "items": [
          {
            "type": "action",
            "action": {
              "type": "message",
              "label": "はい",
              "text": "はい"
            }
          },
          {
            "type": "action",
            "action": {
              "type": "message",
              "label": "いいえ",
              "text": "いいえ"
            }
          }
        ]
      }
    }
  end

  def self.weekly_report
    if last_week_total_wasting.zero?
      {
        "type": "text",
        "text": "先週は無駄遣い無しでした！\n素晴らしい！今週もこの調子でいきましょう！！"
      }
    elsif last_week_difference.negative?
      {
        "type": "text",
        "text": "先週の無駄遣いは#{last_week_total_wasting}円でした。
先々週より#{last_week_difference}円も減らせましたね！！
この調子で無駄遣いを撲滅していきましょう！\n#{each_totals}"
      }
    elsif last_week_difference.positive?
      {
        "type": "text",
        "text": "先週の無駄遣いは#{last_week_total_wasting}円でした。
先々週より#{last_week_difference}円も増えていますね...
今週はもうちょっと頑張りましょう！\n#{each_totals}"
      }
    else
      {
        "type": "text",
        "text": "先週の無駄遣いは#{last_week_total_wasting}円でした。\n先々週と同額ですね...
今週は先週の壁を超えましょう！\n#{each_totals}"
      }
    end
  end

  def self.each_totals
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
