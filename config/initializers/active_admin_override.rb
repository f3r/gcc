module ActiveAdmin
  module Views
    module Pages
      class Base < Arbre::HTML::Document
        private
        def build_footer
          div :id => "footer" do
            para "Powered by #{link_to("The Sharing Engine", "http://www.thesharingengine.com")}".html_safe
          end
        end
      end
    end
  end
end