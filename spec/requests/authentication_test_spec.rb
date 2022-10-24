# require 'rails_helper'
# include ActionController::RespondWith

# describe 'Authentication', type: :request do
#   before(:each) do
#     @current_user = FactoryBot.create(:user)
#   end

#   context 'Correctly register the user' do
#     it 'should return status code (200)' do
#       post '/auth', params: { email: 'test123@gmail.com', password: '12345678', password_confirmation: '12345678', gender: 'Male' }
#       expect(response).to have_http_status(:ok)
#     end

#     it 'should add the user to the database' do

#     it 'should not register the current user (Incorrect credentials)' do
#       post '/auth', params: { email: @current_user.email, password: @current_user.password, password_confirmation: '12345678', gender: @current_user.gender }
#       expect(response).to have_http_status(:unprocessable_entity)
#     end

#     it 'should not register the current user (Incorrect email)' do
#       post '/auth', params: { email: 'notAnEmail', password: @current_user.password, password_confirmation: @current_user.password, gender: @current_user.gender }
#       expect(response).to have_http_status(:unprocessable_entity)
#     end
#   end

#   context 'User login' do
#     it 'should login the current user (Correct credentials)' do
#       post '/auth/sign_in', params: { email: @current_user.email, password: @current_user.password }
#       puts response.body
#       expect(response).to have_http_status(:ok)
#     end

#     it 'should not login the current user (Incorrect credentials)' do
#       post '/auth/sign_in', params: { email: @current_user.email, password: '12345678' }
#       expect(response).to have_http_status(:unauthorized)
#     end

#     it 'should not login the current user (Incorrect email)' do
#       post '/auth/sign_in', params: { email: 'notAnEmail', password: @current_user.password }
#       expect(response).to have_http_status(:unauthorized)
#     end
#   end
# end
