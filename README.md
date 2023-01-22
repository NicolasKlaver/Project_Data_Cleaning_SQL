# SQL Project: Nashville Housing Data Cleaning 
In this project I make a Data Cleaning of the Nashville Housing dataset where we standardize the date format, fill the null values, split the PropertyAddress into Individual Columns, unify values that have different names, remove duplicates and deleted unused columns.



#### Skills used: 
- Joins, CTE's, Windows Functions, Aggregate Functions, Converting Data Types and function to Update Tables.


#### Files
- cleaning_data.sql: contains all the project.




## Examples of some Queries


### Breaking out Address into Individual Columns (Address, City, State)

##### Before
![](https://github.com/NicolasKlaver/Project_Data_Cleaning_SQL/blob/main/img/split_before.png)

https://github.com/NicolasKlaver/Project_Data_Cleaning_SQL/blob/51407c568cca7d9ee1f33609a5e91bcb90b5b0bf/src/cleaning_data.sql#L121-L126
##### Result
![](https://github.com/NicolasKlaver/Project_Data_Cleaning_SQL/blob/main/img/split_after.png)




### Change Y and N to Yes and No in "Sold as Vacant" field
https://github.com/NicolasKlaver/Project_Data_Cleaning_SQL/blob/51407c568cca7d9ee1f33609a5e91bcb90b5b0bf/src/cleaning_data.sql#L163-L168
![](https://github.com/NicolasKlaver/Project_Data_Cleaning_SQL/blob/main/img/change_columns_before.png)

https://github.com/NicolasKlaver/Project_Data_Cleaning_SQL/blob/51407c568cca7d9ee1f33609a5e91bcb90b5b0bf/src/cleaning_data.sql#L172-L179
##### Result
![](https://github.com/NicolasKlaver/Project_Data_Cleaning_SQL/blob/main/img/change_column_after.png)




#### Remove Duplicates
https://github.com/NicolasKlaver/Project_Data_Cleaning_SQL/blob/51407c568cca7d9ee1f33609a5e91bcb90b5b0bf/src/cleaning_data.sql#L191-L208

##### Applying SELECT
![](https://github.com/NicolasKlaver/Project_Data_Cleaning_SQL/blob/main/img/duplicates_before.png)
##### Applying DELETE
![](https://github.com/NicolasKlaver/Project_Data_Cleaning_SQL/blob/main/img/duplicates_after.png)

