require 'rails_helper'

describe 'POST Message', type: :request do
  subject { post api_v1_messages_path(conversation_id:), params:, headers:, as: :json }

  let(:user1) { create(:user) }
  let(:user2) { create(:user) }
  let(:user3) { create(:user) }
  let(:conversation_id) { create(:conversation, user1:, user2:).id }
  let(:headers) { user1.create_new_auth_token }
  let(:content) { Faker::Lorem.sentence }
  let(:params) do
    {
      message: {
        content:
      }
    }
  end

  context 'when success' do
    it 'should return a sucessfull response' do
      subject
      expect(response).to have_http_status(:created)
    end

    it 'should add the message to the database' do
      expect { subject }.to change(Message, :count).by(1)
    end

    it 'should return the message' do
      subject
      expect(response.body).to include_json(
        {
          content:,
          user_id: user1.id
        }
      )
    end
  end

  context 'when fails' do
    context 'when the user is not part of the conversation' do
      let(:headers) { user3.create_new_auth_token }

      it 'should return a bad request response' do
        subject
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'should not add the message to the database' do
        expect { subject }.not_to change(Message, :count)
      end

      it 'should return the error message' do
        subject
        expect(response.body).to include_json(
          {
            error: 'The conversation you are trying to access is invalid'
          }
        )
      end
    end

    context 'when the conversation does not exist' do
      let(:conversation_id) { 1000 }

      it 'should return a bad request response' do
        subject
        expect(response).to have_http_status(:not_found)
      end

      it 'should not add the message to the database' do
        expect { subject }.not_to change(Message, :count)
      end

      it 'should return the error message' do
        subject
        expect(response.body).to include_json(
          {
            error: "Couldn't find the record"
          }
        )
      end
    end
  end
end
