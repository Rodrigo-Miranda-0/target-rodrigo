require 'rails_helper'

describe 'GET about', type: :request do
  subject { get api_v1_about_index_path, headers:, as: :json }

  let(:user) { create(:user) }
  let(:headers) { user.create_new_auth_token }
  let!(:about) { create(:about) }

  context 'when user is logged in' do
    it 'returns about' do
      subject
      result = JSON.parse(response.body)
      expect(result["content"]).to eq(about.content)
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
