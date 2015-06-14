require 'csv'
require 'pp'
	
	class Correlation 
		def initialize	
		end

		def test_correlation(x,y,xy,x2,y2,n)
		 correlation = (( n *(xy)) - (x * y)) / Math.sqrt( (  (n * x2) - (x * x)) * ((n * y2) - (y * y)) )
		 return correlation.to_f
		end			
	end	


	$crimes = []
	$relation = {}

	def census_reader(file)
		eco_index = 0
		CSV.foreach(file) do |line| 
		  eco_index_total = eco_index
		  $relation[eco_index] = [line[1].strip.to_s, line[5].to_i, line[7].to_i]
		  eco_index +=  1
		end	
	end
	
	def crimes_reader(file)
		crime_index = 0
		CSV.foreach(file) do |line| 
		  crime_index_total = crime_index
		  $crimes[crime_index] = [line[13].to_i, line[5].strip.to_s]
		  crime_index +=  1
		end
	end
		
    census_reader('census.csv')	
    crimes_reader('crimes.csv')


	def crime_parser
		counter = 0
		nb = 79
		$crimes.each do |key, value|
			while counter < nb do 
					if key.to_f == counter
						$relation[counter] << value
					end
				counter += 1
			end
			counter = 0
		end 
	end	

	crime_parser

	def crime_sum
		total_crime = 0 

		$relation.each do |key, value|
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

			$relation[key] << total_crime

			$relation[key].delete("THEFT")
			$relation[key].delete("OFFENSE INVOLVING CHILDREN")
			$relation[key].delete("OTHER OFFENSE")
			$relation[key].delete("CRIM SEXUAL ASSAULT")
			$relation[key].delete("CRIMINAL DAMAGE")
			$relation[key].delete("DECEPTIVE PRACTICE")
			$relation[key].delete("BURGLARY")
			$relation[key].delete("NARCOTICS")
			$relation[key].delete("SEX OFFENSE")
			$relation[key].delete("WEAPONS VIOLATION")
			$relation[key].delete("BATTERY")
			$relation[key].delete("ROBBERY")
			$relation[key].delete("INTIMIDATION")
			$relation[key].delete("MOTOR VEHICLE THEFT")
			$relation[key].delete("ASSAULT")
			$relation[key].delete("Primary Type")
			
			total_crime = 0

		end
	end
	
	crime_sum


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

		$relation.each do |x, y|

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

	relation_test
		

		

	numsize = $sum_income.size
		
	y1 = Correlation.new 


	
	puts y1.test_correlation($income_total, $crime_total, $crime_income_total, $income_times_2 , $crime_times_2, numsize)

	$relation[0][1]= "PERCENT AGED 25+ WITHOUT HIGH SCHOOL DIPLOMA"
	$relation[0][2] = "PER CAPITA INCOME"
	$relation[0][3] = "TOTAL NUMBER OF CRIMES"

	pp $relation
	


	
