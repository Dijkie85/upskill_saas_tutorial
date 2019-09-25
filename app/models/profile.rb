class Profile < ActiveRecord::Base
    belongs_to :user
    
    has_attached_file :avatar, 
                      :styles => { :medium => "300x00>", :thumb => "100x100>" },
                      :default_url => "images/:style/missing.png"
    validates_attachment_content_style :avatar, :content_type => /\Aimage\/.*\Z/
end
