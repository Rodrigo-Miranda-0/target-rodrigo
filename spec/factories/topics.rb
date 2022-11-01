# == Schema Information
#
# Table name: topics
#
#  id         :bigint           not null, primary key
#  image      :string
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  test_image = Base64.encode64(File.binread("spec/fixtures/test_image.png"))
  factory :topic do
    name { Faker::Lorem.word }
    image { { io: StringIO.new(test_image), filename: "test_image.png", content_type: "image/png" } }
  end
end
