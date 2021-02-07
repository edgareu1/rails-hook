module MetaTagsHelper
  def meta_title
    get_meta(:meta_title)
  end

  def meta_description
    get_meta(:meta_description)
  end

  def meta_image
    meta_image = get_meta(:meta_image)
    # A little twist so that it work equally with an asset or a url
    meta_image.starts_with?("http") ? meta_image : image_url(meta_image)
  end

  def meta_icon
    meta_icon = get_meta(:meta_icon)
    # A little twist so that it work equally with an asset or a url
    meta_icon.starts_with?("http") ? meta_icon : image_url(meta_icon)
  end

  private

  def get_meta(meta_symbol)
    return (
      content_for?(meta_symbol) ?
      content_for(meta_symbol) :
      DEFAULT_META[meta_symbol.to_s]
    )
  end
end
