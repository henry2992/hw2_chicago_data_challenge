								WELCOME TO THE CHICAGO DATA CHALLENGE README

Author: Henry Remache
Project: Chicago Challenge

Information:

	The following project has been done to find if there is a correlation between Crime and Income or Education. By using a Pearson Correlation test.

Github repository: 

	URL: https://github.com/henry2992/hw2_chicago_data_challenge

Data:

	census.csv = Census data of the city of Chicago. source: https://data.cityofchicago.org

	crimes.csv = Crime data of the last 5 years in the City of Chicago. source:  source: https://data.cityofchicago.org

	program.rb = File written in Ruby to parse the information of the CSV files, run the correlation and print results.

	README.md = Information about the Chicago Data Challenge

	test.rb = File written in Ruby to test functions and information of program.rb

Project Descripction:
	
	Program.rb

		Class: READER 
			functions:

				census_reader = This function will read a file (census.csv) and iterate through each line, parsing the data into a hash table. The Key will be an index from 0 - 77, these numbers correspond to the 77 Neighborhoods and Key[0] will be the titles.

				crimes_reader = This function will read a file and store the information into an Array of Arrays. 
		
		
		Class: VARIABLES
			functions:

			add_crimes_to_census = This fucntions iterates throught the crimes array and moves all the crimes by Neighborhood into the hash table.

			find_total_crime = This function find occurences of crimes and it adds everything up for each Neighborhood. Finding the total number of crimes in each area. And then if deletes all the crimes in the hash table.

			get_relation_variables = This functions will get the final variables to run the correlation.

			printer = This function prints the final output.

		Class: Correlation 
			functions:

			test_correlation = This function is a formula for the Pearson Correlation Test.

	Test.rb
		functions:

		 test_files = It runs 4 test. The first two assures that the CSV files crimes and census exits in the folder. The other two test will assure that all the lines in the files are being read.

		 test_variables = This tests assures that all the variables returned in the Class Variables are correct.

		 test_correlations = Test is the Pearson Correlation Results are correct.


Results:

	The Correlation between Income and Crime is low (0.02143). This means that the income of a certain Neighborhood does not increase crime.
	

	The Correlation between Education and Crime is low (0.09789). This means that the level of education is not a factor to increase crime in a certain Neighborhood.
	

	The Correlation between Education and Income is high (-0.70977). Meaning that the less education a person has the less income they perceive and viceversa. The result is negative since we are using the percetage of people without High School Education in a Neighborhood, so the less people a Neighborhood has without High School Education the income is higher.







	