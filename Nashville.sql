/*

Cleaning Data in SQL Queries

*/
SELECT *
  FROM [PortfolioProject].[dbo].[Nashville]

--------------------------------------------------------------------------------------------------------------------------

-- Standardize Date Format

-- The ALTER TABLE statement is used to add, delete, or modify columns in an existing table.
-- The UPDATE statement is used to modify the existing records in a table.

SELECT SaleDate, CONVERT(Date, SaleDate)
  FROM [PortfolioProject].[dbo].[Nashville]

Alter Table Nashville
Add SaleDateConverted Date;

Update Nashville
Set SaleDateConverted = CONVERT(Date, SaleDate)

SELECT SaleDateConverted
  FROM [PortfolioProject].[dbo].[Nashville]


 --------------------------------------------------------------------------------------------------------------------------
-- Populate Property Address data
-- ParcelID and Address is dependant, so where address is null we can use ParcelID to fill null address

-- The ISNULL() function returns a specified value if the expression is NULL. {ISNULL(expression, value)}

SELECT PropertyAddress
  FROM [PortfolioProject].[dbo].[Nashville]
  Where PropertyAddress is Null

SELECT *
  FROM [PortfolioProject].[dbo].[Nashville]
  Where PropertyAddress is Null

SELECT a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress, b.PropertyAddress)
  FROM [PortfolioProject].[dbo].[Nashville] a
  Join [PortfolioProject].[dbo].[Nashville] b
  on a.ParcelID = b.ParcelID
  and a.[UniqueID ] <> b.[UniqueID ]
  Where a.PropertyAddress is Null

Update a
Set PropertyAddress = ISNULL(a.PropertyAddress, b.PropertyAddress)
  FROM [PortfolioProject].[dbo].[Nashville] a
  Join [PortfolioProject].[dbo].[Nashville] b
  on a.ParcelID = b.ParcelID
  and a.[UniqueID ] <> b.[UniqueID ]
  Where a.PropertyAddress is Null

--------------------------------------------------------------------------------------------------------------------------
-- Breaking out PropertyAddress into Individual Columns (Address, City)

-- The SUBSTRING() function extracts some characters from a string. {SUBSTRING(string, start, length)}
-- The CHARINDEX() function searches for a substring in a string, and returns the position. {CHARINDEX(substring, string, start)}
-- The LEN() function returns the length of a string. {LEN(string)}

Select PropertyAddress
From [PortfolioProject].[dbo].[Nashville]

Select
SUBSTRING(PropertyAddress, 1, charindex(',',PropertyAddress)-1) as Address,
Substring(PropertyAddress, charindex(',',PropertyAddress)+1, LEN(PropertyAddress)) as Address
From [PortfolioProject].[dbo].[Nashville]


Alter Table [PortfolioProject].[dbo].[Nashville]
Add PropertySplitAddress nvarchar(255);

Update [PortfolioProject].[dbo].[Nashville]
Set PropertySplitAddress = SUBSTRING(PropertyAddress, 1, charindex(',',PropertyAddress)-1)

Alter Table [PortfolioProject].[dbo].[Nashville]
Add PropertySplitCity nvarchar(255);

Update [PortfolioProject].[dbo].[Nashville]
Set PropertySplitCity = Substring(PropertyAddress, charindex(',',PropertyAddress)+1, LEN(PropertyAddress))

Select *
From [PortfolioProject].[dbo].[Nashville]

--------------------------------------------------------------------------------------------------------------------------
-- Breaking out OwnerAddress into Individual Columns (Address, City, State)
-- PARSENAME() useful when you’re dealing with objects that have multiple parts separated by a delimiter, such as a dot (“.”), and you need to retrieve a specific part.
-- PARSENAME ('object_name' , object_piece )

Select
Parsename(Replace(OwnerAddress, ',', '.'), 3),
Parsename(Replace(OwnerAddress, ',', '.'), 2),
Parsename(Replace(OwnerAddress, ',', '.'), 1)
From [PortfolioProject].[dbo].[Nashville]

Alter Table [PortfolioProject].[dbo].[Nashville]
Add OwnerSplitAddress nvarchar(255);

