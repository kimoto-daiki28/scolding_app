class Wasting < ApplicationRecord
  belongs_to :user

  validates :price, numericality: { greater_than_or_equal_to: 0 }

  scope :weekly, -> { where(created_at: (0.days.ago.prev_week(:monday))..(0.days.ago.prev_week(:sunday).end_of_day)) }
  scope :weekly_total_wasting, -> { weekly.pluck(:price).sum }
  scope :sweets, -> { where(name: 'お菓子') }
  scope :alcohols, -> { where(name: 'お酒') }
  scope :online_shoppings, -> { where(name: 'ネットショッピング') }
  scope :gamblings, -> { where(name: 'ギャンブル') }
  scope :cigarettes, -> { where(name: 'たばこ') }
  scope :games, -> { where(name: 'ゲーム課金') }

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
          }
        ]
      }
    }
  end

  def self.third_quick_reply
    {
      "type": "text",
      "text": "他にはありますか？",
      "quickReply": {
        "items": [
          {
            "type": "action",
            "imageUrl": "https://example.com/sushi.png",
            "action": {
              "type": "message",
              "label": "はい",
              "text": "はい"
            }
          },
          {
            "type": "action",
            "imageUrl": "https://example.com/tempura.png",
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
    {
      "type": "text",
      "text": "先週は#{weekly_total_wasting}円も無駄遣いをしましたね...
#{weekly_total_wasting}円はあなたの時給の何時間分ですか？
あなたの意志の弱さ故にその労働が無駄になったことに気づいてください...
悔い改めましょう。
お菓子: #{sweets.weekly_total_wasting}円
お酒: #{alcohols.weekly_total_wasting}円
ネットショッピング: #{online_shoppings.weekly_total_wasting}円
ギャンブル: #{gamblings.weekly_total_wasting}円
たばこ: #{cigarettes.weekly_total_wasting}円
ゲーム課金: #{games.weekly_total_wasting}円"
    }
  end
end
