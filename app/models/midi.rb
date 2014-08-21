class Midi < ActiveRecord::Base
	belongs_to :song

	has_attached_file :audio_file,
	  :url => "/system/:class/:attachment/:id/:style/:basename.:extension",
	  :path => ":rails_root/public/system/:class/:attachment/:id/:style/:basename.:extension"
  validates_attachment :audio_file,
 	 :content_type => { :content_type => [ 'application/mp3', 'application/x-mp3', 'application/force- 
download', 'audio/mpeg', 'audio/mp3' ]}
end
