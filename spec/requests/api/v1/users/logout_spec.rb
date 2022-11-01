require 'rails_helper'

describe 'Logout User', type: :request do
  subject { delete destroy_user_session_path, headers:, as: :json }

  let(:user) { create(:user) }
  let(:headers) { user.create_new_auth_token }

  context 'when success' do
    it 'should return a sucessfull response' do
      subject
      expect(response).to have_http_status(:ok)
    end
  end

  context 'when fails' do
    context 'with invalid credentials' do
      let(:headers) do
        {
          'access-token': '12345678',
          client: '12345678',
          uid: '12345678'
        }
      end

      it 'should return an entity not found status' do
        subject
        expect(response).to have_http_status(:not_found)
      end

      it 'should return the error message (User not found)' do
        subject
        expect(response.body).to include_json(
          errors: [
            "User was not found or was not logged in."
          ]
        )
      end
    end
  end
end
