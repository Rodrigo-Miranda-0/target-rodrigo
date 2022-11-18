# == Schema Information
#
# Table name: targets
#
#  id         :bigint           not null, primary key
#  location   :geography        not null, point, 4326
#  radius     :integer          not null
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  topic_id   :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_targets_on_topic_id  (topic_id)
#  index_targets_on_user_id   (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (topic_id => topics.id)
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  longitude = Faker::Address.longitude
  latitude = Faker::Address.latitude
  factory :target do
    title { Faker::Lorem.word }
    radius { Faker::Number.number(digits: 3) }
    location { "POINT(#{longitude} #{latitude})" }
    topic { create(:topic) }
    user { create(:user) }
  end
end
