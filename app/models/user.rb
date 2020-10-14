class User < ApplicationRecord
  attr_accessor :login

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # API authentication token
  acts_as_token_authenticatable

  has_many :logs
  has_many :locations, dependent: :destroy
  has_many :catches, through: :logs

  has_one_attached :avatar

  def self.find_for_database_authentication warden_conditions
    conditions = warden_conditions.dup
    login = conditions.delete(:login)
    where(conditions).where(["lower(username) = :value OR lower(email) = :value", {value: login.strip.downcase}]).first
  end

  # Returns an array of hashes that represent the fish most caught by the user
  def top_fish(num)
    catches.group_by { |catch| catch.fish.name }
           .transform_values { |catches| catches.inject(0) { |sum, catch| sum + catch.quantity } }
           .max_by(num) { |k, v| v }
           .sort_by { |arr| - arr.last}
           .map { |k, v| { name: k, num_catches: v } }
  end

  # Returns an array of hashes that represent the 'num' Locations with the most Logs
  # In case of 2 or more Locations with the same Log size, decide by their creation date (Id serves the purpose)
  def top_locations(num)
    locations.map { |loc| [loc.logs_count, loc.catch_count, - loc.id] }
             .max(num)
             .map { |loc_data| Location.find(loc_data.last.abs).data_to_display }
  end

  # Get the number of fish caught by the User
  def catch_count
    catches.inject(0) { |sum, catch| sum + catch.quantity }
  end

  # Get the weight of fish caught by the User
  def catch_weight
    catches.inject(0) { |sum, catch| sum + catch.weight }
  end
end
