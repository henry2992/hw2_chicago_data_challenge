require_relative "program"
require "minitest/autorun"
 
class TestCorrelation < MiniTest::Unit::TestCase 
 
  def test_simple


    assert_equal(0.02142766, Correlation.new.test_correlation(1968364,216,5585784,68092414184,1110,77).round(8))
  
  end
 
end