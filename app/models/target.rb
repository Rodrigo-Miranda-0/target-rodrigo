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
class Target < ApplicationRecord
  belongs_to :topic
  belongs_to :user

  scope :by_topic, ->(topic_id) { where(topic_id:) }
  scope :not_by_user, ->(user_id) { where.not(user_id:) }
  scope :within_radius, ->(target) { where('ST_Distance(location, ?) < ?', target.location, target.radius) }

  validates :title, presence: true
  validates :radius, presence: true
  validates :location, presence: true

  MAX_TARGETS = 10
end
