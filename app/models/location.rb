class Location < ApplicationRecord
  belongs_to :user, counter_cache: true
  has_many :logs, dependent: :destroy

  geocoded_by :name

  reverse_geocoded_by :latitude, :longitude do |obj, results|
    if geo = results.first
      obj.country = geo.country
      obj.country_code = geo.country_code.upcase
      obj.state = geo.state
      obj.city = geo.city
    end
  end

  after_validation :geocode
  after_validation :reverse_geocode

  validates :name, presence: true
  validates :spot, presence: true, length: { maximum: 16, message: "Maximum of 16 characters"}
  validates_uniqueness_of :spot, case_sensitive: false, scope: :user_id

  # Makes sure the name displayed isn't to long
  def name_to_display
    name.match(/^[^,]*/)[0][0..15].strip
  end

  # Gets the current Weather Data of the Location
  def fetch_weather_data
    Rails.configuration.open_weather_api.current lon: longitude, lat: latitude
  end

  # Gets the relevant information to be displayed on the Home page
  def data_to_display
    { instance: self,
      weather_icon: fetch_weather_data["weather"][0]["icon"]
    }
  end

  # Method that gets the Locations tag_id for the next Log
  def next_tag_id
    location_logs = logs

    return location_logs.empty? ? 1 : location_logs.max_by(&:tag_id).tag_id + 1
  end

  # Get the number of Fish caught in the Location
  def catch_count
    logs.inject(0) { |sum, log| sum + log.catch_count }
  end

  # Get the weight of Fish caught in the Location
  def catch_weight
    logs.inject(0) { |sum, log| sum + log.catch_weight }
  end
end
