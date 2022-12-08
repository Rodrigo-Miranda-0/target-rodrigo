json.messages @messages.each do |message|
  json.content message.content
  json.user_id message.user_id
end
