OpenWeatherAPI.configure do |config|
  # API key
  config.api_key = 'feba1c4f716980a3ece2f14bdbf5e432'

  # Optionals
  config.default_language = 'en'     # 'en' by default
  config.default_country_code = 'en' # nil by default (ISO 3166-1 alfa2)
  config.default_units = 'metric'    # 'metric' by default
end
