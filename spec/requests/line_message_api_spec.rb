require 'rails_helper'

RSpec.describe 'Message_api', type: :request do
  describe 'POST /wastings' do
    it 'Completed 200 OK ' do
      create(:user)
      post wastings_path, params: { message: { text: 'した' } }
      expect(response).to have_http_status(200)
    end
  end
end