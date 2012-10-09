module HelperMethods
  # Put helper methods you need to be available in all acceptance specs here.
  def t(arg)
    I18n.translate arg
  end
end

RSpec.configuration.include HelperMethods, :type => :acceptance
