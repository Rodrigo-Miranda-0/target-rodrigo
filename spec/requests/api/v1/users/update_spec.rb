require 'rails_helper'

describe 'Update User', type: :request do
  subject { put api_v1_user_path(user), params:, headers:, as: :json }

  let(:user) { create(:user) }
  let(:another_user) { create(:user) }
  let(:headers) { user.create_new_auth_token }
  let(:params) do
    {
      name: 'John',
      lastname: 'Doe'
    }
  end

  context 'when success' do
    it 'should return a sucessfull response' do
      subject
      expect(response).to have_http_status(:ok)
    end

    it 'should return the user updated' do
      subject
      expect(response.body).to include_json(
        name: 'John',
        lastname: 'Doe'
      )
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

      it 'should return an unauthorized status' do
        subject
        expect(response).to have_http_status(:unauthorized)
      end

      it 'should return the error message (User not found)' do
        subject
        expect(response.body).to include_json(
          errors: [
            "You need to sign in or sign up before continuing."
          ]
        )
      end
    end

    context 'with invalid user' do
      let(:headers) { another_user.create_new_auth_token }

      it 'should return an unauthorized status' do
        subject
        expect(response).to have_http_status(:unauthorized)
      end

      it 'should return the error message (Uanuthorized)' do
        subject
        expect(response.body).to include_json(
          error: "You are not authorized to access this resource"
        )
      end
    end
  end
end
