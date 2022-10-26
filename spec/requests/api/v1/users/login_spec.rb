require 'rails_helper'
require "rspec/json_expectations"

describe 'Login User', type: :request do
  subject { post '/api/v1/auth/sign_in', params:, as: :json }

  before(:each) do
    @current_user = FactoryBot.create(:user)
  end

  context 'Correctly login the user' do
    let(:params) do
      {
        email: @current_user.email,
        password: @current_user.password
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
          email: @current_user.email
        }
      )
    end
  end

  context 'Incorrectly login the user' do
    context 'Incorrect credentials' do
      let(:params) do
        {
          email: @current_user.email,
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
