# GoogleVisualization
module GoogleVisualization
  class MotionChart

    attr_reader :collection, :collection_methods, :options, :size, :helpers, :procedure_hash, :name

    def method_missing(method, *args, &block)
      if Mappings.columns.include?(method)
        procedure_hash[method] = [args[0], block]
      else
        helpers.send(method, *args, &block)
      end
    end
    
    def initialize(view_instance, collection, options={}, *args)
      @helpers = view_instance
      @collection = collection
      @collection_methods = collection_methods
      @draw_zeros = options.delete(:draw_zeros) || false
      @options = options.reverse_merge({:width => 600, :height => 300})
      @columns = []
      @rows = []
      @procedure_hash = {:color => ["Department", lambda {|item| label_to_color(@procedure_hash[:label][1].call(item)) }] }
      @size = collection.size
      @name = "motion_chart_#{self.object_id.to_s.gsub("-","")}"
      @labels = {}
      @color_count = 0
    end

    def header
      content_tag(:div, "", :id => name, :style => "width: #{options[:width]}px; height: #{options[:height]}px;")
    end

    def body
      javascript_tag do
        "var data = new google.visualization.DataTable();\n" +
        "data.addRows(#{size});\n" +
        render_columns +
        render_rows +
        "var #{name} = new google.visualization.MotionChart(document.getElementById('#{name}'));\n" +
        "#{name}.draw(data, {width: #{options[:width]}, height: #{options[:height]}});"
      end
    end

    def render
      header + "\n" + body
    end

    def render_columns
      if required_methods_supplied?
        Mappings.columns.each { |c| @columns << motion_chart_add_column(procedure_hash[c]) }
        procedure_hash.each { |key, value| @columns << motion_chart_add_column(value) if not Mappings.columns.include?(key) }
        @columns.join("\n")
      end
    end

    def render_rows
      if required_methods_supplied?
        collection.each_with_index do |item, index|
          Mappings.columns.each_with_index {|name,column_index| @rows << motion_chart_set_value(index, column_index, procedure_hash[name][1].call(item)) }
          procedure_hash.each {|key,value| @rows << motion_chart_set_value(index, key, procedure_hash[key][1].call(item)) unless Mappings.columns.include?(key) }
        end
        @rows.join("\n")
      end
    end

    def required_methods_supplied?
      Mappings.columns.each do |key|
        unless procedure_hash.has_key? key
          raise "MotionChart Must have the #{key} method called before it can be rendered"
	end
      end
    end

    def motion_chart_add_column(title_proc_tuple)
      title = title_proc_tuple[0]
      procedure = title_proc_tuple[1]
      "data.addColumn('#{google_type(procedure)}','#{title}');\n"
    end
  
    def motion_chart_set_value(row, column, value)
      "data.setValue(#{row}, #{column}, #{Mappings.ruby_to_javascript_object(value)});\n"
    end
  
    def google_type(procedure)
      Mappings.ruby_to_google_type(procedure.call(collection[0]).class)
    end

    def google_formatted_value(value)
      Mappings.ruby_to_javascript_object(value)
    end
  
    def label_to_color(label)
      hashed_label = label.downcase.gsub(" |-","_").to_sym
      if @labels.has_key? hashed_label
        @labels[hashed_label]
      else
        @color_count += 1
      	@labels[hashed_label] = @color_count
      end
    end

    def extra_column(title, &block)
      procedure_hash[procedure_hash.size] = [title, block]
    end

  end

  class Chart
    attr_reader :collection, :options, :helpers, :dates, :lines, :google_chart_name
    attr_writer :google_chart_name

    def method_missing(method, *args, &block)
      if Mappings.columns.include?(method)
        procedure_hash[method] = [args[0], block]
      else
        helpers.send(method, *args, &block)
      end
    end

    def initialize(view_instance, dates, options={}, *args)
      @helpers = view_instance
      @dates = dates
      @options = options.reverse_merge({:width => 600, :height => 300})
      @lines = []
      @name = "chart_#{self.object_id.to_s.gsub("-","")}"
      @heading_count = 1
      @headings = ""
      @data = ""
      @row_length = 0;
      @google_chart_name = 'LineChart' #default to linechart
    end

    def render_head
      "<div id=\"#{@name}\" style=\"width: #{@options[:width]}px; height: #{@options[:height]}px;\"></div>\n" +
        "<script type=\"text/javascript\">\n" +
        "var #{@name}_data = new google.visualization.DataTable();\n"
    end

    def render_foot
      "var #{@name} = new google.visualization.#{@google_chart_name}(document.getElementById('#{@name}'));\n" +
        "#{@name}.draw(#{@name}_data, {#{Mappings.ruby_to_javascript_options(@options)}});\n</script>"
    end

    def render_headings
      #This way the charts can accept strings as well as dates (not the annotated one though)
      if @dates.first.is_a? String
        add_heading('string', 'Date')
      else
        add_heading('date', 'Date')
      end
      @lines.each do |line_hash|
          add_headings_for(line_hash)
      end
      @headings
    end

    def render_data
      row_count = 0
      @dates.each_with_index do |date, index|
        add_row(row_count, 0, date)
        @lines.each do |line_hash|
          if line_hash[:collection][index]
            add_row(row_count, line_hash[:column_start], get_value(line_hash,index))
            #add_row(row_count, line_hash[:column_start], line_hash[:collection][index].send(line_hash[:method_hash][:value]))
            add_row(row_count, line_hash[:column_start]+1, line_hash[:collection][index].send(line_hash[:method_hash][:title])) if line_hash[:method_hash][:title] and line_hash[:collection][index].send(line_hash[:method_hash][:title])
            add_row(row_count, line_hash[:column_start]+2, line_hash[:collection][index].send(line_hash[:method_hash][:notes])) if line_hash[:method_hash][:notes] and line_hash[:collection][index].send(line_hash[:method_hash][:notes])
          else
            add_row(row_count, line_hash[:column_start], 0)
          end
        end
        row_count += 1
      end
      @data
    end

    def get_value(line_hash,index)
      if line_hash[:method_hash].empty?
        result = line_hash[:collection][index]
      else
        result =line_hash[:collection][index].send(line_hash[:method_hash][:value])
      end
      if !@draw_zeroes && result.to_i == 0
        nil
      else
        result
      end
    end

    def render
      render_head + render_headings + "#{@name}_data.addRows(#{@row_length});\n" + render_data + render_foot
    end

    def add_headings_for(line_hash)
      line_hash[:column_start] = @heading_count
      add_heading('number',line_hash[:title])
      @heading_count += 1
      if @google_chart_name == 'AnnotatedTimeLine'
        add_heading('string', "title#{@heading_count}")
        add_heading('string', "notes#{@heading_count}")
        @heading_count += 2
      end
    end

    def add_heading(type, name)
      @headings += "#{@name}_data.addColumn('#{type}','#{name}');\n"
    end

    def add_row(row, column, value)
      @data += "#{@name}_data.setValue(#{row}, #{column}, #{Mappings.ruby_to_javascript_object(value)});\n"
    end

    def add_line(title, collection, method_hash={})
      collection.size > @row_length ? @row_length = collection.size : @row_length
      @lines.push({:title => title, :collection => collection,:method_hash => method_hash})
    end

    def required_methods_supplied?(method_hash)
      if method_hash.has_key?(:value)
        true
      else
        raise "Add Line requires the :value key to be specified in the method_hash"
      end
    end
  end

  module Mappings
    def self.ruby_to_google_type(type)
      type_hash = {
        :String => "string",
        :Fixnum => "number",
        :Float => "number",
        :Date => "date",
        :Time => "datetime"
      }
      type_hash[type.to_s.to_sym]
    end

    def self.ruby_to_javascript_object(value)
      value_hash = {
        :String => lambda {|v| "'#{v}'"},
        :Date => lambda {|v| "new Date(#{[v.year,(v.month.to_i - 1),v.day].join(',')})"},
        :Fixnum => lambda {|v| v },
        :Float => lambda {|v| v }
      }
      if value.nil?
        "null"
      else
        value_hash[value.class.to_s.to_sym].call(value)
      end
    end

    def self.columns
      [:label, :time, :x, :y, :color, :bubble_size]
    end

    # converts {:my_title=>'title', :my_width=>100} to "myTitle: 'title', myWidth: 100"
    def self.ruby_to_javascript_options(options)
      result = []
      options.keys.map do |i|
        if options[i].is_a? String
          if options[i] =~ /Date/
            result << "'#{i.to_s.camelize(:lower)}': #{options[i]}"
          else
            result << "'#{i.to_s.camelize(:lower)}': '#{options[i]}'"
          end
        elsif options[i].is_a? Array
          array_string = options[i].map{|j| "'#{j}'"}.join(",")
          result << "'#{i.to_s.camelize(:lower)}': [#{array_string}]"
        elsif options[i].is_a? Hash
          h = options[i]
          args = options[i].keys.map do |j|
            if h[j].is_a? String
              "'#{j}': '#{h[j]}'"
            else
              "'#{j}': #{h[j]}"
            end
          end
          args = args.join(", ")
          result << "'#{i.to_s.camelize(:lower)}': {#{args}}"
        else
          result << "'#{i.to_s.camelize(:lower)}': #{options[i]}"
        end
      end
      result.join(", ")
    end
  end

  module Helpers
    def setup_google_visualizations(*packages)
      packages_string = packages.map{|i| "\"#{i}\""}.join(",") # produces "\"one\",\"two\""
      "<script type=\"text/javascript\" src=\"http://www.google.com/jsapi\"></script>\n" +
      javascript_tag("google.load(\"visualization\", \"1\", {packages:[#{packages_string}]});")
    end

    def motion_chart_for(collection, options={}, *args, &block)
      motion_chart = MotionChart.new(self, collection, options)
      yield motion_chart
      concat(motion_chart.render)
    end

    def annotated_timeline_for(dates, options={}, *args, &block)
      chart_for('AnnotatedTimeLine',dates,options, *args, &block)
    end

    def annotated_timeline(label, stats, opts = {})
      dates = stats.collect{|i| i[0]}
      points = stats.collect{|i| i[1]}
      annotated_timeline_for(dates, opts) do |atl|
        atl.add_line(label, points, :value => :to_f)
      end
    end

    def line_chart_for(dates,options={}, *args, &block)
      chart_for('LineChart',dates,options, *args, &block)
    end

    def pie_chart_for(dates,options={}, *args, &block)
      chart_for('PieChart',dates,options, *args, &block)
    end

    def bar_chart_for(dates,options={}, *args, &block)
      chart_for('BarChart',dates,options, *args, &block)
    end

    def column_chart_for(dates,options={}, *args, &block)
      chart_for('ColumnChart',dates,options, *args, &block)
    end

    def chart_for(google_chart_name,dates,options={}, *args, &block)
      chart = Chart.new(self,dates,options)
      chart.google_chart_name = google_chart_name
      yield chart
      chart.render.html_safe
      #concat(chart.render.html_safe)
    end

  end
end

ActionView::Base.send :include, GoogleVisualization::Helpers

