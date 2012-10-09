class ExternalLink < Cmspage

  # TODO: Breakman -- Insufficient validation for 'page_url'
  validates_format_of :page_url, :with => /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/ix, :message => "Invalid url"

  def external?
    true
  end

  def link
    page_url
  end

end