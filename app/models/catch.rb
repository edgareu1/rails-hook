class Catch < ApplicationRecord
  belongs_to :fish
  belongs_to :log

  validates :quantity, presence: true
  validates :weight, presence: true
end
