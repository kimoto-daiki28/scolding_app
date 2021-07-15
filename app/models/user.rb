class User < ApplicationRecord
  has_many :wastings, dependent: :destroy
  validates :name, presence: true, uniqueness: true
  validates :line_id, presence: true, uniqueness: true

  def self.line_login(code)
    uri = URI.parse('https://api.line.me/oauth2/v2.1/token')
    req = Net::HTTP::Post.new(uri)
    req.content_type = 'application/x-www-form-urlencoded'
    req.set_form_data(
      # 'client_id' => ENV['LINE_LOGIN_ID'],
      # 'client_secret' => ENV['LINE_LOGIN_SECRET'],
      'client_id' => ENV['DEVELOP_LINE_LOGIN_ID'],
      'client_secret' => ENV['DEVELOP_LINE_LOGIN_SECRET'],
      'code' => code,
      'grant_type' => 'authorization_code',
      # 'redirect_uri' => ENV['SITE_URL']
      'redirect_uri' => ENV['DEVELOP_SITE_URL']
    )
    req_options = {
      use_ssl: uri.scheme == 'https'
    }

    response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
      http.request(req)
    end

    result = JSON.parse(response.body)
    token = result['access_token']
    uri_2 = URI.parse('https://api.line.me/v2/profile')
    req_2 = Net::HTTP::Get.new(uri_2)
    req_2['authorization'] = "Bearer #{token}"
    req_options_2 = {
      use_ssl: uri_2.scheme == 'https'
    }
    response = Net::HTTP.start(uri_2.hostname, uri_2.port, req_options_2) do |http|
      http.request(req_2)
    end

    result = JSON.parse(response.body)
    user_id = result['userId']
    user_name = result['displayName']
    user = User.find_or_create_by(name: user_name, line_id: user_id)
    user.id
  end
end
