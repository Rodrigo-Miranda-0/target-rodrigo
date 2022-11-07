require 'rails_helper'

describe 'Get targets', type: :request do
  subject { get api_v1_targets_path, headers:, as: :json }

  let(:user) { create(:user) }
  let(:headers) { user.create_new_auth_token }
  let!(:targets) { create_list(:target, 3, user:) }

  context 'when user is logged in' do
    it 'returns all targets' do
      subject
      result = JSON.parse(response.body)
      expect(result['targets'].pluck('title')).to match_array(targets.pluck(:title))
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
