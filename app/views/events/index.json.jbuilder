json.array!(@events) do |event|
  json.extract! event, :id, :when, :where, :what, :remarks
  json.url event_url(event, format: :json)
end
