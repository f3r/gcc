module GoogleFunnelChart
  module Helpers
    def google_funnel_chart(data, options = {})
    
      raise TypeError, "Expected Hash object as data" unless data.is_a? Hash
      raise TypeError, "Expected Hash object as options" unless options.is_a? Hash
      
      # the param values for google chart
      g_p =[]
      
      # We use the horizontal chart
      g_p << "bhs".to_query("cht")
      
      # We need 3 axis to plot on - 2 x axis and y axis      
      g_p << "x,x,y".to_query("chxt")
      
      # We create a stacked horizontal chart - with one axis as same as the background color - White for now
      default_bar_color = options[:bar_color].nil? ? "FF9900" : options[:bar_color]
      bar_colors = []
      
      for f_val in data.values
        bar_color = f_val.fetch(:bar_color, default_bar_color)
        bar_colors << "#{bar_color}"
      end      
      
      chco = "FFFFFF,"
      chco << bar_colors.join("|")
      
      g_p << chco.to_query("chco")
      
      x_axis_label = options[:x_label].nil? ? "" : options[:x_label]
      show_x_axis_points = options[:show_x_points].nil? ? false : true
      
      chxl = "1:|#{x_axis_label}|2:|"
      
      chxl = "0:||" << chxl unless show_x_axis_points
      
      axis1 = []
      labels = []
      
      for f_item_key in data.keys.reverse
        labels << data[f_item_key][:label]
        axis1 << data[f_item_key][:value]
      end
      
      max_val = axis1.max
            
      axis1 = axis1.reverse
      
      axis2 = []
      
      for v in axis1        
        axis2 << (v > 0 ? (max_val - v) / 2.0 : 0)
      end
      
      chxl << labels.join("|") << "|"
      
      g_p << chxl.to_query("chxl")
      
      chxp = "1,50|3,50"
      
      g_p << chxp.to_query("chxp")
      
      chd = "t:#{axis2.join(',')}|#{axis1.join(',')}"
      
      g_p << chd.to_query("chd")
      
      g_p << "a".to_query("chbh")
      
      height = options[:height].nil? ? 200 : options[:height]
      width = options[:width].nil? ? 800 : options[:width]
      
      g_p << "#{width}x#{height}".to_query("chs")
      
      g_p << "a".to_query("chds")
      
      g_p << "chm=N**,000000,1,-1,11,,c"
      
      image_tag("http://chart.apis.google.com/chart?" + g_p.join("&"))
    end
  end
end

ActionView::Base.send :include, GoogleFunnelChart::Helpers
