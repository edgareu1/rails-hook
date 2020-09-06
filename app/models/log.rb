require 'modules/moon-phase.rb'

class Log < ApplicationRecord
  include MoonPhase

  belongs_to :location
  belongs_to :user

  has_many :catches, dependent: :destroy
  has_many :fish, through: :catches

  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :location, presence: true
  
  validate :log_duration

  after_create :add_weather_data

  # Get the total number of fish caught in the Log
  def catch_count
    catches.inject(0) { |sum, catch| sum + catch.quantity }
  end

  # Returns a string of the Log site followed by it's tag_id (padded with zeros)
  # Ex: Sargo Rock #009
  def label
    "#{location.site} \##{sprintf '%03d', (tag_id)}"
  end

  private

  # Update the weather variables to the ones registered at the moment
  def add_weather_data
    weather_data = location.fetch_weather_data

    self.air_pressure = weather_data["main"]["pressure"]
    self.wind_speed = weather_data["wind"]["speed"]
    self.weather_icon = weather_data["weather"][0]["icon"]
    self.weather_description = weather_data["weather"][0]["description"]

    self.moon_phase = get_moon_phase(self.start_time)

    save
  end

  # Add validations to the Log duration
  def log_duration
    if start_time >= end_time
      errors.add(:end_date, "Log cannot end before it begins")
    elsif start_time + (9 * 60) + 1 >= end_time
      errors.add(:end_date, "Log cannot be less than 10min long")
    elsif start_time + (60 * 60 * 24) + 1 <= end_time
      errors.add(:end_date, "Log cannot be longer than 24h")
    end
  end
end
