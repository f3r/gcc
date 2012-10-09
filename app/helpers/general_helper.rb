module GeneralHelper
  def delete_caches(caches)
    for cache in caches
      Rails.cache.delete(cache)
    end
  end

  # used to filter any additional paramaters sent that doesn't match the allowed fields
  def filter_params(params, fields, options={})
    new_params = {}
    fields.map{|param| new_params.merge!(param => params[param]) if params.has_key?(param) && param != :id }
    return new_params
  end

  def get_additional_fields(field, object, fields)
    if !object.send("#{field.to_s}").nil?
      additional_object = Rails.cache.fetch("#{field.to_s}_#{object.send("#{field.to_s}_id")}") {
        Rails.logger.info "Cache: #{field.to_s}_#{object.send("#{field.to_s}_id")} miss"
        object.send("#{field.to_s}").class.find(object.send("#{field.to_s}_id"))
      }
      return {field.to_sym => filter_fields(additional_object,fields) }
    else
      return {}
    end
  end

  def exchange_currency(price, old_currency, new_currency)
  begin
    return unless price
    price.to_money(old_currency).exchange_to(new_currency).to_f
  rescue Exception => e
    0
  end
  end

  # Validates multiple attributes using the validation rules from a model
  def validate_attributes(model, attributes)
    errors = {}
    attribute_list = attributes.map{|k,v| k}
    temp = model.new(attributes)
    if !temp.valid?
      temp.errors.each {|attribute,value|
        errors.merge!({attribute => temp.errors.get(attribute)}) if !temp.errors.get(attribute).blank? && attribute_list.include?(attribute)
      }
    end
    return errors
  end

end