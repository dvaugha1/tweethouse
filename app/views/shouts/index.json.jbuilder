json.array!(@shouts) do |shout|
  json.extract! shout, :id, :title, :body
  json.url shout_url(shout, format: :json)
end
