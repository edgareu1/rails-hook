class Log < ApplicationRecord
  belongs_to :location
  belongs_to :user

  has_many :catches, dependent: :destroy
  has_many :fish, through: :catches

  validates :start_time, presence: true
  validates :end_time, presence: true
  validate :end_time_is_after_start_time

  validates :location, presence: true

  after_create :add_weather_data

  def catch_count
    sum = 0
    catches.each do |c|
      sum = sum + c.quantity
    end
    return sum
  end

  private

  def add_weather_data
    weather_data = Rails.configuration.open_weather_api.current lon: self.location.longitude , lat: self.location.latitude

    self.air_pressure = weather_data["main"]["pressure"]
    self.wind_speed = weather_data["wind"]["speed"]
    self.weather_icon = weather_data["weather"][0]["icon"]
    self.weather_description = weather_data["weather"][0]["description"]

    self.moon_phase = moon_calculation(self.start_time, self.end_time)

    save
  end

  def moon_calculation(start_time, end_time)
    new_moon_base = Time.new(2020, 06, 21, 6, 41, 00)
    moon_cycle = 29.5 * 60 * 60 * 24
    average_time = start_time + ((end_time - start_time) / 2)

    time_past_new_moon = (average_time - new_moon_base) % moon_cycle
    moon_percentage = (time_past_new_moon / moon_cycle)

    if moon_percentage < 0.5
      return moon_percentage * 2
    else
      return (1 - moon_percentage) * 2
    end
  end

  def end_time_is_after_start_time
    if end_time <= start_time + ((9 * 60) + 1)
      errors.add(:end_date, "Log cannot be less than 10min long")
    end
  end
end
