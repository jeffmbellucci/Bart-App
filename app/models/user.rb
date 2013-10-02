class User < ActiveRecord::Base
  attr_accessible :name, :phone_number, :email
  
  validates :name, presence: true,
                   length: {maximum: 12}
                   
  validates :phone_number, uniqueness: true, 
                           length: { is: 13 }
                           
  VALID_EMAIL_REGEX = /^(|(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6})$/i
  validates :email, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: true,
                    presence: true
      
  has_many :reminders
  
   def create_session_token  
     token = SecureRandom.urlsafe_base64  
     self.session_token = token
     self.save!
     token
   end
   
end
