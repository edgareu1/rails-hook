class Location < ApplicationRecord
  belongs_to :user
  has_many :logs, dependent: :destroy

  geocoded_by :name
  after_validation :geocode, if: :will_save_change_to_name?

  validates :name, presence: true
  validates :site, presence: true, length: { maximum: 20, message: "Maximum of 20 characters"}
  validates_uniqueness_of :site, case_sensitive: false, scope: :user_id

  # Makes sure the name displayed isn't to long
  def name_to_display
    name.match(/^[^,]*/)[0].truncate(18)
  end

  # Gets the current Weather Data of the Location
  def fetch_weather_data
    Rails.configuration.open_weather_api.current lon: longitude, lat: latitude
  end
end
