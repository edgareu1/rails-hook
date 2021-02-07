module MoonPhaseHelper
  # Both this methods are based on the GitHub Repo "moon phases" of "ablwr";
  # Check it at "https://gist.github.com/ablwr/127b3053d0f1a0316230b65f8bef6ccb";
  # Method that gets the % of the moon that is active on a certain date
  def get_moon_phase(date)
    year = date.year
    month = date.month
    day = date.day
    phase_days = (julian(year, month, day) - julian(2000, 1, 6)) % 29.530588853
    result = (phase_days % 14.7652944265) / 14.7652944265

    return phase_days < 14.7652944265 ? result : (1 - result)
  end

  private

  # Method that converts a date in Julian
  def julian(year, month, day)
    a = (14 - month) / 12
    y = year + 4800 - a
    m = (12 * a) - 3 + month

    return (
      day +
      (153 * m + 2) / 5 +
      (365 * y) +
      (y / 4) -
      (y / 100) +
      (y / 400) -
      32045
    )
  end
end
