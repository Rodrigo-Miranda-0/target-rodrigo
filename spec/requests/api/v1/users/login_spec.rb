require 'rails_helper'

describe 'Login User', type: :request do
  subject { post user_session_path, params:, as: :json }

  let!(:user) { create(:user) }

  context 'when success' do
    let(:params) do
      {
        email: user.email,
        password: user.password
      }
    end

    it 'should return a sucessfull response' do
      subject
      expect(response).to have_http_status(:ok)
    end

    it 'should return the user' do
      subject
      expect(response.body).to include_json(
        data: {
          email: user.email
        }
      )
    end
  end

  context 'when fails' do
    context 'with invalid credentials' do
      let(:params) do
        {
          email: user.email,
          password: "12345678"
        }
      end

      it 'should return an unprocessable entity status' do
        subject
        expect(response).to have_http_status(:unauthorized)
      end

      it 'should return the error message (Invalid credentials)' do
        subject
        expect(response.body).to include_json(
          errors: [
            "Invalid login credentials. Please try again."
          ]
        )
      end
    end
  end
end
