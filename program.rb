require 'csv'
require 'pp'
require 'awesome_print'

	# CLASS READER. WILL READ THE TWO DOCUMENTS
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
			$census.delete(78) #Delete last line of census file giving total data of Chicago.
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
		end	
	end

	class Variables 
    	def initialize
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
				$census[area] << total_crime
				# Delete All Crime types from Hash Table
				$census[area].delete("THEFT")
				$census[area].delete("OFFENSE INVOLVING CHILDREN")
				$census[area].delete("OTHER OFFENSE")
				$census[area].delete("CRIM SEXUAL ASSAULT")
				$census[area].delete("CRIMINAL DAMAGE")
				$census[area].delete("DECEPTIVE PRACTICE")
				$census[area].delete("BURGLARY")
				$census[area].delete("NARCOTICS")
				$census[area].delete("SEX OFFENSE")
				$census[area].delete("WEAPONS VIOLATION")
				$census[area].delete("BATTERY")
				$census[area].delete("ROBBERY")
				$census[area].delete("INTIMIDATION")
				$census[area].delete("MOTOR VEHICLE THEFT")
				$census[area].delete("ASSAULT")
				$census[area].delete("Primary Type")
				# Set Total crime to 0, for nexts Community Areas
				total_crime = 0
			end

			return $census
		end

		#Get Variables to Run Pearson Correlation test 
		def get_relation_variables

			#Define Variables
				# X or Y variables
				$education = []
				$income = []
				$crime = []

				#XY Variables
				$crime_income = []
				$crime_edu = []
				$edu_income = []

				#X and Y to the power of 2
				$income_2 = []
				$crime_2 = []
				$education_2 = []

			#Parse Census Data into each variable	
				$census.each do |x, y|
					$education << y[1].to_f
					$income << y[2]	
					$crime << y[3]

					$crime_edu << y[1].to_f * y[3].to_f
					$edu_income << y[1].to_f *  y[2].to_i 
					$crime_income << y[2].to_i * y[3].to_i

					$education_2 << y[1].to_f * y[1].to_f
					$income_2 << y[2].to_i * y[2].to_i
					$crime_2 << y[3].to_i * y[3].to_i
				end

			#Erase the First Index [0] of the Arrays, Corresponding to the Titles of the table
				$income.shift
				$crime.shift
				$education.shift

				$edu_income.shift
				$crime_edu.shift
				$crime_income.shift

				$education_2.shift
				$income_2.shift
				$crime_2.shift

			#Add all items in array into a single variable
				$education_total = $education.inject(:+)
				$income_total = $income.inject(:+)
				$crime_total =  $crime.inject(:+)

				$edu_income_total = $edu_income.inject(:+)
				$crime_edu_total = $crime_edu.inject(:+)
				$crime_income_total = $crime_income.inject(:+)

				$education_2_total = $education_2.inject(:+)
				$income_2_total = $income_2.inject(:+)
				$crime_2_total = $crime_2.inject(:+)	

			return $education_total, $income_total, $crime_total, $edu_income_total, $crime_edu_total, $crime_income_total, $education_2_total, $income_2_total, $crime_2_total
		end


		#Print output using Awesome Print Gem
		def printer
			#Rename the Headers of the Hash
			$census[0][1]= "% AGED 25+ WITHOUT HIGH SCHOOL DIPLOMA"
			$census[0][2] = "PER CAPITA INCOME"
			$census[0][3] = "TOTAL NUMBER OF CRIMES"
			# While loop to print all the items in Hash		
			counter = 1
			puts
			puts "The following program reads information on crime and census in the city of Chicago"
			while counter < 78

				ap "Neighborhood: #{$census[counter][0]}"
				ap  "Education: #{$census[counter][1]}. Income: $#{$census[counter][2]}. Total Crime: #{$census[counter][3]}" 
				counter += 1 
				puts #Print Space
			end
		end
	end


	# PEARSON CORRELATION TEST FUNCTION
	class Correlation 
		def initialize	
		end

		def test_correlation(x,y,xy,x2,y2,n)
		 correlation = (( n *(xy)) - (x * y)) / Math.sqrt( (  (n * x2) - (x * x)) * ((n * y2) - (y * y)) )
		 return correlation.to_f
		end			
	end	

	#Read First Crime File
	read_crime = Reader.new	
	read_crime.crimes_reader('crimes.csv')
	#Read Second Census File
	read_census = Reader.new	
	read_census.census_reader('census.csv')
	#Get Variables to Correlate	
	variables = Variables.new
	variables.add_crimes_to_census
	variables.find_total_crime
	variables.get_relation_variables
	# Print
	variables.printer


	numsize = 77
		
	y1 = Correlation.new 

	
	puts c1 = y1.test_correlation($income_total, $crime_total, $crime_income_total, $income_2_total, $crime_2_total, numsize).round(5)

	puts c2 = y1.test_correlation($crime_total, $education_total, $crime_edu_total, $crime_2_total , $education_2_total, numsize).round(5)







	
