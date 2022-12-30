# == Schema Information
#
# Table name: messages
#
#  id              :bigint           not null, primary key
#  content         :string
#  read            :boolean          default(FALSE)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  conversation_id :bigint           not null
#  user_id         :bigint           not null
#
# Indexes
#
#  index_messages_on_conversation_id  (conversation_id)
#  index_messages_on_user_id          (user_id)
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
