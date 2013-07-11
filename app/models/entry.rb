class Entry < ActiveRecord::Base
  acts_as_readable :on => :updated_at
  attr_accessible :abstract, :content, :title

  def self.search(search)
    if search
      find(:all, :conditions => ['abstract LIKE ?', "%#{search}%"])
    else
      find(:all, :order => "updated_at DESC")
    end
  end
end
