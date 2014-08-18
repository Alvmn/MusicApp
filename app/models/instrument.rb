class Instrument < ActiveRecord::Base
	
  extend FriendlyId
  has_many :songs, :dependent => :destroy
	
  validates :name, presence: true
  validates :name, uniqueness: true

  friendly_id :name, use: :slugged
end
