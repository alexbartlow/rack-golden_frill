require 'test/unit'
require 'golden_frill'
require 'rack/golden_frill'
require 'rack/test'
require 'fileutils'
class TestRack < Test::Unit::TestCase
  include Rack::Test::Methods
  OUTPUT_ROOT = ::File.expand_path('./images', File::dirname(__FILE__))
  
  def app
    Rack::GoldenFrill.new lambda{|x| [200, {}, ["OK"]]}, OUTPUT_ROOT
  end
  
  def test_dynamic_generation
    filename = 'frill_d4412d.14.36.png'
    
    FileUtils.rm(File.join(OUTPUT_ROOT, filename)) rescue Errno::ENOENT
    get "/images/#{filename}"
    assert_equal 301, last_response.status
    assert File.exists?(File.join(OUTPUT_ROOT, filename))
  end
end