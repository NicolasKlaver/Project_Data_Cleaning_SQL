/*
Cleaning Data in SQL Queries
*/


Select *
From ProjectHousing.dbo.NashvilleHousing

--------------------------------------------------------------------------------------------------------------------------
-- Standardize Date Format


SELECT SaleDate,  CONVERT(Date,SaleDate)
From ProjectHousing.dbo.NashvilleHousing
--> Format of SaleDate: YYYY-MM-DD HH-MM-SS-MS
--> Format Converted: YYYY-MM-DD

----- Update the changes to the Table -----
--First Try:
Update NashvilleHousing
SET SaleDate = CONVERT(Date,SaleDate)


-- If it doesn't Update properly
ALTER TABLE NashvilleHousing
Add SaleDateConverted Date;

Update NashvilleHousing
SET SaleDateConverted = CONVERT(Date,SaleDate)

-- Select the new column and check if doesnt update the first try
Select saleDateConverted, CONVERT(Date,SaleDate)
From ProjectHousing.dbo.NashvilleHousing





 --------------------------------------------------------------------------------------------------------------------------
-- Populate Property Address data

Select *
From ProjectHousing.dbo.NashvilleHousing
--Where PropertyAddress is null --> Look the NULL values
order by ParcelID
--> We see that are many values with same ParcelID and when this happen has the same PropertyAddress


-- We want to refill the NULL values of PropertyAddress
	-- If found two rows with same ParcelID and one of this two HAS PropertyAddress --> We refill the NULL value with this PropertyAddress
Select 
	a.ParcelID, a.PropertyAddress, 
	b.ParcelID, b.PropertyAddress, 
	ISNULL(a.PropertyAddress, b.PropertyAddress) --> If is NULL put the other Property Address --> This is the column with the data update
From ProjectHousing.dbo.NashvilleHousing a
JOIN ProjectHousing.dbo.NashvilleHousing b
	ON a.ParcelID = b.ParcelID
		AND a.[UniqueID ] <> b.[UniqueID ] --> Its not the same row
Where a.PropertyAddress is null


-- Update the Table
Update aux_a
	SET PropertyAddress = ISNULL(aux_a.PropertyAddress,aux_b.PropertyAddress)
	From ProjectHousing.dbo.NashvilleHousing aux_a
	JOIN ProjectHousing.dbo.NashvilleHousing aux_b
		on aux_a.ParcelID = aux_b.ParcelID
			AND aux_a.[UniqueID ] <> aux_b.[UniqueID ]
	Where aux_a.PropertyAddress is null




--------------------------------------------------------------------------------------------------------------------------
-- Breaking out Address into Individual Columns (Address, City, State)


--> Format: Property Address: Address, City
Select PropertyAddress
From ProjectHousing.dbo.NashvilleHousing


-- Separate the PropertyAddress
SELECT
	-- Select the first String separate for coma
	SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1 ) as Address1, --> the -1 is because we dont want the ','
	-- Selecct the second string
	SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1 , LEN(PropertyAddress)) as Address2 --> Without the len function we dont see the end of the string

From ProjectHousing.dbo.NashvilleHousing


-- Update the table creating two new Columns
ALTER TABLE NashvilleHousing
Add PropertySplitAddress Nvarchar(255);

Update NashvilleHousing
SET PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1 )


ALTER TABLE NashvilleHousing
Add PropertySplitCity Nvarchar(255);

Update NashvilleHousing
SET PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1 , LEN(PropertyAddress))

-- Check
Select *
From ProjectHousing.dbo.NashvilleHousing




--Another form of separate strings

-- OwnerAddress: Address, City, State
Select OwnerAddress
From ProjectHousing.dbo.NashvilleHousing


--Parsename only work with '.' so we replace the character before we use the function
Select
	PARSENAME(REPLACE(OwnerAddress, ',', '.') , 3),
	PARSENAME(REPLACE(OwnerAddress, ',', '.') , 2),
	PARSENAME(REPLACE(OwnerAddress, ',', '.') , 1)
From ProjectHousing.dbo.NashvilleHousing


-- Update the table
ALTER TABLE NashvilleHousing
Add OwnerSplitAddress Nvarchar(255);

Update NashvilleHousing
SET OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 3)


ALTER TABLE NashvilleHousing
Add OwnerSplitCity Nvarchar(255);

Update NashvilleHousing
SET OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 2)



ALTER TABLE NashvilleHousing
Add OwnerSplitState Nvarchar(255);

Update NashvilleHousing
SET OwnerSplitState = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 1)


-- Check
Select *
From ProjectHousing.dbo.NashvilleHousing




--------------------------------------------------------------------------------------------------------------------------
-- Change Y and N to Yes and No in "Sold as Vacant" field


Select 
	Distinct(SoldAsVacant),
	Count(SoldAsVacant) as Count
From ProjectHousing.dbo.NashvilleHousing
Group by SoldAsVacant
order by 2



-- Unifique the cases
Select 
	SoldAsVacant, 
	CASE	When SoldAsVacant = 'Y' THEN 'Yes'
			When SoldAsVacant = 'N' THEN 'No'
			ELSE SoldAsVacant
			END
From ProjectHousing.dbo.NashvilleHousing


Update NashvilleHousing
SET SoldAsVacant = CASE When SoldAsVacant = 'Y' THEN 'Yes'
						When SoldAsVacant = 'N' THEN 'No'
						ELSE SoldAsVacant
						END

-----------------------------------------------------------------------------------------------------------------------------------------------------------
-- Remove Duplicates

WITH RowNumCTE AS(
	Select *,
	ROW_NUMBER() 
		OVER (-- Partition BY things that need to be Unique
			PARTITION BY ParcelID,
						PropertyAddress,
						SalePrice,
				 		SaleDate,
				 		LegalReference
			ORDER BY
						UniqueID) row_num

From ProjectHousing.dbo.NashvilleHousing
--order by ParcelID
)
Select COUNT(*) AS count_duplicates --DELETE
From RowNumCTE
Where row_num > 1 --> We need the CTE to apply this filter
--Order by PropertyAddress


---------------------------------------------------------------------------------------------------------
-- Delete Unused Columns


Select *
From ProjectHousing.dbo.NashvilleHousing

-- Delete some tables
ALTER TABLE ProjectHousing.dbo.NashvilleHousing
DROP COLUMN OwnerAddress, TaxDistrict, PropertyAddress, SaleDate




