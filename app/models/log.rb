class Log < ApplicationRecord
  belongs_to :location
  belongs_to :user

  has_many :catches
end
