require 'rails_helper'
require "rspec/json_expectations"

describe 'Create User', type: :request do
  subject { post '/api/v1/auth', params:, as: :json }

  let(:email)                 { 'test@test.com' }
  let(:password)              { '12345678' }
  let(:password_confirmation) { '12345678' }
  let(:gender)                { 'Male' }

  let(:params) do
    {
      email:,
      password:,
      password_confirmation:,
      gender:
    }
  end

  context 'Correctly register the user' do
    it 'should return status code (200)' do
      subject
      expect(response).to have_http_status(:ok)
    end

    it 'should add the user to the database' do
      expect { subject }.to change(User, :count).by(1)
    end

    it 'should return the user' do
      subject
      expect(response.body).to include_json(
        data: {
          email: 'test@test.com'
        }
      )
    end
  end

  context 'Incorrectly register the user' do
    context 'Incorrect credentials' do
      let(:password) { "87654321" }
      it 'should return status code (422)' do
        subject
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'should not add the user to the database' do
        expect { subject }.to change { User.count }.by(0)
      end

      it 'should return the error message (Password match)' do
        subject
        expect(response.body).to include_json(
          errors: {
            full_messages: [
              "Password confirmation doesn't match Password"
            ]
          }
        )
      end
    end
    context 'Incorrect email' do
      let(:email) { "notAnEmail" }
      it 'should return status code (422)' do
        subject
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'should not add the user to the database' do
        expect { subject }.to change { User.count }.by(0)
      end

      it 'should return the error message (Email format)' do
        subject
        expect(response.body).to include_json(
          errors: {
            full_messages: [
              "Email is not an email"
            ]
          }
        )
      end
    end
  end
end
