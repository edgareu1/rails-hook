class Location < ApplicationRecord
  belongs_to :user
  geocoded_by :name
  after_validation :geocode, if: :will_save_change_to_name?

  has_many :logs, dependent: :destroy

  def name_display
    site.empty? ? name : site
  end
end
