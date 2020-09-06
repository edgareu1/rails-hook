module MoonPhase
  # Get the % of the moon that is active in a certain date
  # Both this method and it's helper are based on the Git Repo of "ablwr" named "moon phases"
  def get_moon_phase(date)
    year = date.year
    month = date.month
    day = date.day

    phase_days = (julian(year, month, day) - julian(2000, 1, 6)) % 29.530588853

    if phase_days < 14.7652944265
      return (phase_days % 14.7652944265) / 14.7652944265
    else
      return 1 - ((phase_days % 14.7652944265) / 14.7652944265)
    end
  end

  # Convert a date in Julian
  # Helper method for the calculation of the moon phase
  def julian(year, month, day)
    a = (14 - month) / 12
    y = year + 4800 - a
    m = (12 * a) - 3 + month

    return day + (153 * m + 2) / 5 + (365 * y) + (y / 4) - (y / 100) + (y / 400) - 32045
  end
end
