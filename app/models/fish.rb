class Fish < ApplicationRecord
  include AlgoliaSearch
  
  algoliasearch do
    attribute :common_name, :id
  end
end
