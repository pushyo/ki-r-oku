class User < ActiveRecord::Base
  attr_accessor :password
  attr_accessible :name, :email, :password, :password_confirmation
  # Automatically create the virtual password 'password_confirmation'
  validates :password, :presence      => true,
                       :confirmation  => true,
                       :length        => { :within => 6..40 }

end
