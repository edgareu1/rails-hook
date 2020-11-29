class Location < ApplicationRecord
  include ApplicationHelper
  include MoonPhaseHelper

  belongs_to :user, counter_cache: true
  has_many :logs, dependent: :destroy

  after_validation :geocode, :reverse_geocode, if: Proc.new { |loc| !loc.name.blank? && loc.name_changed? }

  geocoded_by :name

  reverse_geocoded_by :latitude, :longitude do |loc, results|
    if !(loc.longitude_changed? || loc.latitude_changed?)
      raise LocationsController::NonExistentNameError, "does not exist"

    elsif geo = results.first
      loc.country = geo.country
      loc.country_code = geo.country_code.upcase
      loc.state = geo.state
      loc.city = geo.city
    end
  end

  validates :name, presence: true
  validates :spot, presence: true,
                   length: { maximum: 16 },
                   uniqueness: { case_sensitive: false, scope: :user_id }

  # Method that gets a personalized address to display
  def address_to_display
    (city || name).strip.truncate(20)
  end

  # Method that gets a hash with the current weather data
  def weather_data
    weather_data = fetch_weather_data

    return {
      weather_icon:         weather_data["weather"].first["icon"],
      weather_description:  weather_data["weather"].first["description"],
      temperature:          kelvin_to_celcius(weather_data["main"]["temp"]).round(1),
      air_pressure:         weather_data["main"]["pressure"].round,
      wind_speed:           weather_data["wind"]["speed"].round(1),
      moon_phase:           get_moon_phase(Time.now).round(2)
    }
  end

  # Method that gets the tag_id for the next Log
  def next_tag_id
    logs.empty? ? 1 : logs.max_by(&:tag_id).tag_id + 1
  end

  # Method that increments the catches counters
  def increment_catches_counters(quantity:, weight:)
    self.increment!(:catches_count, quantity)
    self.increment!(:catches_weight, weight)
  end

  # Method that decrements the catches counters
  def decrement_catches_counters(quantity:, weight:)
    self.decrement!(:catches_count, quantity)
    self.decrement!(:catches_weight, weight)
  end

  private

  # Method that gets the current weather via API
  def fetch_weather_data
    Rails.configuration.open_weather_api.current(lon: longitude, lat: latitude)
  end
end
