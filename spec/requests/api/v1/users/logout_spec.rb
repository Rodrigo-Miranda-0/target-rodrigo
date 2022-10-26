require 'rails_helper'

describe 'Logout User', type: :request do
  subject { delete '/api/v1/auth/sign_out', headers:, as: :json }

  before(:each) do
    @current_user = FactoryBot.create(:user)
    @headers = @current_user.create_new_auth_token
  end

  context 'Correctly logout the user' do
    let(:headers) do
      {
        'access-token': @headers['access-token'],
        client: @headers['client'],
        uid: @headers['uid']
      }
    end

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
