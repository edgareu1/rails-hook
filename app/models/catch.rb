class Catch < ApplicationRecord
  belongs_to :fish
  belongs_to :log

  validates :quantity, presence: true,
                       numericality: { greater_than: 0, less_than: 100 }
  validates :weight,   presence: true,
                       numericality: { greater_than: 0, less_than: 500000 }

  after_save :increment_catches_counters
  after_destroy :decrement_catches_counters

  def increment_catches_counters
    log.increment!(:catches_count, quantity)
    log.increment!(:catches_weight, weight)

    log.location.increment!(:catches_count, quantity)
    log.location.increment!(:catches_weight, weight)

    log.user.increment!(:catches_count, quantity)
    log.user.increment!(:catches_weight, weight)
  end

  def decrement_catches_counters
    log.decrement!(:catches_count, quantity)
    log.decrement!(:catches_weight, weight)

    log.location.decrement!(:catches_count, quantity)
    log.location.decrement!(:catches_weight, weight)

    log.user.decrement!(:catches_count, quantity)
    log.user.decrement!(:catches_weight, weight)
  end
end
