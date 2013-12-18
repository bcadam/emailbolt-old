json.array!(@bolts) do |bolt|
  json.extract! bolt, :id, :address, :user_id, :description
  json.url bolt_url(bolt, format: :json)
end
