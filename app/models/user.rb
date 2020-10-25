class User < ApplicationRecord
  attr_accessor :login

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # API authentication token
  acts_as_token_authenticatable

  has_many :locations, dependent: :destroy
  has_many :logs
  has_many :catches, through: :logs

  has_one_attached :avatar

  validates :email,    presence: true,
                       uniqueness: { case_sensitive: false }
  validates :username, presence: true,
                       length: { maximum: 20 },
                       uniqueness: { case_sensitive: false }

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    login = conditions.delete(:login)
    where(conditions).where(["lower(username) = :value OR lower(email) = :value", { value: login.strip.downcase }]).first
  end

  # Method that gets an array of hashes that represent the Fish most caught by the User; if there are 2 or more Fish
  # with the same quantity, sort by their weight; if they are still equal, sort by their creation date
  def top_fish(num)
    catches.group_by { |catch| catch.fish_id }
           .transform_values { |catches| [catches.inject(0) { |sum, catch| sum + catch.quantity },
                                          catches.inject(0) { |sum, catch| sum + catch.weight },
                                          - catches.first.id
                                         ]
                             }
           .max_by(num) { |k, v| v }
           .map { |k, v| { id: k,
                           name: Fish.find(k).name,
                           catches_count: v[0],
                           catches_weight: v[1]
                         }
                }
  end

  # Method that gets an array of Locations with the most Logs; if there are 2 or more Locations with the same
  # logs_count, sort by their catches_weight; if they are still equal, sort by their creation date
  def top_locations(num)
    locations.max_by(num) { |loc| [loc.logs_count, loc.catches_weight, loc.created_at] }
  end
end
