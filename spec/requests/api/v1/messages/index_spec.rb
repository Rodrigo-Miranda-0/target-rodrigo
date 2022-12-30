require 'rails_helper'

describe 'GET messages' do
  subject { get api_v1_messages_path(conversation_id: conversation.id, page:), headers:, as: :json }

  let(:user) { create(:user) }
  let(:user2) { create(:user) }
  let(:user3) { create(:user) }
  let(:conversation) { create(:conversation, user1: user, user2:) }
  let!(:messages) { create_list(:message, 15, conversation:, user:) }
  let(:headers) { user.create_new_auth_token }
  let(:page) { 1 }

  context 'when success' do
    it 'should return a sucessfull response' do
      subject
      expect(response).to have_http_status(:ok)
    end

    it 'should return the messages paginated' do
      subject
      expect(ActiveSupport::JSON.decode(response.body)["messages"].count).to eq(10)
    end

    context 'rest of the pages' do
      let(:page) { 2 }

      it 'should return the messages paginated' do
        subject
        expect(ActiveSupport::JSON.decode(response.body)["messages"].count).to eq(5)
      end
    end
  end

  context 'when fails' do
    context 'when the user is not part of the conversation' do
      let(:headers) { user3.create_new_auth_token }

      it 'should return a bad request response' do
        subject
        expect(response).to have_http_status(:unauthorized)
      end

      it 'should return the error message' do
        subject
        expect(response.body).to include_json(
          {
            error: 'You are not authorized to access this resource'
          }
        )
      end
    end
  end
end
