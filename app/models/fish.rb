class Fish < ApplicationRecord
  include ApplicationHelper

  # Returns a string with the legal dimensions (weight and size) in the right format
  def display_legal_dimensions
    if legal_weight == 0 && legal_size == 0
      return "NA"
    elsif legal_weight != 0 && legal_size != 0
      return "#{rounded_weight(legal_weight)} / #{legal_size} cm"
    elsif legal_weight != 0
      return rounded_weight(legal_weight)
    elsif legal_size != 0
      return "#{legal_size} cm"
    end
  end
end
