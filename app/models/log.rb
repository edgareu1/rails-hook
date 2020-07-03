class Log < ApplicationRecord
  belongs_to :location
  belongs_to :user

  has_many :catches, dependent: :destroy
  has_many :fish, through: :catches

  def catch_count
    sum = 0
    catches.each do |c|
      sum = sum + c.quantity
    end
    return sum
  end
end
