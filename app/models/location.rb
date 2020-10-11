class Location < ApplicationRecord
  belongs_to :user
  has_many :logs, dependent: :destroy

  geocoded_by :name
  after_validation :geocode, if: :will_save_change_to_name?

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
  def data_to_display(log_size = nil)
    { name: name_to_display,
      spot: spot,
      weather_icon: fetch_weather_data["weather"][0]["icon"],
      num_logs: (log_size.nil? ? logs.size : log_size)
    }
  end
end
