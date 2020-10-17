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
                       uniqueness: { case_sensitive: false },
                       length: { maximum: 20, message: "Maximum of 20 characters" }

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    login = conditions.delete(:login)
    where(conditions).where(["lower(username) = :value OR lower(email) = :value", { value: login.strip.downcase }]).first
  end

  # Method that gets an array of hashes that represent the Fish most caught by the User; in the case of 2 or more Fish
  # with the same quantity, decide by their weight; if they are still equal, decide by their creation date (Id serves
  # the purpose)
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
                           catch_count: v.first,
                           catch_weight: v[1]
                         }
                }
  end

  # Method that gets an array of hashes that represent the Locations with the most Logs; in the case of 2 or more
  # Locations with the same Log size, decide by their catch_count; if they are still equal, decide by their creation
  # date (Id serves the purpose)
  def top_locations(num)
    locations.map { |loc| [loc.logs_count, loc.catch_count, - loc.id] }
             .max(num)
             .map { |loc_data| Location.find(loc_data.last.abs).data_to_display }
  end

  # Method that gets the number of Fish caught by the User
  def catch_count
    catches.inject(0) { |sum, catch| sum + catch.quantity }
  end

  # Method that gets the weight of Fish caught by the User
  def catch_weight
    catches.inject(0) { |sum, catch| sum + catch.weight }
  end
end
