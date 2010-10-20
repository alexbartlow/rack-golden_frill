require 'test/unit'
require 'golden_frill'
class TestFrills < Test::Unit::TestCase
  OUTPUT_ROOT = ::File.expand_path('./images', File::dirname(__FILE__))
  def test_output
    output_path = File.join(OUTPUT_ROOT,"rectangle.png")
    GoldenFrill.run!({
      :output_path => output_path,
      :base_color  => "d4412d",
      :width       => 14,
      :height      => 36
    })
    
    assert(::File.exists?(output_path))
  end
end