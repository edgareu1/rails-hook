class User < ApplicationRecord
  attr_accessor :login

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :logs
  has_many :locations, dependent: :destroy
  has_many :catches, through: :logs

  def self.find_for_database_authentication warden_conditions
    conditions = warden_conditions.dup
    login = conditions.delete(:login)
    where(conditions).where(["lower(username) = :value OR lower(email) = :value", {value: login.strip.downcase}]).first
  end

  # Returns an array of hashes that represent the fish most caught by the user
  def top_fish(num)
    catches.group_by { |catch| catch.fish.common_name }
           .transform_values { |catches| catches.inject(0) { |sum, catch| sum + catch.quantity } }
           .max_by(num) { |k, v| v }
           .sort_by { |arr| - arr.last}
           .map { |k, v| { name: k, num_catches: v } }
  end

  # Returns an array of hashes that represent the locations with the most Logs
  def top_locations(num)
    locations.map { |loc| { name: loc.name_to_display,
                            site: loc.site,
                            coordinates: { lat: loc.latitude, lon: loc.longitude },
                            num_logs: loc.logs.count
                          }
                  }
             .sort_by { |loc| - loc[:num_logs] }
             .first(num)
  end

  # Get the total number of fish caught by the User
  def catch_count
    catches.inject(0) { |sum, catch| sum + catch.quantity }
  end
end
