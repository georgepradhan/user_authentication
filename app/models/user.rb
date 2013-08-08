require 'bcrypt'

class User < ActiveRecord::Base
  include BCrypt
  
  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

  def password
    @password ||= Password.new(password_hash)
  end

  def self.authenticate(email, password)    
    u = self.find_by_email(email)
    if u.password == password
      return u
    else
      nil
    end
  end
end
