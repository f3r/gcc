ActiveAdmin.register AmenityGroup do
    menu :parent => 'Settings'
    
    controller do
      def show
        redirect_to admin_amenity_group_amenities_path(resource)
      end
    end
end