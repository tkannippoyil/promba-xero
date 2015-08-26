class PrompaApi

  def initialize url
    @base_url = url
  end

  def authorize token
    @token = token
  end

  def get_users
    HTTParty.get "#{@base_url}/users?authentication_token=#{@token}"
  end



end