class Text
  
  def initialize(phone_number, message)
  
    @phone_number = phone_number
    @message = message
    
    @account_sid = ENV['TWILIO_ACCOUNT_SID']
    @auth_token = ENV['TWILIO_AUTH_TOKEN']
    @client = Twilio::REST::Client.new(@account_sid, @auth_token)
    @account = @client.account
    # set up a client to talk to the Twilio REST API
  end
  
  def send
    @message = @account.sms.messages.create({from: '16503535181',
                                             to: @phone_number,
                                             body: @message})
  end
end

