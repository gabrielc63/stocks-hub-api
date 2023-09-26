require 'rails_helper'

RSpec.describe 'Authentication', type: :request do
  describe 'POST /login' do
    let!(:user) { create(:user, email: 'user@example.com', password: 'password') }

    it 'logs in an existing user' do
      post '/auth/login', params: { email: 'user@example.com', password: 'password' }
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)).to have_key('token')
    end

    it 'returns unauthorized for invalid login' do
      post '/auth/login', params: { email: 'user@example.com', password: 'wrong_password' }
      expect(response).to have_http_status(:unauthorized)
    end
  end
end
