class Project < ActiveRecord::Base
  belongs_to :user
  has_many :hearts
  
  validates_presence_of :title, :link
  
  after_create :create_stub
  
  def create_stub
    self.stub = title.gsub(/\W+/, ' ').strip.downcase.gsub(/\ +/, '_') + "_#{id}"
    self.save!
  end
  
  def already_hearted?(user)
    return true if self.hearts.find(:first, :conditions => ['user_id = ?', user.id])
  end
  
end
