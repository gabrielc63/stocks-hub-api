require 'rails_helper'

RSpec.describe "Users", type: :request do
  let(:user) { create(:user, password: "password") }
  let(:token_class) { Class.new { extend JsonWebToken } }
  let(:json_body) { JSON.parse(response.body) }
  let(:token) do
    {  "Authorization": token_class.jwt_encode(user_id: user.id)  }
  end

  describe 'POST user#create' do
    it 'registers a new user' do
      post '/users', params: { user: { name: 'John Doe', username: 'johndoe', email: 'john@example.com', password: 'password' } }
      expect(response).to have_http_status(:created)
    end
  end

  describe "GET user#show" do
    context "correct params are passed" do

      before do
        get "/users/#{user.id}", headers: token
      end

      it "returns correct status" do
        expect(response).to have_http_status(200)
      end

      it 'returns the user id' do
        expect(json_body['id']).to eq(user.id)
      end

      it 'returns the email' do
        expect(json_body['email']).to eq(user.email)
      end
    end

    context "with empty params" do
      subject { get "/users/#{user.id}", headers: {"Authorization": ''}  }

      it "returns unauthorized status" do
        subject
        parsed_body = JSON.parse(response.body)
        expect(response).to have_http_status(:unauthorized)
        expect(parsed_body['errors']).to eql('Invalid user or password')
      end
    end

    context "with the wrong params" do
      subject { get user_path(user.id, format: :json, params: {}, headers: 'adf123asdf456' )  }

      it "returns unauthorized status" do
        subject
        parsed_body = JSON.parse(response.body)
        expect(response).to have_http_status(:unauthorized)
        expect(parsed_body['errors']).to eql('Invalid user or password')
      end
    end
  end
end
