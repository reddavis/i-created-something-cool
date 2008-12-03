require 'digest/sha1'
require 'md5'
class User < ActiveRecord::Base
  attr_accessor :password
  
  validates_confirmation_of :password
  validates_uniqueness_of :email
  
  has_many :projects
  
  after_create :create_stub
  
  def create_stub
    self.stub = name.gsub(/\W+/, ' ').strip.downcase.gsub(/\ +/, '_') + "_#{id}"
    self.save!
  end
  
  def avatar
    hash = MD5::md5(self.email)
    "http://www.gravatar.com/avatar/#{hash}?s=60"
  end
  
  def self.authenticate(email, password)
    user = User.find_by_email(email)
    if user
      given_password = encrypted_password(password, user.password_salt)
      if user.password_hash != given_password
        user = nil
      end
    end
    user
  end

  def password=(pwd)
    @password = pwd
    return if pwd.blank?
    create_salt
    self.password_hash = User.encrypted_password(self.password, self.password_salt)
  end
  
  private
  
  def self.encrypted_password(password, salt)
    string = password + salt
    Digest::SHA1.hexdigest(string)
  end
  
  def create_salt
    self.password_salt = self.object_id.to_s + rand(9999).to_s
  end
end
