require 'chunky_png'
module GoldenFrill
  GoldenRatio = 1.618
  # Requires:
  #  output_path : the path at which to output the requested image
  #  width: the width the rectangle above the frill
  #  height: the height of the rectangle above the frill
  #  base_color: the color of the rectangle above the frill
  #
  # Optional:
  #  frill_color: the color of the frill. If not provided, will be a darker color than the base
  def self.run!(opts)
    width, height, base_color, output_path = opts[:width].to_i, opts[:height].to_i, opts[:base_color], opts[:output_path]
    
    bot_height = height.to_i + (width.to_f * GoldenRatio).to_i
    png = ChunkyPNG::Image.new(width.to_i, bot_height)
    
    rc = ChunkyPNG::Color.from_hex(base_color)
    (1..(height - 1)).each do |h|
      (1..(width - 1)).each do |w|
        png[w,h] = rc
      end
    end
    
    ribbon_color = if opts[:frill_color]
      ChunkyPNG::Color.from_hex(opts[:frill_color])
    else
      self.darken_color(rc)
    end
    
    slope = (height - bot_height).to_f / (1 - width).to_f
    
    (height..(bot_height - 1)).each do |h|
      (1..(width - 1)).each do |w|
        on_line_slope = (w * slope) + height
        next if on_line_slope.to_i + 1 < h
        
        alpha_scale = case (on_line_slope.to_i + 1) - h
        when 1 then 0.8
        when 0 then 0.5
        else 
          1.0
        end
        a = (0xff.to_f * alpha_scale).to_i
        
        new_color = ((w + 3) - (width - 1)).times.inject(ribbon_color){|rc, fade|
          darken_color(rc, 0.95)
        }
        new_color = ChunkyPNG::Color.fade(new_color, a) 
        
        # fade the color to a black gradient if in the last couple pixels of the ribbon
        png[w,h] = new_color
      end
    end
    
    png.save(output_path)
  end
  
  def self.darken_color(c, scale = 0.8)
    r, g, b = %w{r g b}.map{|x| (ChunkyPNG::Color.send(x, c).to_f * scale).to_i}
    ChunkyPNG::Color.rgb(r,g,b)
  end
end