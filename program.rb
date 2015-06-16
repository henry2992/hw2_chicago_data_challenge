require 'csv'
require 'pp'
require 'awesome_print'


	# PEARSON CORRELATION TEST FUNCTION
	class Correlation 
		def initialize	
		end

		def test_correlation(x,y,xy,x2,y2,n)
		 correlation = (( n *(xy)) - (x * y)) / Math.sqrt( (  (n * x2) - (x * x)) * ((n * y2) - (y * y)) )
		 return correlation.to_f
		end			
	end	

	# CLASS READER. WILL READ 2 FILES
	class Reader 
		def initialize()	
		end
		
		$census = {} #
		$crimes = []

		def census_reader(file)
			eco_index = 0
			CSV.foreach(file) do |line| 
			   eco_index_total = eco_index
			   $census[eco_index] = [line[1].strip.to_s, line[5].to_f, line[7].to_i]
			   eco_index +=  1
			end	
			return $census
		end
		
		def crimes_reader(file)
			crime_index = 0
			CSV.foreach(file) do |line| 
			  crime_index_total = crime_index
			  $crimes[crime_index] = [line[13].to_i, line[5].strip.to_s]
			  crime_index +=  1
			end
			return $crimes
		end	
	end

	read_crime = Reader.new	
	read_crime.crimes_reader('crimes.csv')
	
	read_census = Reader.new	
	read_census.census_reader('census.csv')

    $census.delete(78)

    class FinalParser 
    	def initialize()
    		
    	end
    	

	def crime_parser
		counter = 0
		nb = 78
		$crimes.each do |key, value|
			while counter < nb do 
					if key.to_f == counter
						$census[counter] << value
					end
				counter += 1
			end
			counter = 0
		end 
	end	

	# crime_parser

	def crime_sum
		total_crime = 0 

		$census.each do |key, value|
			value.each do |y|	
				if y.to_s.include? "THEFT"
					total_crime += 1
				end
				if y.to_s.include? "OFFENSE INVOLVING CHILDREN"
					total_crime += 1
				end
				if y.to_s.include? "OTHER OFFENSE"
					total_crime += 1
				end
				if y.to_s.include? "CRIM SEXUAL ASSAULT"
					total_crime += 1
				end
				if y.to_s.include? "CRIMINAL DAMAGE"
					total_crime += 1
				end
				if y.to_s.include? "DECEPTIVE PRACTICE"
					total_crime += 1
				end
				if y.to_s.include? "BURGLARY"
					total_crime += 1
				end
				if y.to_s.include? "NARCOTICS"
					total_crime += 1
				end
				if y.to_s.include? "SEX OFFENSE"
					total_crime += 1
				end
				if y.to_s.include? "WEAPONS VIOLATION"
					total_crime += 1
				end
				if y.to_s.include? "BATTERY"
					total_crime += 1
				end
				if y.to_s.include? "ROBBERY"
					total_crime += 1
				end
				if y.to_s.include? "INTIMIDATION"
					total_crime += 1
				end
				if y.to_s.include? "MOTOR VEHICLE THEFT"
					total_crime += 1
				end
				if y.to_s.include? "ASSAULT"
					total_crime += 1
				end
			end

			$census[key] << total_crime

			$census[key].delete("THEFT")
			$census[key].delete("OFFENSE INVOLVING CHILDREN")
			$census[key].delete("OTHER OFFENSE")
			$census[key].delete("CRIM SEXUAL ASSAULT")
			$census[key].delete("CRIMINAL DAMAGE")
			$census[key].delete("DECEPTIVE PRACTICE")
			$census[key].delete("BURGLARY")
			$census[key].delete("NARCOTICS")
			$census[key].delete("SEX OFFENSE")
			$census[key].delete("WEAPONS VIOLATION")
			$census[key].delete("BATTERY")
			$census[key].delete("ROBBERY")
			$census[key].delete("INTIMIDATION")
			$census[key].delete("MOTOR VEHICLE THEFT")
			$census[key].delete("ASSAULT")
			$census[key].delete("Primary Type")
			
			total_crime = 0


		end

	end
	
	# crime_sum


	def relation_test
		$sum_education = []
		$sum_income = []
		$sum_crime = []

		$sum_crime_income = []
		$sum_crime_edu = []
		$sum_edu_income = []

		$income_2 = []
		$crime_2 = []
		$education_2 = []

		$census.each do |x, y|

			$sum_education << y[1].to_f
			$sum_income << y[2]	
			$sum_crime << y[3]

			$sum_crime_edu << y[1].to_f * y[3].to_f
			$sum_edu_income << y[1].to_f *  y[2].to_i 
			$sum_crime_income << y[2].to_i * y[3].to_i

			$education_2 << y[1].to_f * y[1].to_f
			$income_2 << y[2].to_i * y[2].to_i
			$crime_2 << y[3].to_i * y[3].to_i
		end

		$sum_income.shift
		$sum_crime.shift
		$sum_education.shift

		$sum_edu_income.shift
		$sum_crime_edu.shift
		$sum_crime_income.shift

		$education_2.shift
		$income_2.shift
		$crime_2.shift

		# SUM ALL #

		$education_total = $sum_education.inject(:+)
		$income_total = $sum_income.inject(:+)
		$crime_total =  $sum_crime.inject(:+)

		$edu_income_total = $sum_edu_income.inject(:+)
		$crime_edu_total = $sum_crime_edu.inject(:+)
		$crime_income_total = $sum_crime_income.inject(:+)

		$education_times_2 = $education_2.inject(:+)
		$income_times_2 = $income_2.inject(:+)
		$crime_times_2 = $crime_2.inject(:+)

		
	end

end

		
	test = FinalParser.new
	test.crime_parser
	test.crime_sum
	test.relation_test

	# relation_test
	

		

	numsize = $sum_income.size 
		
	y1 = Correlation.new 

    puts numsize
	
	c1 = y1.test_correlation($income_total, $crime_total, $crime_income_total, $income_times_2 , $crime_times_2, numsize).round(5)

	c2 = y1.test_correlation($crime_total, $education_total, $crime_edu_total, $crime_times_2, $education_times_2, numsize).round(5)


	

	$census[0][1]= "% AGED 25+ WITHOUT HIGH SCHOOL DIPLOMA"
	$census[0][2] = "PER CAPITA INCOME"
	$census[0][3] = "TOTAL NUMBER OF CRIMES"
	
		print_counter = 1
		while print_counter < 78

			ap "Neighborhood: #{$census[print_counter][0]}"
			ap  "Education: #{$census[print_counter][1]}. Income: $#{$census[print_counter][2]}. Total Crime: #{$census[print_counter][3]}" 

			print_counter += 1 

			puts 
		
		end
	

	






	
