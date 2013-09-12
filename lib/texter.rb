
  
  @account_sid = ENV['TWILIO_ACCOUNT_SID']
  @auth_token = ENV['TWILIO_AUTH_TOKEN']

  # set up a client to talk to the Twilio REST API
  @client = Twilio::REST::Client.new(@account_sid, @auth_token)
  @account = @client.account
  
  @message = @account.sms.messages.create({from: '16503535181',
                                               to: '(650)776-4854',
                                               body: "Hanging out at...\n your mom's house..."})
  


