class Fish < ApplicationRecord
  include AlgoliaSearch

  algoliasearch do
    attribute :common_name, :id
  end

  # Returns a string with the legal dimensions (weight and size) in the right format
  def display_legal_dimensions
    if legal_weight == 0 && legal_size == 0
      return "NA"
    elsif legal_weight != 0 && legal_size != 0
      return "#{rounded_weight} / #{legal_size} cm"
    elsif legal_weight != 0
      return rounded_weight
    elsif legal_size != 0
      return "#{legal_size} cm"
    end
  end

  private

  # Returns a string with it's weight in the correct quantifications (gr or kg)
  def rounded_weight
    if legal_weight == 0
      return "NA"
    elsif legal_weight < 1000
      return "#{legal_weight} gr"
    else
      weight_in_kg = legal_weight.fdiv(1000).tap { |n| break n.to_i == n ? n.to_i : n }
      return "#{weight_in_kg} kg"
    end
  end
end
