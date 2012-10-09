module Paperclip
  module Interpolations
    def parent_id attachment, style_name
      attachment.instance.parent_id
    end
  end
end