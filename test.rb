require_relative "program"
require "minitest/autorun"
 
class TestCorrelation < MiniTest::Unit::TestCase 
 
  # Variables

   # X and Y Variables
   	$education = 1566.3
   	$income = 1968364
   	$crime = 216

   # X * Y variables

    $education_income = 286082.000000004
    $crime_education = 4620.300000000001
    $crime_income = 5585784

   # x2 and y2 variables
   
    $education_2 =  42484.790000000015
    $income_2 = 68092414184
    $crime_2 = 1110

   #Array size
    $n = 77








  def test_simple

  	# Pearson Correlation between Income and Crime 
    assert_equal(0.02142766, Correlation.new.test_correlation( $income , $crime , $crime_income , $income_2 , $crime_2, $n).round(8))
  
    # Pearson Correlation between and Crime and Education 
    assert_equal(0.09788679, Correlation.new.test_correlation( $crime , $education , $crime_education , $crime_2 , $education_2, $n).round(8))
  

  end
 
end