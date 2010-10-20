Rack::GoldenFrill
=================

This is a library do create those little fun looking link ribbon things that have been cropping up on the nav bars for contemporary applications. (Example, the second picture down, <a href="http://thoughtbot.com/portfolio/shortbord/" rel="nofollow">on thoughtbot's portfolo</a>)

How to use:
-----------

You can create a png image for use like this with a command like so:

    GoldenFrill.run!(:base_color => 'd4412d', :width =>14, :height => 36, :output_path => "/path/to/image")
    
If you want to specify the color of the ribbon, also supply a `:frill_color` parameter. Otherwise, it will be a darker version of the `:base_color`. Width and Height should be the height of the rectangular element on top of the frill - which will be sized according to the Golden Ratio.

The image will be output to the directory. More often than not, you're going to want to use the Rack interface in development to create all of the images you want, and then commit the results into production.

**THIS MIDDLEWARE SHOULD NOT BE USED IN PRODUCTION.** It would be possible for an attacker to create an arbitrary number of image files on your machine, otherwise. If you accidentally keep it active in production, GoldenFrill tries its hardest to not work.

To use the rack interface:

    use Rack::GoldenFrill ::File.join(Rails.root, 'public', 'images')
    
Then, any requests to:
    
    /images/frill_#{base_color}.#{width}.#{height}(?:.#{frill_color})?.png
    
Will dynamically create the image.

How it works:
-------------

Uses ChunkyPNG to write out a PNG file directly, in pure ruby. Since the files are small enough and it's development only, it shouldn't be an issue.

I try to make the resulting images look pretty - the size of the ribbon is dictated by the Golden Ratio (hence the name), there's a shadow on the far right portions of the image, and there's also some alpha blending to antialias the diagonal line. For any sort of heavy-duty lifting, you'll probably want to call your designer or something though.