module Search
  class Property < Search::Product

    def resource_class
      ::Property
    end

    attr_accessor :place_type_ids

    def price_range
      if self.min_price.present? && self.max_price.present?
        Range.new(self.convert_to_usd(self.min_price), self.convert_to_usd(self.max_price))
      end
    end

    def collection
      resource_class.published
    end

    def add_filters
      add_sql_condition(['max_guests >= ?', self.guests]) if self.guests > 1
    end

    def order
      self.sort_by ||= 'price_lowest'
      sort_map = {
        "name"               => "title asc",
        "price_lowest"       => "price_per_month_usd asc",
        "price_highest"      => "price_per_month_usd desc",
        "price_size_lowest"  => "price_sqf_usd asc",
        "price_size_highest" => "price_sqf_usd desc",
        "reviews_overall"    => "reviews_overall desc",
        "most_recent"        => "updated_at desc"
      }
      sort_map[self.sort_by]
    end

    def sort_options
      custom_options = [[I18n.t("places.search.price_size_lowest"), 'price_size_lowest'],
                        [I18n.t("places.search.price_size_highest"), 'price_size_highest']]
      super + custom_options
    end
  end
end