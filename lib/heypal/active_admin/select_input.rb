module Heypal
  module ActiveAdmin
    class SelectInput < ::ActiveAdmin::Inputs::FilterSelectInput
      def method
        @method
      end
    end
  end
end