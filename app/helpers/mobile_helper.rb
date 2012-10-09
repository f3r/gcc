module MobileHelper

  def keyvalue(key, value)
    "<p><strong>#{key}</strong>: #{value}</p>".html_safe if key.present? && value.present?
  end

  def descriptive_key(key, value)
    " | #{pluralize(value, key)}".html_safe if key.present? && value.present?
  end

end
