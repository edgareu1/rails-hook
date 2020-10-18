class Log < ApplicationRecord
  belongs_to :location, counter_cache: true
  belongs_to :user, counter_cache: true

  has_many :catches, dependent: :destroy
  has_many :fish, through: :catches

  validates :location, presence: true

  validate :log_duration

  after_create :add_weather_data

  # Method that gets the number of Fish caught in the Log
  def catch_count
    catches.inject(0) { |sum, catch| sum + catch.quantity }
  end

  # Method that gets the weight of Fish caught in the Log
  def catch_weight
    catches.inject(0) { |sum, catch| sum + catch.weight }
  end

  # Method gets a string of the Log spot followed by it's tag_id (padded by zeros)
  # Ex: Sargo Rock #009
  def label
    "#{location.spot} \##{sprintf '%03d', (tag_id)}"
  end

  # Method that gets the Log duration in hours
  def duration
    (end_time - start_time) / ( 60 * 60 )
  end

  private

  # Method that updates the weather attributes to the ones registered at the moment in the respective Location
  def add_weather_data
    self.update(location.weather_data)
  end

  # Method that adds validations to the Log duration
  def log_duration
    if start_time.nil?
      errors.add(:end_time, "Log has to have a start time")

    elsif end_time.nil?
      errors.add(:end_time, "Log has to have a end time")

    elsif start_time >= end_time
      errors.add(:end_time, "Log cannot end before it begins")

    elsif start_time + (9 * 60) + 1 >= end_time
      errors.add(:end_time, "Log cannot be less than 10min long")

    elsif start_time + (60 * 60 * 24) + 1 <= end_time
      errors.add(:end_time, "Log cannot be longer than 24h")
    end
  end
end
