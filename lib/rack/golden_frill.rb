module Rack
  class GoldenFrill
    def initialize app, output_path
      @app = app
      @root = ::File.expand_path(output_path)
      raise ArgumentError, "#{output_path} is not a directory" unless ::File.directory?(@root)
    end

    def call env      
      unless env["PATH_INFO"] =~ /#{@root}/
        return @app.call(env)
      end

      request = ::Rack::Request.new(env)
      command = env["PATH_INFO"].match(/#{@root}\/frill_(.*)\.png/i)[1]
      
      image_path = ::File.join(@root,"frill_#{command}.png")
      if ::File.exist?(image_path)
        return ::Rack::File.new(@root).call(env)
      end
      
      opts = { :output_path => image_path }
      opts[:base_color], opts[:width], opts[:height], opts[:frill_color] = command.split('.')
      ::GoldenFrill.new(opts).run!

      # Redirect to this URL since it will now be served.
      return [301, {'Location' => request.url}, 'Redirecting to created image.']
    end
  end
end