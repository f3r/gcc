module Heypal
  module ActiveAdmin
    class ProductFilterFormBuilder < ::ActiveAdmin::Filters::FormBuilder

      protected

      def custom_input_class_name(as)
        if as == :select
          "HeyPalFrontEnd::ActiveAdmin::SelectInput"
        else
          super
        end
      end

      def default_input_type(method, options = {})
        di = super
        if method.to_s.starts_with? "product_"
          #remove the id from
          method = method.to_s.gsub('_id','')
          method = method.to_s.gsub('product_','')
          refl = Product.reflect_on_association(method.to_sym)
          return :select if refl
        end
        di
      end

      def column_for(method)
        col = super
        if col.nil?
          method = method.to_s.gsub('product_','')
          product_col = Product.columns_hash[method.to_s]
          product_col
        else
          col
        end
      end
    end
  end
end