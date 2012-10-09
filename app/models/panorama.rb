class Panorama < ActiveRecord::Base
  belongs_to :product
  
  [:asset_0, :asset_1, :asset_2, :asset_3, :asset_4, :asset_5].each do |field|
    attr_accessor "#{field}_file_name"
    attr_accessor "#{field}_content_type"
    attr_accessor "#{field}_file_size"
    attr_accessor "#{field}_file_updated_at"
    has_attached_file "#{field}".to_sym, :url => "/:class/:id/images/:filename", :path => "/:class/:id/images/:filename"
  end

  attr_accessor :html_content_type, :html_file_size, :html_file_updated_at
  has_attached_file :html, :url => "/:class/:id/embed.html", :path => "/:class/:id/embed.html"

  attr_accessor :swf_content_type, :swf_file_size, :swf_file_updated_at
  has_attached_file :swf, :url => "/:class/:id/:filename", :path => "/:class/:id/:filename"

  before_save :generate_html

  def embed_url
    self.html.url.gsub('https', 'http')
  end
  
  def formats
    supported = []
    supported << 'Flash' if self.swf?
    supported << 'Html5' if self.xml?
    supported.join(', ')
  end

  protected

  def generate_html
    # Generates an embed.html file on S3 that can be embedded on any page with an iframe
    # This was neccessary in order to get around cross domain restrictions
    file = Tempfile.new( ["embed", '.html'] )
    @@acb ||= ActionController::Base.new
    content = @@acb.render_to_string(:template => 'panoramas/embed', :locals => {:panorama => self})
    file.write( content.force_encoding('utf-8') )
    file.rewind
    self.html = file
  end
end
