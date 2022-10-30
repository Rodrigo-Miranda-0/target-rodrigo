require 'rails_helper'

describe 'Topic', type: :model do
  describe 'Validations' do
    subject { build :user }
    it { is_expected.to validate_presence_of(:email) }
  end
end
