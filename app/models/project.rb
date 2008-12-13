class Project < ActiveRecord::Base
  belongs_to :user
  has_many :hearts
  
  validates_presence_of :title, :link
  validates_format_of :link, :with => /^http:\/\//
  
  after_create :create_stub
  
  def create_stub
    self.stub = title.gsub(/\W+/, ' ').strip.downcase.gsub(/\ +/, '_') + "_#{id}"
    self.save!
  end
  
  def already_hearted?(user)
    return true if self.hearts.find(:first, :conditions => ['user_id = ?', user.id])
  end
  
  def belongs_to(user_id)
    puts self.user_id
    puts user_id
    return true if self.user_id == (user_id)
    false
  end
  
end
