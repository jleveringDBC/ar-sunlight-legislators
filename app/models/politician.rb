require_relative '../../db/config'

class Politician < ActiveRecord::Base
# implement your Student model here
  #Different rows can't have the same email
  #validates :webform, :uniqueness => true

  #Emails must be formatted
  #validates :webform, :format => { :with => /\w+@\w+.\w{2,}/,
  #  :message => "Format your email properly. :D" }

  validates :phone, :format => { :with => /[\D*\d{1}]{10,}/,
    :message => "Format your phone number. :D" }

  
  

  def name
    "#{self.firstname} #{self.lastname}"
  end

  def age
    Time.now.year - self.birthday.to_s[0..3].to_i
  end
end
