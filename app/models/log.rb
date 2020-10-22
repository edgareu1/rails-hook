class Log < ApplicationRecord
  belongs_to :location, counter_cache: true
  belongs_to :user, counter_cache: true

  has_many :catches, dependent: :destroy
  has_many :fish, through: :catches

  validates :location, presence: true
  validates :rating, numericality: { greater_than: 0, less_than_or_equal_to: 10, only_integer: true },
                     allow_nil: true
  validates :observation, length: { maximum: 120 }

  # The weather attributes intervals take into account their respective lowest/highest records measured on Earth
  validates :temperature,  numericality: { greater_than: -100, less_than: 100 },          on: :update
  validates :air_pressure, numericality: { greater_than: 880, less_than: 1080 },          on: :update
  validates :wind_speed,   numericality: { greater_than_or_equal_to: 0, less_than: 140 }, on: :update

  validate :log_duration

  after_create :add_weather_data

  # Method that gets a string with the Log spot followed by its tag_id (padded by zeros)
  # Ex: Sargo Rock #009
  def label
    "#{location.spot} \##{sprintf '%03d', (tag_id)}"
  end

  # Method that gets the Log more relevant stat
  def stat_to_display
    if temperature.present?
      "#{temperature} °C"
    elsif air_pressure.present?
      "#{air_pressure} Pa"
    elsif wind_speed.present?
      "#{wind_speed} m/s"
    else
      "No stats"
    end
  end

  # Method that gets the Log duration in hours
  def duration
    (end_time - start_time).fdiv(60 * 60)
  end

  private

  # Method that updates the Log weather attributes to the ones registered at the moment in the respective Location
  def add_weather_data
    self.update(location.weather_data)
  end

  # Method that adds validations to the Log duration
  def log_duration
    if start_time.nil?
      errors.add(:start_time, "must exist")

    elsif end_time.nil?
      errors.add(:end_time, "must exist")

    elsif start_time >= end_time
      errors.add(:duration, "must be positive")

    elsif start_time + (9 * 60) + 1 >= end_time
      errors.add(:duration, "cannot be less than 10min")

    elsif start_time + (60 * 60 * 24) + 1 <= end_time
      errors.add(:duration, "cannot be longer than 24h")
    end
  end
end
