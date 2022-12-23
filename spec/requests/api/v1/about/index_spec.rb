require 'rails_helper'

describe 'GET about', type: :request do
  subject { get api_v1_about_index_path, headers:, as: :json }

  let(:user) { create(:user) }
  let!(:about) { create(:about) }

  it 'returns about' do
    subject
    result = JSON.parse(response.body)
    expect(result["content"]).to eq(about.content)
  end
end
