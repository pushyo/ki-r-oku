class User < ActiveRecord::Base
  attr_accessible :name, :email, :password, :password_confirmation
  # introduced in Rails 3.1, needs gem bcrypt-ruby, needs password_digest column,
  # provides password and password_confirmation
  has_secure_password

  email_regex = /\A[a-z\d][\w+\-.]*@[a-z\d\-.]+\.[a-z]{2,4}\z/i

  validates :name,      :presence => true,
                        :length   => { :maximum => 50 }

  validates :email,     :presence => true,
                        :format   => { :with => email_regex } 

  validates :password,  :length   => { :within => 6..40 }

  def salt
    BCrypt::Password.new(password_digest).salt
  end

  def self.authenticate(email, password)
    User.find_by_email(email).try( :authenticate, password )
  end

  def self.authenticate_with_token(id, salt)
    user = User.find_by_id(id) #doesn't raise exception if id is nil
    return user if user && salt == user.salt
  end

end
