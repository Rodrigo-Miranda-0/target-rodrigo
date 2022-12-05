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
User.find_or_create_by(email: "test1@test.com") do |user|
  user.password = "password"
  user.password_confirmation = "password"
  user.name = "Test User 1"
end

User.find_or_create_by(email: "test2@test.com") do |user|
  user.password = "password"
  user.password_confirmation = "password"
  user.name = "Test User 2"
end

User.find_or_create_by(email: "test3@test.com") do |user|
  user.password = "password"
  user.password_confirmation = "password"
  user.name = "Test User 3"
end
