module LineBot
  module Messages
    class WastingMessage
      include LineBot::Messages::Concern::Carouselable

      def send
        carousel('alter_text', [bubble])
      end

      def bubble
        {
          "type": "bubble",
          "body": {
            "type": "box",
            "layout": "vertical",
            "contents": [
              {
                "type": "text",
                "text": "本日は無駄遣いをしましたか？",
                "weight": "bold",
                "size": "xxl",
                "wrap": true,
                "align": "center"
              }
            ]
          },
          "footer": {
            "type": "box",
            "layout": "vertical",
            "spacing": "sm",
            "contents": [
              {
                "type": "button",
                "style": "link",
                "height": "sm",
                "action": {
                  "type": "uri",
                  "label": "した",
                  "uri": "https://linecorp.com"
                }
              },
              {
                "type": "button",
                "style": "link",
                "height": "sm",
                "action": {
                  "type": "uri",
                  "label": "してない",
                  "uri": "https://linecorp.com"
                }
              },
              {
                "type": "spacer",
                "size": "sm"
              }
            ],
            "flex": 0
          }
        }
      end
    end
  end
end