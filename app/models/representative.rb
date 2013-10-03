require_relative '../../db/config'

class Representative < ActiveRecord::Base
# implement your Student model here
  #Different rows can't have the same email
  validates :email, :uniqueness => true

  #Emails must be formatted
  validates :email, :format => { :with => /\w+@\w+.\w{2,}/,
    :message => "Format your email properly. :D" }

  validates :phone, :format => { :with => /[\D*\d{1}]{10,}/,
    :message => "Format your phone number. :D" }

  
  

  def name
    "#{self.first_name} #{self.last_name}"
  end

  def age
    Time.now.year - self.birthday.to_s[0..3].to_i
  end
end
