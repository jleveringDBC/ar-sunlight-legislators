require_relative '../../db/config'

class Politician < ActiveRecord::Base
# implement your Student model here
  #Different rows can't have the same email
  validates :email, :uniqueness => true

  #Emails must be formatted
  validates :email, :format => { :with => /\w+@\w+.\w{2,}/,
    :message => "Format your email properly. :D" }

  # Make sure age is > 5
  # validates :age, :numericality => {:greater_than => 5}

  validates :phone, :format => { :with => /[\D*\d{1}]{10,}/,
    :message => "Format your phone number. :D" }

  has_one :state
  

  def name
    "#{self.first_name} #{self.last_name}"
  end

  def age
    Time.now.year - self.birthday.to_s[0..3].to_i
  end
end
