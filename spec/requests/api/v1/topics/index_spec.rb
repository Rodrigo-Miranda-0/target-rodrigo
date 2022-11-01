require 'rails_helper'

describe 'Get topics', type: :request do
  subject { get api_v1_topic_index_path, headers:, as: :json }

  let(:user) { create(:user) }
  let(:headers) { user.create_new_auth_token }
  let!(:topics) { create_list(:topic, 3) }

  context 'when user is logged in' do
    it 'returns all topics' do
      subject
      result = JSON.parse(response.body)
      expect(result['topics'].pluck('name')).to match_array(topics.pluck(:name))
    end
  end

  context 'when user is not logged in' do
    let(:headers) { {} }

    it 'returns unauthorized' do
      subject
      expect(response).to have_http_status(:unauthorized)
    end
  end
end
