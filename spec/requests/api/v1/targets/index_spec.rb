require 'rails_helper'

describe 'Get targets', type: :request do
  subject { get api_v1_targets_path, headers:, as: :json }

  let(:user) { create(:user) }
  let(:another_user) { create(:user) }
  let(:headers) { user.create_new_auth_token }
  let!(:targets) { create_list(:target, 3, user:) }
  let!(:another_targets) { create_list(:target, 3, user: another_user) }
  context 'when user is logged in' do
    it 'returns all user targets' do
      subject
      result = JSON.parse(response.body)
      expect(result['targets'].pluck('title')).to match_array(targets.pluck(:title))
    end

    it 'returns only logged user targets' do
      subject
      result = JSON.parse(response.body)
      expect(result['targets'].pluck('title')).not_to match_array(another_targets.pluck(:title))
    end
  end

  context 'when user is not logged in' do
    let(:headers) { {} }

    it 'returns unauthorized' do
      subject
      expect(response).to have_http_status(:unauthorized)
    end
  end
end
