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
require 'rails_helper'

describe 'Topic', type: :model do
  describe 'Validations' do
    subject { build :topic }
    context 'validations' do
      it { is_expected.to validate_presence_of(:name) }
    end
  end
end
