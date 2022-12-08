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
#  index_conversations_on_user1_id_and_user2_id  (user1_id,user2_id) UNIQUE
#  index_conversations_on_user2_id               (user2_id)
#
# Foreign Keys
#
#  fk_rails_...  (user1_id => users.id)
#  fk_rails_...  (user2_id => users.id)
#
FactoryBot.define do
  factory :conversation do
    user1 { create(:user) }
    user2 { create(:user) }
  end
end
