require 'rails_helper'

describe 'Create Target', type: :request do
  subject { post api_v1_targets_path, params:, headers:, as: :json }

  let(:user) { create(:user) }
  let!(:user2) { create(:user, :with_targets) }
  let(:topic) { create(:topic) }
  let(:title) { Faker::Lorem.word }
  let(:radius) { Faker::Number.number(digits: 3) }
  let(:latitude) { Faker::Address.latitude }
  let(:longitude) { Faker::Address.longitude }
  let(:params) do
    {
      target: {
        title:,
        radius:,
        topic_id: topic.id
      },
      latitude:,
      longitude:,
      user:
    }
  end
  let(:headers) { user.create_new_auth_token }

  context 'when success' do
    it 'should return a sucessfull response' do
      subject
      expect(response).to have_http_status(:created)
    end

    it 'should add the target to the database' do
      expect { subject }.to change(Target, :count).by(1)
    end

    it 'should return the target' do
      subject
      expect(response.body).to include_json(
        {
          title:,
          radius:,
          location:
          {
            x: latitude,
            y: longitude
          },
          topic_id: topic.id,
          user_id: user.id
        }
      )
    end
  end

  context 'when fails' do
    context 'with invalid credentials' do
      let(:title) { nil }
      it 'should return an unprocessable entity status' do
        subject
        expect(response).to have_http_status(:bad_request)
      end

      it 'should not add the target to the database' do
        expect { subject }.not_to change(Target, :count)
      end

      it 'should return the error message (Title cant be blank)' do
        subject
        expect(response.body).to include_json(
          errors: {
            title: [
              "can't be blank"
            ]
          }
        )
      end
    end

    context 'with max targets reached' do
      let(:headers) { user2.create_new_auth_token }

      it 'should return an unprocessable entity status' do
        subject
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'should not add the target to the database' do
        expect { subject }.not_to change(Target, :count)
      end

      it 'should return the error message (Max targets reached)' do
        subject
        expect(response.body).to include_json(
          error: 'Maximum number of targets reached'
        )
      end
    end
  end
end
