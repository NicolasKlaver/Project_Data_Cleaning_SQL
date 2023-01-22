# SQL Project: Nashville Housing Data Cleaning 
In this project I make a Data Cleaning of the Nashville Housing dataset where we standardize the date format, fill the null values, split the PropertyAddress into Individual Columns, unify values that have different names, remove duplicates and deleted unused columns.



#### Skills used: 
- Joins, CTE's, Windows Functions, Aggregate Functions, Converting Data Types and update tables.


#### Files
- cleaning_data.sql: contains all the project.




## Examples of some Queries

##### Breaking out Address into Individual Columns (Address, City, State)

##### After:
![]()

https://github.com/NicolasKlaver/Project_Data_Cleaning_SQL/blob/51407c568cca7d9ee1f33609a5e91bcb90b5b0bf/src/cleaning_data.sql#L121-L126
##### Result:
![]()




##### Change Y and N to Yes and No in "Sold as Vacant" field
https://github.com/NicolasKlaver/Project_Data_Cleaning_SQL/blob/51407c568cca7d9ee1f33609a5e91bcb90b5b0bf/src/cleaning_data.sql#L163-L168
##### First result:
![]()
https://github.com/NicolasKlaver/Project_Data_Cleaning_SQL/blob/51407c568cca7d9ee1f33609a5e91bcb90b5b0bf/src/cleaning_data.sql#L172-L179
##### After we update the column
![]()




##### Remove Duplicates
https://github.com/NicolasKlaver/Project_Data_Cleaning_SQL/blob/51407c568cca7d9ee1f33609a5e91bcb90b5b0bf/src/cleaning_data.sql#L191-L208
##### Applying SELECT
![]()
##### Applying DELETE
![]()

