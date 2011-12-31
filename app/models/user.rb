class User < ActiveRecord::Base
  attr_accessor :password
  #attr_accessible :name, :email, :password, :password_confirmation
  # Automatically create the virtual password 'password_confirmation'

  email_regex = /\A[a-z\d][\w+\-.]*@[a-z\d\-.]+\.[a-z]{2,4}\z/i

  validates :name,  :presence => true,
                    :length   => { :maximum => 50 }
  validates :email, :presence => true,
                    :format   => { :with => email_regex } 
  validates :password, :presence      => true,
                       :confirmation  => true,
                       :length        => { :within => 6..40 }

end
