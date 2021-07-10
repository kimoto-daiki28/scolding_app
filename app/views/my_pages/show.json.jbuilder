json.array!(@events) do |event|
  json.extract! event, :id, :name, :price
  json.start event.created_at
  json.title "#{event.name}：#{event.price}円"
  json.allDay true
  json.url wasting_url(event)
end