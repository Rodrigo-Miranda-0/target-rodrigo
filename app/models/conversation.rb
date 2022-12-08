# == Schema Information
#
# Table name: conversations
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user1_id   :bigint           not null
#  user2_id   :bigint           not null
#
# Indexes
#
#  index_conversations_on_user1_id               (user1_id)
#  index_conversations_on_user1_id_and_user2_id  (user1_id,user2_id)
#  index_conversations_on_user2_id               (user2_id)
#
# Foreign Keys
#
#  fk_rails_...  (user1_id => users.id)
#  fk_rails_...  (user2_id => users.id)
#
class Conversation < ApplicationRecord
  belongs_to :user1, class_name: 'User'
  belongs_to :user2, class_name: 'User'

  has_many :messages, dependent: :destroy
end
