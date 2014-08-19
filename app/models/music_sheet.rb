class MusicSheet < ActiveRecord::Base
  belongs_to :song

  validates :url, uniqueness: true
  validates :url, presence: true
end
