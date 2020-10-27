module ApplicationHelper
  # Method that divides a number by a thousand and rounds it (distinguishing floats from integers)
  def rounded_by_thousand(num)
    num.fdiv(1000)
       .tap { |i| break i.to_i == i ? i.to_i : i }
       .round(1)
  end

  # Method that returns a weight measure as a string in the correct format (gr or kg)
  def rounded_weight(weight)
    if weight < 1000
      weight.zero? ? "NA" : "#{weight} gr"
    else
      "#{rounded_by_thousand(weight)} kg"
    end
  end

  # Method that convert temperature in Kelvin to degrees Celsius
  def kelvin_to_celcius(kelvin)
    kelvin - 273.15
  end

  # Method that displays the User avatar or, if this isn't present, the standard avatar
  def large_avatar(user)
    if user.avatar.attached?
      cl_image_tag(user.avatar.key, transformation: [
        { width: 240, height: 240, gravity: 'face', radius: 'max', crop: 'fill' }
      ], class: "avatar-large")
    else
      image_tag('default-user-avatar.png', class: "avatar-large")
    end
  end
end
