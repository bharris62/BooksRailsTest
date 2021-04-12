require 'rails_helper'

describe 'Authentication', type: :request do
  describe "POST /authenticate" do
    let(:user) { FactoryBot.create(:user, username: 'BookSeller99') }
    it 'should authenticate the client' do
      post '/api/v1/authenticate', params: { username: user.username, password: 'Password1' }

      expect(response).to have_http_status(:created)
      expect(response_body).to eq({
                                    'token' => '123'
                                  })

    end

    it 'should return error when username is missing' do
      post '/api/v1/authenticate', params: { password: 'Password1' }
      expect(response).to have_http_status(:unprocessable_entity)

    end

    it 'should return error when password is missing' do
      post '/api/v1/authenticate', params: { username: 'BookSeller99' }
      expect(response).to have_http_status(:unprocessable_entity)
    end

  end
end