require 'rails_helper'

describe 'Match Targets', type: :request do
  subject { post api_v1_targets_path, params:, headers:, as: :json }

  let!(:user) { create(:user) }
  let!(:another_user) { create(:user) }
  let(:headers) { another_user.create_new_auth_token }
  let(:topic) { create(:topic) }
  let!(:target) { create(:target, user:, location: "POINT (-63.59386082773612 -5.199173507365742)", topic:) }
  let(:title) { Faker::Lorem.word }
  let(:radius) { Faker::Number.number(digits: 3) }
  let(:params) do
    {
      target: {
        title:,
        radius:,
        topic_id: topic.id
      },
      latitude: -63.59386082773612,
      longitude: -5.199173507365742
    }
  end

  context 'when success' do
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

      it 'should not notify the owner of the created target' do
        expect { subject }.not_to change(ActionMailer::Base.deliveries, :count)
      end

      it 'should not create the conversation between the users' do
        expect { subject }.not_to change(Conversation, :count)
      end
    end

    context 'when the target is not in the radius' do
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
          longitude:
        }
      end
      let(:radius) { 1 }

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

    context 'when the target is in the radius but the topic is different' do
      let(:another_topic) { create(:topic) }
      let(:params) do
        {
          target: {
            title:,
            radius:,
            topic_id: another_topic.id
          },
          latitude: -63.59386082773612,
          longitude: -5.199173507365742
        }
      end

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

    context 'when the target is in the radius but the user is the same' do
      let(:another_user) { user }

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
end
