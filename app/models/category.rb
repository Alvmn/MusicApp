class Category < ActiveRecord::Base
  has_and_belongs_to_many :songs
  
  validates :name, uniqueness: true
  validates :name, presence: true
end
