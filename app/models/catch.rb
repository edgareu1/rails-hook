class Catch < ApplicationRecord
  belongs_to :fish
  belongs_to :log

  validates :quantity, presence: true,
                       numericality: { greater_than: 0, less_than: 100 }
  validates :weight,   presence: true
  validate  :weight_numericality

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

  private

  def weight_numericality
    return if weight.nil?

    if weight <= 0
      errors.add(:weight, "must be greater than 0 gr")
    elsif weight >= 500000
      errors.add(:weight, "must be less than 500 kg")
    end
  end
end
