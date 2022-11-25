# == Schema Information
#
# Table name: messages
#
#  id              :bigint           not null, primary key
#  content         :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  conversation_id :bigint           not null
#  user_id         :bigint           not null
#
# Indexes
#
#  index_messages_on_conversation_id              (conversation_id)
#  index_messages_on_user_id                      (user_id)
#  index_messages_on_user_id_and_conversation_id  (user_id,conversation_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (conversation_id => conversations.id)
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

describe 'Message', type: :model do
  subject { build :message }
  context 'validations' do
    it { is_expected.to validate_presence_of(:content) }
    it { should belong_to(:conversation) }
    it { should belong_to(:user) }
  end
end
