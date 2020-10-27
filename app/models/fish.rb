class Fish < ApplicationRecord
  include ApplicationHelper

  # Method that gets a string summarizing the Fish legal dimensions (weight and size)
  def legal_dimensions
    if legal_weight.zero? && legal_size.zero?
      "NA"
    elsif legal_weight != 0 && legal_size != 0
      "#{rounded_weight(legal_weight)} / #{legal_size} cm"
    elsif legal_weight != 0
      rounded_weight(legal_weight)
    elsif legal_size != 0
      "#{legal_size} cm"
    end
  end
end
