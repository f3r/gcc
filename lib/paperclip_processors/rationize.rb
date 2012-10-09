module Paperclip
  class Rationize < Processor
    # Plan is to crop to 3:2 ratio first then watermark processor would resize and watermark
    attr_accessor :current_geometry, :target_geometry, :format

    def initialize(file, options = {}, attachment = nil)
      super
      geometry            = options[:geometry]
      @file               = file
      @target_geometry    = Geometry.parse(geometry)
      @current_geometry   = Geometry.from_file(@file)
      @whiny              = options[:whiny].nil? ? true : options[:whiny]

      @format             = options[:format]
      @current_format     = File.extname(@file.path)
      @basename           = File.basename(@file.path, @current_format)
    end

    def make
      dst = Tempfile.new([@basename, @format].compact.join("."))
      dst.binmode
      
      # Init the parameters - to avoid the chance of getting errors, 
      # if the uploaded image is a square one
      new_width = @current_geometry.width
      new_height = @current_geometry.height

      if @current_geometry.vertical?
        new_width = @current_geometry.width
        new_height = new_width * 1.5
      elsif @current_geometry.horizontal?
        new_height = @current_geometry.height
        new_width = new_height * 1.5
      end

      # check if the new width is bigger than the original
      if new_width > @current_geometry.width
        new_width = @current_geometry.width
        new_height =  @current_geometry.width / 1.5
      end

      # check if the new height is bigger than the original
      if new_height > @current_geometry.height
        new_height = @current_geometry.height
        new_width =  @current_geometry.height / 1.5
      end

      params = "#{fromfile} -gravity Center -crop #{new_width.to_i}x#{new_height.to_i}+0+0 +repage #{tofile(dst)}"

      begin
        success = Paperclip.run("convert", params)
      rescue PaperclipCommandLineError
        raise PaperclipError, "There was an error processing the watermark for #{@basename}" if @whiny
      end

      dst
    end

    def fromfile
      "\"#{ File.expand_path(@file.path) }[0]\""
    end

    def tofile(destination)
      "\"#{ File.expand_path(destination.path) }[0]\""
    end

  end
end
