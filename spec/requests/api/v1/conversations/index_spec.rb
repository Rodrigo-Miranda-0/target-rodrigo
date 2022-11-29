require 'rails_helper'

describe 'GET conversations', type: :request do
  subject { get api_v1_conversations_path, headers:, as: :json }

  let(:user) { create(:user) }
  let(:another_user) { create(:user) }
  let!(:conversation) { create(:conversation, user1_id: user.id, user2_id: another_user.id) }
  let(:headers) { user.create_new_auth_token }

  context 'when user is logged in' do
    it 'returns all user conversations' do
      subject
      result = JSON.parse(response.body)
      expect(result.pluck('id')).to match_array([conversation.id])
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
