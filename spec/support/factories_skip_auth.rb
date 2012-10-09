require 'declarative_authorization/maintenance'
include Authorization::TestHelper

# All the factories ignore access control
module FactoryGirl
  module Syntax
    module Methods
      alias_method :original_create, :create
      alias_method :original_build, :build

      def create(name, *traits_and_overrides, &block)
        without_access_control do
          original_create(name, *traits_and_overrides, &block)
        end
      end

      def build(name, *traits_and_overrides, &block)
        without_access_control do
          original_build(name, *traits_and_overrides, &block)
        end
      end
    end
  end
end