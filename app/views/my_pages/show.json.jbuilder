json.array!(@wastings) do |wasting|
  json.extract! wasting, :id, :title
  json.start wasting.created_at
  json.end wasting.created_at
end