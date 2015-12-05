class Entry < ActiveRecord::Base
  acts_as_readable :on => :updated_at
  attr_accessible :abstract, :content, :title, :important

  def self.search(search)
    if search
      #find(:all, :conditions => ['abstract LIKE ? OR content LIKE ?', "%#{search}%", "%#{search}%"])
    else
      #find(:all, :order => "updated_at DESC")
      find(:all, :order => "important DESC, updated_at DESC")
    end
  end
end
