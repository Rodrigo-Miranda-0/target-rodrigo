require 'rails_helper'

describe 'Destroy Target', type: :request do
  subject { delete api_v1_target_path(target), headers:, as: :json }

  let(:user) { create(:user) }
  let!(:target) { create(:target, user:) }
  let(:headers) { user.create_new_auth_token }

  context 'when success' do
    it 'should return a sucessfull response' do
      subject
      expect(response).to have_http_status(:no_content)
    end

    it 'should delete the target' do
      expect { subject }.to change(user.targets, :count).by(-1)
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

      it 'should not delete the target' do
        expect { subject }.not_to change(user.targets, :count)
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

    context 'with invalid target' do
      let(:target) { 0 }

      it 'should return an entity not found status' do
        subject
        expect(response).to have_http_status(:not_found)
      end

      it 'should return the error message (Target not found)' do
        subject
        expect(response.body).to include_json(
          error: "Couldn't find the record"
        )
      end
    end

    context 'with invalid user' do
      let(:user) { create(:user) }
      let(:target) { create(:target) }

      it 'should return an entity not found status' do
        subject
        expect(response).to have_http_status(:not_found)
      end

      it 'should not delete the target' do
        expect { subject }.not_to change(user.targets, :count)
      end

      it 'should return the error message (Target not found)' do
        subject
        expect(response.body).to include_json(
          error: "Couldn't find the record"
        )
      end
    end
  end
end
