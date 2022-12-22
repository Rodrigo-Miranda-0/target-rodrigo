require 'rails_helper'

describe 'POST api_v1_tickets', type: :request do
  subject { post api_v1_tickets_path, params:, headers:, as: :json }
  let(:user) { create(:user) }
  let(:admin_user) { create(:admin_user) }
  let(:email) { admin_user.email }
  let(:message) { 'I need your help!' }
  let(:headers) { user.create_new_auth_token }
  let(:params) do
    {
      email:,
      message:
    }
  end

  context 'when success' do
    it 'should return a successful response' do
      subject
      expect(response).to have_http_status(:created)
    end

    it 'should return confirmation message' do
      subject
      expect(response.body).to include_json(
        {
          message: I18n.t('api.v1.tickets.success')
        }
      )
    end

    it 'should send an email to the admin user' do
      expect { subject }.to change { ActionMailer::Base.deliveries.count }.by(1)
      expect(ActionMailer::Base.deliveries.last.to).to include(email)
    end

    it 'should send an email with the correct subject' do
      subject
      expect(ActionMailer::Base.deliveries.last.subject).to eq(I18n.t('mailer.ticket.subject'))
    end

    it 'should send an email with the correct content' do
      subject
      expect(ActionMailer::Base.deliveries.last.body).to include(message)
    end
  end

  context 'when fails' do
    context 'when the email is not registered' do
      let(:email) { '123' }

      it 'should return a bad request response' do
        subject
        expect(response).to have_http_status(:bad_request)
      end

      it 'should return an error message' do
        subject
        expect(response.body).to include_json(
          {
            error: I18n.t('api.v1.tickets.error')
          }
        )
      end

      it 'should not send an email' do
        expect { subject }.not_to change(ActionMailer::Base.deliveries, :count)
      end
    end
  end
end
