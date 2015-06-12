require 'csv'


eco_index = 0
crime_index = 0

relation = {}

CSV.foreach("census.csv") do |line| 
  eco_index_total = eco_index
  relation [eco_index] = [line[0].to_i, line[1].strip.to_s, line[7].to_i]
  eco_index +=  1
end


crimes = []
CSV.foreach("crimes.csv") do |line| 
  crime_index_total = crime_index
  crimes[crime_index] = [line[13].to_i, line[5].strip.to_s]
  crime_index +=  1
end


counter = 0
nb = 79
max_count = []


	
crimes.each do |key, value|
	while counter < nb do 
			if key.to_f == counter
				relation[counter] << value
			end
		counter += 1
	end
	counter = 0
end 

total_crime = 0 

relation.each do |key, value|

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
	end


	
	relation[key] << total_crime

	relation[key].delete("THEFT")
	relation[key].delete("OFFENSE INVOLVING CHILDREN")
	relation[key].delete("OTHER OFFENSE")
	relation[key].delete("CRIM SEXUAL ASSAULT")
	relation[key].delete("CRIMINAL DAMAGE")
	relation[key].delete("DECEPTIVE PRACTICE")
	relation[key].delete("BURGLARY")
	relation[key].delete("NARCOTICS")
	relation[key].delete("SEX OFFENSE")
	relation[key].delete("WEAPONS VIOLATION")
	relation[key].delete("BATTERY")
	relation[key].delete("ROBBERY")
	relation[key].delete("INTIMIDATION")
	relation[key].delete("MOTOR VEHICLE THEFT")
	
	total_crime = 0

end

sum = []

relation.each do |x, y|
	sum << y[2]		
end

puts sum.inject(:+)













