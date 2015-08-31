
class InvalidPrompaTokenException < StandardError
  def initialize(data)
    @data = data
  end
end

class PrompaApi

  def initialize url
    @base_url = url
  end

  def authorize token
    @token = token
    get_user(1)
  end

  def get_users
    @response = HTTParty.get "#{@base_url}/users?authentication_token=#{@token}"
    validate_responce
  end

  def get_user user_id
    @response = HTTParty.get "#{@base_url}/users/#{user_id}?authentication_token=#{@token}"
    validate_responce
  end



  def validate_responce
    if @response.include?("errors")
      @response = nil
      raise InvalidPrompaTokenException.new(token: "invalid")
    end
    return @response
  end


end