Update [PortfolioProject].[dbo].[Nashville]
Set OwnerSplitAddress = Parsename(Replace(OwnerAddress, ',', '.'), 3)

Alter Table [PortfolioProject].[dbo].[Nashville]
Add OwnerSplitCity nvarchar(255);

Update [PortfolioProject].[dbo].[Nashville]
Set OwnerSplitCity = Parsename(Replace(OwnerAddress, ',', '.'), 2)

Alter Table [PortfolioProject].[dbo].[Nashville]
Add OwnerSplitState nvarchar(255);

Update [PortfolioProject].[dbo].[Nashville]
Set OwnerSplitState = Parsename(Replace(OwnerAddress, ',', '.'), 1)

Select *
From [PortfolioProject].[dbo].[Nashville]

--------------------------------------------------------------------------------------------------------------------------
-- Change Y and N to Yes and No in "Sold as Vacant" field

-- The CASE expression goes through conditions and returns a value when the first condition is met (like an if-then-else statement). 

Select Distinct(SoldAsVacant), Count(SoldAsVacant)
From [PortfolioProject].[dbo].[Nashville]
Group by SoldAsVacant
Order by 2


Select SoldAsVacant,
	Case
		When SoldAsVacant = 'Y' Then 'Yes'
		When SoldAsVacant = 'N' Then 'No'
		Else SoldAsVacant
	End
From [PortfolioProject].[dbo].[Nashville] 


Update [PortfolioProject].[dbo].[Nashville]
Set SoldAsVacant =
	Case
		When SoldAsVacant = 'Y' Then 'Yes'
		When SoldAsVacant = 'N' Then 'No'
		Else SoldAsVacant
	End


-----------------------------------------------------------------------------------------------------------------------------------------------------------
-- Remove Duplicates (Usually we dont delete duplicate rows in SQL)
-- Check Duplicates
-- CTEs act as virtual tables that are created during query execution, used by the query, and deleted after the query executes.
-- ROW_NUMBER function is a SQL ranking function that assigns a sequential rank number to each new record in a partition.
--	ROW_NUMBER Syntax:
--	ROW_NUMBER() OVER (
--	[PARTITION BY partition_expression, ... ]
--	ORDER BY sort_expression [ASC | DESC], ...
--	)

With RowNumCTE as (
Select *,
ROW_NUMBER() OVER (
Partition by ParcelID,
			 PropertyAddress,
			 SalePrice,
			 SaleDate,
			 LegalReference
			 Order by
			 UniqueID
			 ) as row_num
FROM [PortfolioProject].[dbo].[Nashville]
)
Select *
FROM RowNumCTE
Where row_num > 1

-----Edit (Delete From RowNumCTE) instead of (Select* From RowNumCTE) 
With RowNumCTE as (
Select *,
ROW_NUMBER() OVER (
Partition by ParcelID,
			 PropertyAddress,
			 SalePrice,
			 SaleDate,
			 LegalReference
			 Order by
			 UniqueID
			 ) as row_num
FROM [PortfolioProject].[dbo].[Nashville]
)
DELETE
FROM RowNumCTE
Where row_num > 1
---------------------------------------------------------------------------------------------------------

-- Delete Unused Columns

ALTER TABLE [PortfolioProject].[dbo].[Nashville]
DROP COLUMN OwnerAddress, TaxDistrict, PropertyAddress, SaleDate

SELECT *
FROM [PortfolioProject].[dbo].[Nashville]

---------------------------------------------------------------------------------------------------------
--Check Data Type of Column

SELECT 
TABLE_CATALOG,
TABLE_SCHEMA,
TABLE_NAME, 
COLUMN_NAME, 
DATA_TYPE 
FROM INFORMATION_SCHEMA.COLUMNS
where TABLE_NAME = 'Nashville' 
--and COLUMN_NAME = 'ParcelID'


SELECT table_name
FROM information_schema.tables
WHERE table_type='BASE TABLE'

-- Move Column
--Alter Table NashvilleHousing Change column [SaleDateConverted] After ParcelID;
--ALTER TABLE NashvilleHousing MODIFY COLUMN SaleDateConverted Date AFTER ParcelID ;








------------------------------