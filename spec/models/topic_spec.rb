require 'rails_helper'

describe 'Topic', type: :model do
  describe 'Validations' do
    subject { build :topic }
    it { is_expected.to validate_presence_of(:name) }
  end
end
