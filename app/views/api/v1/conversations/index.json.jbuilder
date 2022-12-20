json.conversations @conversations.each do |conversation|
  json.id conversation.id
  json.user1_id conversation.user1_id
  json.user2_id conversation.user2_id
  json.created_at conversation.created_at
  json.updated_at conversation.updated_at
  json.unread_messages conversation.unread_messages(current_user)
  json.last_message conversation.last_message
end
