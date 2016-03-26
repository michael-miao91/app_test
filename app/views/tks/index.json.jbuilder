json.array!(@tks) do |tk|
  json.extract! tk, :id, :title, :content
  json.url tk_url(tk, format: :json)
end
