json.array!(@polls) do |poll|
  json.extract! poll, :id, :question, :is_closed, :closed_date
  json.url poll_url(poll, format: :json)
end
