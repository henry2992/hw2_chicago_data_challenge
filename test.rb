require_relative "program"
require "minitest/autorun"
 
class TestCorrelation < MiniTest::Unit::TestCase 
 
  def test_simple


    assert_equal(4, Correlation.new.test_correlation(1,1,1,1,1,1))
  
  end
 
end