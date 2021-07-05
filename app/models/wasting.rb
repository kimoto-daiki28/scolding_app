class Wasting < ApplicationRecord
  belongs_to :user

  # validates :name, presence: true
  # validates :price, presence: true

  def self.first_quick_reply
    {
      "type": "text",
      "text": "本日は何か無駄遣いをしましたか？",
      "quickReply": {
        "items": [
          {
            "type": "action",
            "imageUrl": "https://example.com/sushi.png",
            "action": {
              "type": "message",
              "label": "した",
              "text": "した"
            }
          },
          {
            "type": "action",
            "imageUrl": "https://example.com/tempura.png",
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
            "imageUrl": "https://example.com/sushi.png",
            "action": {
              "type": "message",
              "label": "お菓子",
              "text": "お菓子"
            }
          },
          {
            "type": "action",
            "imageUrl": "https://example.com/tempura.png",
            "action": {
              "type": "message",
              "label": "お酒",
              "text": "お酒"
            }
          },
          {
            "type": "action",
            "imageUrl": "https://example.com/tempura.png",
            "action": {
              "type": "message",
              "label": "ネットショッピング",
              "text": "ネットショッピング"
            }
          },
          {
            "type": "action",
            "imageUrl": "https://example.com/tempura.png",
            "action": {
              "type": "message",
              "label": "ジュース",
              "text": "ジュース"
            }
          }
        ]
      }
    }
  end
end
