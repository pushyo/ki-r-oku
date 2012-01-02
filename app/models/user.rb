class User < ActiveRecord::Base
  # introduced in Rails 3.1, needs gem bcrypt-ruby, needs password_digest column,
  # provides password and password_confirmation
  has_secure_password

  email_regex = /\A[a-z\d][\w+\-.]*@[a-z\d\-.]+\.[a-z]{2,4}\z/i

  validates :name,      :presence => true,
                        :length   => { :maximum => 50 }
  validates :email,     :presence => true,
                        :format   => { :with => email_regex } 
  validates :password,  :length   => { :within => 6..40 }

end
