require_relative "program"
require "minitest/autorun"
require 'csv'
 
class TestCorrelation < MiniTest::Unit::TestCase 
 
  # Variables

   # X and Y Variables
   	$education = 1566.3
   	$income = 1968364
   	$crime = 216

   # X * Y variables

    $education_income = 30286082.000000004
    $crime_education = 4620.300000000001
    $crime_income = 5585784

   # x2 and y2 variables
   
    $education_2 =  42484.790000000015
    $income_2 = 68092414184
    $crime_2 = 1110

   #Array size
    $n = 77
  
  #TEST IF FILES ARE CORRECT
  def test_files
    #Test is Crimes and Census CSV FIles are in the folder
    assert( File.exist?("crimes.csv"))
    assert( File.exist?("census.csv"))  
    #Test if the code is reading all the lines within a file
    assert_equal( 203, Reader.new.crimes_reader('crimes.csv').length )
    assert_equal( 78, Reader.new.census_reader('census.csv').length)
  end



  #TEST IF VARIABLES ARE CORRECT  
  def test_variables  
    assert_equal($education , $education_total )
    assert_equal($income , $income_total)
    assert_equal($crime , $crime_total)
    assert_equal($education_income  , $edu_income_total )
    assert_equal($crime_education, $crime_edu_total)
    assert_equal($crime_income , $crime_income_total)
    assert_equal($education_2 , $education_2_total)
    assert_equal($income_2 , $income_2_total)
    assert_equal($crime_2 , $crime_2_total)
  end

  #TEST IF PEARSON CORRELATION ARE CORRECT
  def test_correlations

  	# Pearson Correlation between Income and Crime 
    assert_equal(0.02142766, Correlation.new.test_correlation( $income_total , $crime_total, $crime_income_total, $income_2_total , $crime_2_total, $n).round(8))
  
    # Pearson Correlation between and Crime and Education 
    assert_equal(0.09788679, Correlation.new.test_correlation( $crime_total, $education_total  , $crime_edu_total , $crime_2_total, $education_2_total, $n).round(8))
  
    # Pearson Correlation between and Income and Education 
    assert_equal(-0.70977148, Correlation.new.test_correlation( $income_total , $education_total ,  $edu_income_total   , $income_2_total , $education_2_total, $n).round(8))
  end
end







