class Page < Cmspage

  has_many :cmspage_versions, :foreign_key => "cmspage_id", :order => "id DESC", :dependent => :destroy

  before_update do |r|
    r.cmspage_versions.create({:content => r.description_was}) if r.description_changed?
  end


  def cache_configs
    configs = {
                  'error_404' => {:expires_in => 24.hours},
                  'error_500' => {:expires_in => 24.hours}
               }
    configs[self.page_url]
  end

  def link
    "/#{self.page_url}"
  end

end