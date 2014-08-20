class Song < ActiveRecord::Base
  resourcify

  has_many :midis, :dependent => :destroy
  has_many :music_sheets, :dependent => :destroy
  has_many :videos, :dependent => :destroy
  has_many :comments, dependent: :destroy
  # El :dependent => destroy es para que cuando se borre una song, se borren sus respectivos "hijos"
  belongs_to :instrument

  has_and_belongs_to_many :categories
  has_and_belongs_to_many :tags

  validates :title, presence: true
  validates :title, uniqueness: true

  extend FriendlyId
  friendly_id :title, use: :slugged

  has_attached_file :music_sheets,
  :url => "/system/:class/:attachment/:id/:style/:basename.:extension",
  :path => ":rails_root/public/system/:class/:attachment/:id/:style/:basename.:extension"
  validates_attachment :music_sheets,
  :content_type => { :content_type => ["image/jpeg", "image/gif", "image/png"] }

  accepts_nested_attributes_for :tags, allow_destroy: true
  accepts_nested_attributes_for :categories, allow_destroy: true
end
