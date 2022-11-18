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
require 'rails_helper'

describe 'Target', type: :model do
  subject { build :target }
  context 'validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:radius) }
    it { is_expected.to validate_presence_of(:location) }
    it { should belong_to(:topic) }
    it { should belong_to(:user) }
  end
end
