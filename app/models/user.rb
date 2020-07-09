class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  attr_accessor :login
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

  def top_three_fish
    arr = []

    Fish.all.to_a.each do |fish|
      catches_sum = self.catches.to_a.select { |catch| catch.fish_id == fish.id }.inject(0) { |sum, catch| sum + catch.quantity }

      arr << [fish, catches_sum]
    end

    return arr.sort_by { |fish_arr| - fish_arr[1] }[0..2]
  end
end
