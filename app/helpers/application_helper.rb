module ApplicationHelper
  # Return a string with it's weight in the correct quantification (gr or kg)
  def rounded_weight(weight)
    if weight < 1000
      return weight.zero? ? "NA" : "#{weight} gr"

    else
      weight_in_kg = weight.fdiv(1000)
                           .tap { |num| break num.to_i == num ? num.to_i : num }
                           .round(1)

      return "#{weight_in_kg} kg"
    end
  end

  # Convert temperature in Kelvin to degrees Celsius
  def kelvin_to_celcius(kelvin)
    return kelvin - 273.15
  end

  # Display the Users avatar or, if this isn't present, the standard avatar
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
