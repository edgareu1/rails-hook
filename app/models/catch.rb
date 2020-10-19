class Catch < ApplicationRecord
  belongs_to :fish
  belongs_to :log

  validates :quantity, presence: true,
                       numericality: { greater_than: 0, less_than: 100 }
  validates :weight,   presence: true,
                       numericality: { greater_than: 0 }
end
