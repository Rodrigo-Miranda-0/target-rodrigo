require 'rails_helper'

describe 'POST Target', type: :request do
  subject { post api_v1_targets_path, params:, headers:, as: :json }

  let(:user) { create(:user) }
  let!(:another_user) { create(:user, :with_targets) }
  let(:topic) { create(:topic) }
  let(:title) { Faker::Lorem.word }
  let(:radius) { Faker::Number.number(digits: 3) }
  let(:latitude) { Faker::Address.latitude }
  let(:longitude) { Faker::Address.longitude }
  let!(:target) { create(:target, user: another_user, location: "POINT (-63.59386082773612 -5.199173507365742)", topic:) }
  let(:params) do
    {
      target: {
        title:,
        radius:,
        topic_id: topic.id
      },
      latitude: -63.59386082773612,
      longitude: -5.199173507365742,
      user:
    }
  end
  let(:headers) { user.create_new_auth_token }

  context 'when success' do
    context 'non edge case' do
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
            topic_id: topic.id,
            user_id: user.id
          }
        )
      end
    end

    context 'edge case' do
      context 'when there are 9 targets' do
        let!(:targets) { create_list(:target, 9, user:) }
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
              topic_id: topic.id,
              user_id: user.id
            }
          )
        end
      end
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
      let(:headers) { another_user.create_new_auth_token }

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

  context 'when match' do
    it 'should return a sucessfull response' do
      subject
      expect(response).to have_http_status(:created)
    end

    it 'should notify the owner of the created target' do
      expect { subject }.to change(ActionMailer::Base.deliveries, :count).by(1)
    end

    it 'should create the conversation between the users' do
      expect { subject }.to change(Conversation, :count).by(1)
    end
  end

  context 'when no match' do
    let!(:target) { create(:target, user:, location: "POINT (0 0)", topic:) }
    it 'should return a sucessfull response' do
      subject
      expect(response).to have_http_status(:created)
    end

    it 'should not notify the owner of the created target' do
      expect { subject }.not_to change(ActionMailer::Base.deliveries, :count)
    end

    it 'should not create the conversation between the users' do
      expect { subject }.not_to change(Conversation, :count)
    end
  end
end
