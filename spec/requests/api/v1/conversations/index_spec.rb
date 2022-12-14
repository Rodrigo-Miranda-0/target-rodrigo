require 'rails_helper'

describe 'GET conversations', type: :request do
  subject { get api_v1_conversations_path, headers:, as: :json }

  let(:user) { create(:user) }
  let(:another_user) { create(:user) }
  let!(:conversation) { create(:conversation, user1_id: user.id, user2_id: another_user.id) }
  let!(:messages) { create_list(:message, 3, conversation:, user:) }
  let!(:messages2) { create_list(:message, 6, conversation:, user: another_user) }
  let(:headers) { user.create_new_auth_token }

  context 'when user is logged in' do
    context 'and hasnt read any messages' do
      it 'returns all user conversations' do
        subject
        result = JSON.parse(response.body)
        expect(result["conversations"].pluck('id')).to match_array([conversation.id])
      end

      it 'returns all user conversations with unread messages' do
        subject
        result = JSON.parse(response.body)
        expect(result["conversations"].pluck('unread_messages')).to match_array([6])
      end

      it 'returns all user conversations with last message' do
        subject
        result = JSON.parse(response.body)
        expect(result["conversations"].pluck('last_message').pluck('id')).to match_array([messages2.last.id])
      end
    end

    context 'and has read some messages' do
      before do
        messages2[0].read = true
        messages2[0].save
      end

      it 'returns all user conversations with unread messages' do
        subject
        result = JSON.parse(response.body)
        expect(result["conversations"].pluck('unread_messages')).to match_array([5])
      end
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
