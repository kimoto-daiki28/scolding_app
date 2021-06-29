class LineClient < ApplicationRecord

  def self.first_quick_reply
    {
      "type": "text",
      "text": "Select your favorite food category or send me your location!",
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
      "text": "Select your favorite food category or send me your location!",
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
