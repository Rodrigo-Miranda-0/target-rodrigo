# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

AdminUser.find_or_create_by(email: "admin@example.com") do |admin|
  admin.password = "password"
  admin.password_confirmation = "password"
end

# Create hardcoded test users
user1 = User.find_or_create_by(email: "test1@test.com") do |user|
  user.password = "password"
  user.password_confirmation = "password"
  user.name = "Test User 1"
end

user2 = User.find_or_create_by(email: "test2@test.com") do |user|
  user.password = "password"
  user.password_confirmation = "password"
  user.name = "Test User 2"
end

user3 = User.find_or_create_by(email: "test3@test.com") do |user|
  user.password = "password"
  user.password_confirmation = "password"
  user.name = "Test User 3"
end

# Create hardcoded test topics
Topic.find_or_create_by(name: "Test Topic 1")

Topic.find_or_create_by(name: "Test Topic 2")

Topic.find_or_create_by(name: "Test Topic 3")

# Create hardcoded test targets

Target.find_or_create_by(title: "Test Target 1") do |target|
  target.user_id = user1.id
  target.topic_id = 1
  target.radius = 100
  target.location = "POINT(-58.3816 -34.6037)"
end

Target.find_or_create_by(title: "Test Target 2") do |target|
  target.user_id = user2.id
  target.topic_id = 2
  target.radius = 100
  target.location = "POINT(-58.3816 -34.6037)"
end

Target.find_or_create_by(title: "Test Target 3") do |target|
  target.user_id = user3.id
  target.topic_id = 3
  target.radius = 100
  target.location = "POINT(-58.3816 -34.6037)"
end

# Create hardcoded test conversations

Conversation.find_or_create_by(user1_id: user1.id) do |conversation|
  conversation.user2_id = user2.id
end

Conversation.find_or_create_by(user1_id: user2.id) do |conversation|
  conversation.user2_id = user3.id
end

# Create hardcoded test messages

Message.find_or_create_by(content: "Test message 1") do |message|
  message.conversation_id = 1
  message.user_id = user1.id
end

Message.find_or_create_by(content: "Test message 2") do |message|
  message.conversation_id = 1
  message.user_id = user2.id
end

Message.find_or_create_by(content: "Test message 3") do |message|
  message.conversation_id = 2
  message.user_id = user2.id
end

Message.find_or_create_by(content: "Test message 4") do |message|
  message.conversation_id = 2
  message.user_id = user3.id
end

About.find_or_create_by(content: "About test")
