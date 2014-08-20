class MusicSheet < ActiveRecord::Base
  belongs_to :song
  
  has_attached_file :sheet_file,
	  :url => "/system/:class/:attachment/:id/:style/:basename.:extension",
	  :path => ":rails_root/public/system/:class/:attachment/:id/:style/:basename.:extension"
  validates_attachment :sheet_file,
 	 :content_type => { :content_type => ["image/jpeg", "image/gif", "image/png"] }
end
