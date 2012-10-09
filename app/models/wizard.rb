class Wizard
  def initialize(resource, step = nil)
    @resource = resource

    @requested_step = step.to_i if step
  end

  def save
    if @resource.save
      if self.last_step? && !@resource.published?
        @just_finished = @resource.publish!
      end
    else
      return false
    end
  end

  def wizard_step_defined?(tab_name)
    views_path = ::Rails.root.to_s + "/app/views"
    plural_product = SiteConfig.product_class.to_s.tableize
    specific_path = "products/#{plural_product}"

    File.exists?("#{views_path}/#{specific_path}/wizard_tabs/_step_#{tab_name}.haml")
  end

  def tabs
    unless @wizard_tabs
      @wizard_tabs = []
      @wizard_tabs << :general
      @wizard_tabs << :custom_fields if CustomField.any?
      @wizard_tabs << :pricing   if wizard_step_defined?(:pricing)
      @wizard_tabs << :photos    if wizard_step_defined?(:photos)    && SiteConfig.photos?
      @wizard_tabs << :panoramas if wizard_step_defined?(:panoramas) && SiteConfig.panoramas?
      @wizard_tabs << :traits    if wizard_step_defined?(:traits)    && AmenityGroup.any?
      #@wizard_tabs << :address   if wizard_step_defined?(:address)
      #tabs << :calendar if SiteConfig.calendar?
    end
    @wizard_tabs
  end

  def total_steps
    tabs.size
  end

  def current_step
    if @requested_step
      @requested_step
    else
      if @resource.completed_steps < total_steps
        @resource.completed_steps + 1
      else
        1
      end
    end
  end

  # def completed?
  #   @resource.completed_steps >= total_steps
  # end

  def just_finished?
    @just_finished
  end

  def completed_step?(n)
    n <= @resource.completed_steps
  end

  def current_step?(n)
    current_step == n
  end

  def last_step?
    current_step == total_steps
  end

  # Is it possible to navigate to that step
  def enabled_step?(n)
    (n <= @resource.completed_steps + 1) && !current_step?(n)
  end

  def previous_step
  end

  def next_step
    if @requested_step && @requested_step < total_steps
      @requested_step + 1
    end
  end

  def current_step_name
    tabs[current_step - 1]
  end
end