module ApplicationHelper
  # Returns a string with it's weight in the correct quantifications (gr or kg)
  def rounded_weight(weight)
    if weight == 0
      return "NA"
    elsif weight < 1000
      return "#{weight} gr"
    else
      weight_in_kg = weight.fdiv(1000).tap { |n| break n.to_i == n ? n.to_i : n }
      return "#{weight_in_kg} kg"
    end
  end
end
