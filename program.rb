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
		
		$census = {} #Hash table for Census Data for the city of Chicago
		$crimes = [] #Array for the Crime Data of the City of Chicago

		# Parse Census information into Hash Table
		def census_reader(file)
			index = 0 # Key value for hash table will be 0 - 78, There are 77 Neighbourhoods in Chicago. 
			CSV.foreach(file) do |line| 
			   # Key = [0] COMMUNITY AREA NAME, [1] % AGED 25+ wo HS DIPLOMA, [2]PER CAPITA INCOME  
			   $census[index] = [line[1].strip.to_s, line[5].to_f, line[7].to_i]
			   index +=  1
			end	
			return $census
		end
		
		# Parse Crime Education into Array
		def crimes_reader(file)
			index = 0 #Array. First item will match Census Key[0]: Community area name.
			CSV.foreach(file) do |line| 
			  #    Array = [0] Community Area , [1]Primary Crime Type
			  $crimes[index] = [line[13].to_i, line[5].strip.to_s]
			  index +=  1
			end
			return $crimes
			$census.delete(78)
		end	
	end



	read_crime = Reader.new	
	read_crime.crimes_reader('crimes.csv')
	
	read_census = Reader.new	
	read_census.census_reader('census.csv')



    class FinalParser 
    	def initialize()
    		
    	end
    	

    	#Add all Crimes into census hash 
		def add_crimes_to_census
			counter = 0
			$crimes.each do |area, crime|
				while counter <= 77 do # 77 Neighbourhoods 
						if area.to_f == counter #If Area = Counter, Add the crime to specific Index in hash.
							$census[counter] << crime
						end
					counter += 1
				end
				counter = 0
			end 
		end	

		# Find total crimes per Area.
		def find_total_crime
			total_crime = 0 
			#Iterate Census Hash, if name of crime is found Add 1 to total crime.
			$census.each do |area, values|
				values.each do |value|	
					if value.to_s.include? "THEFT"
						total_crime += 1
					end
					if value.to_s.include? "OFFENSE INVOLVING CHILDREN"
						total_crime += 1
					end
					if value.to_s.include? "OTHER OFFENSE"
						total_crime += 1
					end
					if value.to_s.include? "CRIM SEXUAL ASSAULT"
						total_crime += 1
					end
					if value.to_s.include? "CRIMINAL DAMAGE"
						total_crime += 1
					end
					if value.to_s.include? "DECEPTIVE PRACTICE"
						total_crime += 1
					end
					if value.to_s.include? "BURGLARY"
						total_crime += 1
					end
					if value.to_s.include? "NARCOTICS"
						total_crime += 1
					end
					if value.to_s.include? "SEX OFFENSE"
						total_crime += 1
					end
					if value.to_s.include? "WEAPONS VIOLATION"
						total_crime += 1
					end
					if value.to_s.include? "BATTERY"
						total_crime += 1
					end
					if value.to_s.include? "ROBBERY"
						total_crime += 1
					end
					if value.to_s.include? "INTIMIDATION"
						total_crime += 1
					end
					if value.to_s.include? "MOTOR VEHICLE THEFT"
						total_crime += 1
					end
					if value.to_s.include? "ASSAULT"
						total_crime += 1
					end
				end
				# Add Total Crime to Census Hash Table
				$census[values] << total_crime
				# Delete All Crime types from Hash Table
				$census[values].delete("THEFT")
				$census[values].delete("OFFENSE INVOLVING CHILDREN")
				$census[values].delete("OTHER OFFENSE")
				$census[values].delete("CRIM SEXUAL ASSAULT")
				$census[values].delete("CRIMINAL DAMAGE")
				$census[values].delete("DECEPTIVE PRACTICE")
				$census[values].delete("BURGLARY")
				$census[values].delete("NARCOTICS")
				$census[values].delete("SEX OFFENSE")
				$census[values].delete("WEAPONS VIOLATION")
				$census[values].delete("BATTERY")
				$census[values].delete("ROBBERY")
				$census[values].delete("INTIMIDATION")
				$census[values].delete("MOTOR VEHICLE THEFT")
				$census[values].delete("ASSAULT")
				$census[values].delete("Primary Type")
				# Set Total crime to 0, for nexts Community Areas
				total_crime = 0
			end
		end

		#Get Variables to Run Pearson Correlation test 
		def get_relation_variables

			# X or Y variables
			$sum_education = []
			$sum_income = []
			$sum_crime = []

			#XY Variables
			$sum_crime_income = []
			$sum_crime_edu = []
			$sum_edu_income = []

			#X and Y to the power of 2
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
	test.add_crimes_to_census
	test.find_total_crime
	test.get_relation_variables

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
	

	






	
