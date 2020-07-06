class Location < ApplicationRecord
  belongs_to :user
  geocoded_by :name
  after_validation :geocode, if: :will_save_change_to_name?

  has_many :logs, dependent: :destroy

  validates :site, presence: true, uniqueness: true, :length => { :maximum => 12, :message => "Maximum of 12 characters"}
end
