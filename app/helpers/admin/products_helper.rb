module Admin::ProductsHelper
  
  def product_photos_row(product)
    return unless product.photos
    product.photos.collect do |record|
      photo = record.photo
      link_to image_tag(photo.url(:small)), photo.url, :target => '_blank'
    end.join(' ').html_safe
  end
end