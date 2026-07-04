%A table stores data in rows and columns with meaninful variable names. 
% Unlike matrices, table can hold different data types
% such as numbers, text, and dates etc.
matrix1 = [4; 3.5; 3; 4; 2.5];
matrix2 = [3.5; 3; 2.5; 4; 2];
respondent_id = (1 : 5)';

%Now let us create the table
T = table(respondent_id, matrix1, matrix2);

%Now let us display the table 
disp(T);
%Now let us put column name;
T = table(respondent_id, matrix1, matrix2, ...
	'VariableNames', {'ID', 'Matrix 1', 'Matrix 2'});
disp(T);


%Now we will work with our matrix files..
m1 = readmatrix('Matrix1.xlsx');
m2 = readmatrix('Matrix2.xlsx');

%First we gotta remove all the NaNs;
%so first get the index of all the valid items
valid_index = ~isnan(m1) & ~isnan(m2);

m1 = m1(valid_index);
m2 = m2(valid_index);


%We have to change the column index
id = (1 : length(m1))'; %I made a mistake there --> I need a column vector;


%create the new table with all the valid data 
movie_table = table(id, m1, m2, ...
	'VariableNames', {'Respondent Id', 'Matrix 1', 'Matrix 2'});

disp(movie_table);

%Now we will visualize table parts
% Access the first column of the table
first_column = movie_table(:, 1);
disp(first_column);

%Access the first column by its name
first_column_by_name = movie_table(:, 'Respondent Id');
disp(first_column_by_name);

%Now let us access the second row of the table
second_row = movie_table(2, :);
disp(second_row);

