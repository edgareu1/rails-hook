class Fish < ApplicationRecord
  include AlgoliaSearch

  algoliasearch do
    attribute :common_name, :id
  end

  def count_catches
    Catch.all.to_a.select { |catch| catch.fish_id == self.id }.inject(0) { |sum, catch| sum + catch.quantity }
  end

end
