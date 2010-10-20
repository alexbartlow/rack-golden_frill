module Rack
  class GoldenFrill
    def initialize app, output_path
      @app = app
      @root = ::File.expand_path(output_path)
      raise ArgumentError, "#{output_path} is not a directory" unless ::File.directory?(@root)
    end

    def call env
      if env["PATH_INFO"] !~ /images\/frill_/ || env["RAILS_ENV"] == 'production' || env["RACK_ENV"] == 'production'
        return @app.call(env)
      end

      command = env["PATH_INFO"].match(/\/frill_(.*)\.png/i)[1]
      request = ::Rack::Request.new(env)
      image_path = ::File.join(@root,"frill_#{command}.png")
      if ::File.exist?(image_path)
        return ::Rack::File.new(@root).call(env)
      end
      
      opts = { :output_path => image_path }
      opts[:base_color], opts[:width], opts[:height], opts[:frill_color] = command.split('.')
      ::GoldenFrill.run!(opts)
      # Redirect to this URL since it will now be served.
      return [301, {'Location' => request.url}, ['Redirecting to created image.']]
    end
  end
end