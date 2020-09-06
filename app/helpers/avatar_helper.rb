module AvatarHelper
  def avatar_large(user)
    if user.avatar.attached?
      cl_image_tag(user.avatar.key, transformation: [
        { width: 240, height: 240, gravity: 'face', radius: 'max', crop: 'fill' }
      ], class: "avatar-large")
    else
      image_tag('default-user-avatar.png', class: "avatar-large")
    end
  end
end
