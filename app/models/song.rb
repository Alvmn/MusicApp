class Song < ActiveRecord::Base
  resourcify

  has_many :midis, :dependent => :destroy
  has_many :music_sheets, :dependent => :destroy
  has_many :videos, :dependent => :destroy
  has_many :comments, :dependent => :destroy
  # El :dependent => destroy es para que cuando se borre una song, se borren sus respectivos "hijos"
  belongs_to :instrument

  has_and_belongs_to_many :categories
  has_and_belongs_to_many :tags

  validates :title, presence: true
  validates :title, uniqueness: true

  extend FriendlyId
  friendly_id :title, use: :slugged

  has_attached_file :music_sheets, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :music_sheets, :content_type => /\Aimage\/.*\Z/
end
