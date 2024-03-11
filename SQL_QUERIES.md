# Table Info
`Database` : PortfolioProject

`Table` : Nashville

`Rows` : 56477

`Columns` : 19

# Steps
__(1)__ Standardize Date Format.

__(2)__ Updating missing values in `PropertyAddress` field.

__(3)__ Split `PropertyAddress` into individual columns.

__(4)__ Split `OwnerAddress` into individual columns.

__(5)__ Change Y and N to Yes and No in `SoldasVacant` field.

__(6)__ Removing Duplicate rows/records in table.

__(7)__ Remove redudndant columns.

# Fetch the values of all the columns available in a table
```
SELECT *
FROM [PortfolioProject].[dbo].[Nashville]
```
| UniqueID  | ParcelID        | LandUse       | PropertyAddress              | SaleDate                | SalePrice | LegalReference   | SoldAsVacant | OwnerName                            | OwnerAddress                     | Acreage | TaxDistrict               | LandValue | BuildingValue | TotalValue | YearBuilt | Bedrooms | FullBath | HalfBath  |
|-----------|-----------------|---------------|------------------------------|-------------------------|-----------|------------------|--------------|--------------------------------------|----------------------------------|---------|---------------------------|-----------|---------------|------------|-----------|----------|----------|-----------|
| 56126     | 052 09 0 027.00 | SINGLE FAMILY | 1017 AFALLS  AVE, MADISON    | 2016-10-31 00:00:00.000 | 390000    | 20161103-0116430 | No           | GULLO-CHALMERS JV                    | 1017 A FALLS AVE, MADISON, TN    | 0.39    | GENERAL SERVICES DISTRICT | 54000     | 90300         | 153200     | 1940      | 3        | 3        | 0         |
| 56127     | 052 09 0 028.00 | SINGLE FAMILY | 1017 BFALLS  AVE, MADISON    | 2016-10-31 00:00:00.000 | 390000    | 20161103-0116430 | No           | GULLO-CHALMERS JV                    | 1017 B FALLS AVE, MADISON, TN    | 0.4     | GENERAL SERVICES DISTRICT | 54000     | 42800         | 96800      | 1940      | 2        | 1        | 0         |
| 38146     | 052 09 0 035.00 | SINGLE FAMILY | 1136  GOLDILOCKS ST, MADISON | 2015-09-04 00:00:00.000 | 520000    | 20150916-0093955 | No           | JRG PROPERTIES, LLC                  | 1136  GOLDILOCKS ST, MADISON, TN | 0.25    | GENERAL SERVICES DISTRICT | 16000     | 46400         | 62400      | 1950      | 2        | 1        | 0         |
| 56128     | 052 09 0 037.00 | SINGLE FAMILY | 331 DUE WEST  AVE, MADISON   | 2016-10-04 00:00:00.000 | 70000     | 20161018-0109986 | No           | TITUS-TUTTLE, COREY W.               | 331  DUE WEST AVE, MADISON, TN   | 0.22    | GENERAL SERVICES DISTRICT | 16000     | 53500         | 69500      | 1950      | 2        | 1        | 0         |
| 38147     | 052 09 0 039.00 | SINGLE FAMILY | 1137  GOLDILOCKS ST, MADISON | 2015-09-04 00:00:00.000 | 520000    | 20150916-0093955 | No           | JRG PROPERTIES, LLC                  | 1137  GOLDILOCKS ST, MADISON, TN | 0.25    | GENERAL SERVICES DISTRICT | 16000     | 48600         | 64600      | 1950      | 2        | 1        | 0         |
| 50693     | 052 09 0 049.00 | SINGLE FAMILY | 1125 CINDERELLA  ST, MADISON | 2016-06-01 00:00:00.000 | 180000    | 20160606-0056539 | No           | HOLLOWAY, TAMARA & MONTGOMERY, LOREN | 1125  CINDERELLA ST, MADISON, TN | 0.27    | GENERAL SERVICES DISTRICT | 16000     | 119800        | 142600     | 1946      | 3        | 2        | 0         |
--------------------------------------------------------------------------------------------------------------------------

# 1. Standardize Date Format
* The `CONVERT()` function converts a value (of any type) into a specified datatype.

* `ALTER TABLE` statement is used to add, delete, or modify columns in an existing table.

* `UPDATE` statement is used to modify the existing records in a table.

* Convert String Date to Date datatype
```
SELECT SaleDate, CONVERT(Date, SaleDate)
  FROM [PortfolioProject].[dbo].[Nashville]
```
| SaleDate                | (No column name)  |
|-------------------------|-------------------|
| 2016-10-31 00:00:00.000 | 2016-10-31        |
| 2016-10-31 00:00:00.000 | 2016-10-31        |
| 2015-09-04 00:00:00.000 | 2015-09-04        |
| 2016-10-04 00:00:00.000 | 2016-10-04        |

* Add "SaleDateConverted" column in table
```
Alter Table Nashville
Add SaleDateConverted Date;
```
![image](https://github.com/asmshkhaws/Nashville_Housing_SQL/assets/119579424/8d2eefe1-77ef-44b9-ad0f-338a1159d102)

* Update "SaleDateConverted" column
```
Update Nashville
Set SaleDateConverted = CONVERT(Date, SaleDate)
```
![image](https://github.com/asmshkhaws/Nashville_Housing_SQL/assets/119579424/cda27ba7-b505-4173-b939-d046b0020e89)

```
SELECT SaleDateConverted
  FROM [PortfolioProject].[dbo].[Nashville]
```
| SaleDateConverted  |
|--------------------|
| 2016-10-31         |
| 2016-10-31         |
| 2015-09-04         |
| 2016-10-04         |

 --------------------------------------------------------------------------------------------------------------------------
# 2. Populate Property Address data
* ParcelID and Address is dependant, so where address is null we can use ParcelID to fill null address

* `ISNULL()` function returns a specified value if the expression is NULL. Syntax: `ISNULL(expression, value)`
* List Null value in "PropertyAddress" column

```
SELECT PropertyAddress
  FROM [PortfolioProject].[dbo].[Nashville]
  Where PropertyAddress is Null
```
| PropertyAddress  |
|------------------|
| NULL             |
| NULL             |
| NULL             |
| NULL             |

* List Null value in "PropertyAddress" column
```
SELECT *
  FROM [PortfolioProject].[dbo].[Nashville]
  Where PropertyAddress is Null
```
| UniqueID  | ParcelID         | LandUse                 | PropertyAddress | SaleDate                | SalePrice | LegalReference   | SoldAsVacant | OwnerName                        | OwnerAddress                           | Acreage | TaxDistrict            | LandValue | BuildingValue | TotalValue | YearBuilt | Bedrooms | FullBath | HalfBath |
|-----------|------------------|-------------------------|-----------------|-------------------------|-----------|------------------|--------------|----------------------------------|----------------------------------------|---------|------------------------|-----------|---------------|------------|-----------|----------|----------|----------|
| 43076     | 025 07 0 031.00  | SINGLE FAMILY           | NULL            | 2016-01-15 00:00:00.000 | 179900    | 20160120-0005776 | No           | COSTNER, FRED & CAROLYN          | 410  ROSEHILL CT, GOODLETTSVILLE, TN   | 0.96    | CITY OF GOODLETTSVILLE | 30000     | 70000         | 100000     | 1964      | 3        | 1        | 0        |
| 39432     | 026 01 0 069.00  | VACANT RESIDENTIAL LAND | NULL            | 2015-10-23 00:00:00.000 | 153000    | 20151028-0109602 | No           | SHACKLEFORD, MICHAEL C., JR.     | 141  TWO MILE PIKE, GOODLETTSVILLE, TN | 0.17    | CITY OF GOODLETTSVILLE | 21100     | 121600        | 142700     | 2015      | 3        | 2        | 0        |
| 45290     | 026 05 0 017.00  | SINGLE FAMILY           | NULL            | 2016-03-29 00:00:00.000 | 155000    | 20160330-0029941 | No           | TRIPP, MARVIN S. & DEBORAH YOUNG | 208  EAST AVE, GOODLETTSVILLE, TN      | 0.2     | CITY OF GOODLETTSVILLE | 21100     | 130200        | 151300     | 2008      | 3        | 2        | 0        |
| 53147     | 026 06 0A 038.00 | RESIDENTIAL CONDO       | NULL            | 2016-08-25 00:00:00.000 | 144900    | 20160831-0091567 | No           | NULL                             | NULL                                   | NULL    | NULL                   | NULL      | NULL          | NULL       | NULL      | NULL     | NULL     | NULL     |


* Combine table on "ParcelID" column to fill null values of "PropertyAddress".
```
SELECT a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress, b.PropertyAddress)
  FROM [PortfolioProject].[dbo].[Nashville] a
  Join [PortfolioProject].[dbo].[Nashville] b
  on a.ParcelID = b.ParcelID
  and a.[UniqueID ] <> b.[UniqueID ]
  Where a.PropertyAddress is Null
```
| ParcelID         | PropertyAddress | ParcelID         | PropertyAddress                    | (No column name)                    |
|------------------|-----------------|------------------|------------------------------------|-------------------------------------|
| 025 07 0 031.00  | NULL            | 025 07 0 031.00  | 410  ROSEHILL CT, GOODLETTSVILLE   | 410  ROSEHILL CT, GOODLETTSVILLE    |
| 026 01 0 069.00  | NULL            | 026 01 0 069.00  | 141  TWO MILE PIKE, GOODLETTSVILLE | 141  TWO MILE PIKE, GOODLETTSVILLE  |
| 026 05 0 017.00  | NULL            | 026 05 0 017.00  | 208  EAST AVE, GOODLETTSVILLE      | 208  EAST AVE, GOODLETTSVILLE       |
| 026 06 0A 038.00 | NULL            | 026 06 0A 038.00 | 109  CANTON CT, GOODLETTSVILLE     | 109  CANTON CT, GOODLETTSVILLE      |

* UPDATE accepts only aliases (a)
```
Update a
Set PropertyAddress = ISNULL(a.PropertyAddress, b.PropertyAddress)
  FROM [PortfolioProject].[dbo].[Nashville] a
  Join [PortfolioProject].[dbo].[Nashville] b
  on a.ParcelID = b.ParcelID
  and a.[UniqueID ] <> b.[UniqueID ]
  Where a.PropertyAddress is Null
```
![image](https://github.com/asmshkhaws/Nashville_Housing_SQL/assets/119579424/4731a003-e12d-4a92-8cb0-7b3afa429ec6)

--------------------------------------------------------------------------------------------------------------------------
# 3. Breaking out PropertyAddress into Individual Columns (Address, City)

* `SUBSTRING()` function extracts some characters from a string. Syntax: `SUBSTRING(string, start, length)`
* `CHARINDEX()` function searches for a substring in a string, and returns the position. Syntax: `CHARINDEX(substring, string, start)`
* `LEN()` function returns the length of a string. Syntax: `LEN(string)`
* Displays "PropertyAddress" column
```
Select PropertyAddress
From [PortfolioProject].[dbo].[Nashville]
```
| PropertyAddress               |
|-------------------------------|
| 1017 AFALLS  AVE, MADISON     |
| 1017 BFALLS  AVE, MADISON     |
| 1136  GOLDILOCKS ST, MADISON  |
| 331 DUE WEST  AVE, MADISON    |
| 1137  GOLDILOCKS ST, MADISON  |

* Extract "PropertyAddress" using SUBSTRING(string, start, length), CHARINDEX(substring, string, start), LEN(string)
```
Select
SUBSTRING(PropertyAddress, 1, charindex(',',PropertyAddress)-1) as Address,
Substring(PropertyAddress, charindex(',',PropertyAddress)+1, LEN(PropertyAddress)) as Address
From [PortfolioProject].[dbo].[Nashville]
```
| Address             | Address   |
|---------------------|-----------|
| 1017 AFALLS  AVE    |  MADISON  |
| 1017 BFALLS  AVE    |  MADISON  |
| 1136  GOLDILOCKS ST |  MADISON  |
| 331 DUE WEST  AVE   |  MADISON  |
| 1137  GOLDILOCKS ST |  MADISON  |

* Add "PropertySplitAddress" column
```
Alter Table [PortfolioProject].[dbo].[Nashville]
Add PropertySplitAddress nvarchar(255);
```
![image](https://github.com/asmshkhaws/Nashville_Housing_SQL/assets/119579424/fccc0781-9556-4e79-96a5-f73638ddfb90)

* Update "PropertySplitAddress" column
```
Update [PortfolioProject].[dbo].[Nashville]
Set PropertySplitAddress = SUBSTRING(PropertyAddress, 1, charindex(',',PropertyAddress)-1)
```
![image](https://github.com/asmshkhaws/Nashville_Housing_SQL/assets/119579424/0afb1907-e441-4107-a3df-96b5a43ff2f4)

* Add "PropertySplitCity" column
```
Alter Table [PortfolioProject].[dbo].[Nashville]
Add PropertySplitCity nvarchar(255);
```
![image](https://github.com/asmshkhaws/Nashville_Housing_SQL/assets/119579424/9502efe4-e327-46ff-a7ff-70bae432b953)

* Update "PropertySplitCity" column
```
Update [PortfolioProject].[dbo].[Nashville]
Set PropertySplitCity = Substring(PropertyAddress, charindex(',',PropertyAddress)+1, LEN(PropertyAddress))
```
![image](https://github.com/asmshkhaws/Nashville_Housing_SQL/assets/119579424/53f8fb06-bf6f-4555-9496-af0cf0e15b3a)

```
Select *
From [PortfolioProject].[dbo].[Nashville]
```
| PropertyAddress              | SaleDate                | SalePrice | LegalReference   | SoldAsVacant | OwnerName              | OwnerAddress                     | Acreage | TaxDistrict               | LandValue | BuildingValue | TotalValue | YearBuilt | Bedrooms | FullBath | HalfBath | SaleDateConverted | PropertySplitAddress | PropertySplitCity  |
|------------------------------|-------------------------|-----------|------------------|--------------|------------------------|----------------------------------|---------|---------------------------|-----------|---------------|------------|-----------|----------|----------|----------|-------------------|----------------------|--------------------|
| 1017 AFALLS  AVE, MADISON    | 2016-10-31 00:00:00.000 | 390000    | 20161103-0116430 | No           | GULLO-CHALMERS JV      | 1017 A FALLS AVE, MADISON, TN    | 0.39    | GENERAL SERVICES DISTRICT | 54000     | 90300         | 153200     | 1940      | 3        | 3        | 0        | 2016-10-31        | 1017 AFALLS  AVE     |  MADISON           |
| 1017 BFALLS  AVE, MADISON    | 2016-10-31 00:00:00.000 | 390000    | 20161103-0116430 | No           | GULLO-CHALMERS JV      | 1017 B FALLS AVE, MADISON, TN    | 0.4     | GENERAL SERVICES DISTRICT | 54000     | 42800         | 96800      | 1940      | 2        | 1        | 0        | 2016-10-31        | 1017 BFALLS  AVE     |  MADISON           |
| 1136  GOLDILOCKS ST, MADISON | 2015-09-04 00:00:00.000 | 520000    | 20150916-0093955 | No           | JRG PROPERTIES, LLC    | 1136  GOLDILOCKS ST, MADISON, TN | 0.25    | GENERAL SERVICES DISTRICT | 16000     | 46400         | 62400      | 1950      | 2        | 1        | 0        | 2015-09-04        | 1136  GOLDILOCKS ST  |  MADISON           |
| 331 DUE WEST  AVE, MADISON   | 2016-10-04 00:00:00.000 | 70000     | 20161018-0109986 | No           | TITUS-TUTTLE, COREY W. | 331  DUE WEST AVE, MADISON, TN   | 0.22    | GENERAL SERVICES DISTRICT | 16000     | 53500         | 69500      | 1950      | 2        | 1        | 0        | 2016-10-04        | 331 DUE WEST  AVE    |  MADISON           |

--------------------------------------------------------------------------------------------------------------------------
# 4. Breaking out OwnerAddress into Individual Columns (Address, City, State)
* `PARSENAME()` useful when you’re dealing with objects that have multiple parts separated by a delimiter, such as a dot (“.”), and you need to retrieve a specific part. Syntax: `PARSENAME ('object_name' , object_piece )`
* Extract "OwnerAddress" column using PARSENAME, and replace "," with "." as PARSENAME works only with "." delimeter
```
Select
Parsename(Replace(OwnerAddress, ',', '.'), 3),
Parsename(Replace(OwnerAddress, ',', '.'), 2),
Parsename(Replace(OwnerAddress, ',', '.'), 1)
From [PortfolioProject].[dbo].[Nashville]
```
| (No column name)    | (No column name) | (No column name)  |
|---------------------|------------------|-------------------|
| 1017 A FALLS AVE    |  MADISON         |  TN               |
| 1017 B FALLS AVE    |  MADISON         |  TN               |
| 1136  GOLDILOCKS ST |  MADISON         |  TN               |
| 331  DUE WEST AVE   |  MADISON         |  TN               |
| 1137  GOLDILOCKS ST |  MADISON         |  TN               |

* Add "OwnerSplitAddress" column
```
Alter Table [PortfolioProject].[dbo].[Nashville]
Add OwnerSplitAddress nvarchar(255);
```
![image](https://github.com/asmshkhaws/Nashville_Housing_SQL/assets/119579424/4f03c230-1df0-4818-b99b-c52549c8fb04)

* Update "OwnerSplitAddress" column
```
Update [PortfolioProject].[dbo].[Nashville]
Set OwnerSplitAddress = Parsename(Replace(OwnerAddress, ',', '.'), 3)
```
![image](https://github.com/asmshkhaws/Nashville_Housing_SQL/assets/119579424/ccbc4156-f5ce-49f1-9bc1-b229162c7343)

* Add "OwnerSplitCity" column
```
Alter Table [PortfolioProject].[dbo].[Nashville]
Add OwnerSplitCity nvarchar(255);
```
* Update "OwnerSplitCity" column
```
Update [PortfolioProject].[dbo].[Nashville]
Set OwnerSplitCity = Parsename(Replace(OwnerAddress, ',', '.'), 2)
```
* Add "OwnerSplitState" column
```
Alter Table [PortfolioProject].[dbo].[Nashville]
Add OwnerSplitState nvarchar(255);
```
* Update "OwnerSplitState" column
```
Update [PortfolioProject].[dbo].[Nashville]
Set OwnerSplitState = Parsename(Replace(OwnerAddress, ',', '.'), 1)
```
```
Select *
From [PortfolioProject].[dbo].[Nashville]
```
| OwnerSplitAddress   | OwnerSplitCity | OwnerSplitState  |
|---------------------|----------------|------------------|
| 1017 A FALLS AVE    |  MADISON       |  TN              |
| 1017 B FALLS AVE    |  MADISON       |  TN              |
| 1136  GOLDILOCKS ST |  MADISON       |  TN              |
| 331  DUE WEST AVE   |  MADISON       |  TN              |
| 1137  GOLDILOCKS ST |  MADISON       |  TN              |

--------------------------------------------------------------------------------------------------------------------------
# 5. Change Y and N to Yes and No in "Sold as Vacant" field

* `CASE` expression goes through conditions and returns a value when the first condition is met (like an if-then-else statement).
* Using Distinct query fetch number of 'Y', 'N' values in "SoldAsVacant" column
```
Select Distinct(SoldAsVacant), Count(SoldAsVacant)
From [PortfolioProject].[dbo].[Nashville]
Group by SoldAsVacant
Order by 2
```
| SoldAsVacant | (No column name)  |
|--------------|-------------------|
| Y            | 52                |
| N            | 399               |
| Yes          | 4623              |
| No           | 51403             |

* Using CASE statement replace Y,N with Yes , No.
```
Select SoldAsVacant,
	Case
		When SoldAsVacant = 'Y' Then 'Yes'
		When SoldAsVacant = 'N' Then 'No'
		Else SoldAsVacant
	End
From [PortfolioProject].[dbo].[Nashville] 
```
| SoldAsVacant | (No column name)  |
|--------------|-------------------|
| N            | No                |
| Y            | Yes               |

* Update "SoldAsVacant" column
```
Update [PortfolioProject].[dbo].[Nashville]
Set SoldAsVacant =
	Case
		When SoldAsVacant = 'Y' Then 'Yes'
		When SoldAsVacant = 'N' Then 'No'
		Else SoldAsVacant
	End
```
![image](https://github.com/asmshkhaws/Nashville_Housing_SQL/assets/119579424/f3043530-4a36-4909-9b19-d13241826a6f)

-----------------------------------------------------------------------------------------------------------------------------------------------------------
# 6. Remove Duplicates (Usually we dont delete duplicate rows in SQL)
* Check Duplicates
* `CTE` act as virtual tables that are created during query execution, used by the query, and deleted after the query executes.
* `ROW_NUMBER` function is a SQL ranking function that assigns a sequential rank number to each new record in a partition.
* `ROW_NUMBER` Syntax:
```
ROW_NUMBER() OVER (
[PARTITION BY partition_expression, ... ]
ORDER BY sort_expression [ASC | DESC], ...
)
```
* Use CTE to remove multiple duplicate records(rows) in Table
```
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
```
| LegalReference   | SoldAsVacant | OwnerName                               | OwnerAddress                             | Acreage | TaxDistrict             | LandValue | BuildingValue | TotalValue | YearBuilt | Bedrooms | FullBath | HalfBath | SaleDateConverted | PropertySplitAddress      | PropertySplitCity | OwnerSplitAddress         | OwnerSplitCity | OwnerSplitState | row_num  |
|------------------|--------------|-----------------------------------------|------------------------------------------|---------|-------------------------|-----------|---------------|------------|-----------|----------|----------|----------|-------------------|---------------------------|-------------------|---------------------------|----------------|-----------------|----------|
| 20150205-0010843 | No           | URBANGATE DEVELOPMENT GROUP, LLC        | 1728  PECAN ST, NASHVILLE, TN            | 0.17    | URBAN SERVICES DISTRICT | 11000     | 42700         | 54100      | 1968      | 2        | 1        | 0        | 2015-02-02        | 1728  PECAN ST            |  NASHVILLE        | 1728  PECAN ST            |  NASHVILLE     |  TN             | 2        |
| 20150223-0015122 | No           | SOUTHERN STATES PROPERTY, LLC           | 1806  15TH AVE N, NASHVILLE, TN          | 0.16    | URBAN SERVICES DISTRICT | 11000     | 58700         | 69700      | 1930      | 3        | 2        | 0        | 2015-02-17        | 1806  15TH AVE N          |  NASHVILLE        | 1806  15TH AVE N          |  NASHVILLE     |  TN             | 2        |
| 20150218-0013602 | No           | WANG, YUTIEN TERRY                      | 1710  DR D B TODD JR BLVD, NASHVILLE, TN | 0.07    | URBAN SERVICES DISTRICT | 13000     | 35300         | 48300      | 1920      | 2        | 1        | 0        | 2015-02-13        | 1710  DR D B TODD JR BLVD |  NASHVILLE        | 1710  DR D B TODD JR BLVD |  NASHVILLE     |  TN             | 2        |
| 20150210-0012450 | Yes          | MCCAFFERY, THOMAS P. & YOUNG, SYDNEY E. | 1718  ARTHUR AVE, NASHVILLE, TN          | 0.11    | URBAN SERVICES DISTRICT | 13000     | 157200        | 174200     | 2016      | 4        | 2        | 1        | 2015-02-09        | 1718  ARTHUR AVE          |  NASHVILLE        | 1718  ARTHUR AVE          |  NASHVILLE     |  TN             | 2        |
| 20150224-0015904 | No           | JRG PROPERTIES, LLC                     | 1626  25TH AVE N, NASHVILLE, TN          | 0.14    | URBAN SERVICES DISTRICT | 13000     | 30100         | 43100      | 1940      | 2        | 1        | 0        | 2015-02-20        | 1626  25TH AVE N          |  NASHVILLE        | 1626  25TH AVE N          |  NASHVILLE     |  TN             | 2        |

* Delete Duplicates
* Edit (Delete From RowNumCTE) instead of (Select* From RowNumCTE)
```
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
```
![image](https://github.com/asmshkhaws/Nashville_Housing_SQL/assets/119579424/728f570d-b7db-4b8f-8df4-69c0c0ab13a7)

---------------------------------------------------------------------------------------------------------
# 7. Delete Unused Columns
```
ALTER TABLE [PortfolioProject].[dbo].[Nashville]
DROP COLUMN OwnerAddress, TaxDistrict, PropertyAddress, SaleDate
```
![image](https://github.com/asmshkhaws/Nashville_Housing_SQL/assets/119579424/4356ddd4-be50-4491-818b-278338810736)

```
SELECT *
FROM [PortfolioProject].[dbo].[Nashville]
```
| ParcelID        | LandUse       | SalePrice | LegalReference   | SoldAsVacant | OwnerName              | Acreage | LandValue | BuildingValue | TotalValue | YearBuilt | Bedrooms | FullBath | HalfBath | SaleDateConverted | PropertySplitAddress | PropertySplitCity | OwnerSplitAddress   | OwnerSplitCity | OwnerSplitState  |
|-----------------|---------------|-----------|------------------|--------------|------------------------|---------|-----------|---------------|------------|-----------|----------|----------|----------|-------------------|----------------------|-------------------|---------------------|----------------|------------------|
| 052 09 0 027.00 | SINGLE FAMILY | 390000    | 20161103-0116430 | No           | GULLO-CHALMERS JV      | 0.39    | 54000     | 90300         | 153200     | 1940      | 3        | 3        | 0        | 2016-10-31        | 1017 AFALLS  AVE     |  MADISON          | 1017 A FALLS AVE    |  MADISON       |  TN              |
| 052 09 0 028.00 | SINGLE FAMILY | 390000    | 20161103-0116430 | No           | GULLO-CHALMERS JV      | 0.4     | 54000     | 42800         | 96800      | 1940      | 2        | 1        | 0        | 2016-10-31        | 1017 BFALLS  AVE     |  MADISON          | 1017 B FALLS AVE    |  MADISON       |  TN              |
| 052 09 0 035.00 | SINGLE FAMILY | 520000    | 20150916-0093955 | No           | JRG PROPERTIES, LLC    | 0.25    | 16000     | 46400         | 62400      | 1950      | 2        | 1        | 0        | 2015-09-04        | 1136  GOLDILOCKS ST  |  MADISON          | 1136  GOLDILOCKS ST |  MADISON       |  TN              |
| 052 09 0 037.00 | SINGLE FAMILY | 70000     | 20161018-0109986 | No           | TITUS-TUTTLE, COREY W. | 0.22    | 16000     | 53500         | 69500      | 1950      | 2        | 1        | 0        | 2016-10-04        | 331 DUE WEST  AVE    |  MADISON          | 331  DUE WEST AVE   |  MADISON       |  TN              |
| 052 09 0 039.00 | SINGLE FAMILY | 520000    | 20150916-0093955 | No           | JRG PROPERTIES, LLC    | 0.25    | 16000     | 48600         | 64600      | 1950      | 2        | 1        | 0        | 2015-09-04        | 1137  GOLDILOCKS ST  |  MADISON          | 1137  GOLDILOCKS ST |  MADISON       |  TN              |


---------------------------------------------------------------------------------------------------------

# Check Column name of table
```
SELECT 
COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
where TABLE_NAME = 'Nashville'
```
| UniqueID              |
|-----------------------|
| ParcelID              |
| LandUse               |
| SalePrice             |
| LegalReference        |
| SoldAsVacant          |
| OwnerName             |
| Acreage               |
| LandValue             |
| BuildingValue         |
| TotalValue            |
| YearBuilt             |
| Bedrooms              |
| FullBath              |
| HalfBath              |
| SaleDateConverted     |
| PropertySplitAddress  |
| PropertySplitCity     |
| OwnerSplitAddress     |
| OwnerSplitCity        |

---------------------------------------------------------------------------------------------------------
# Check Data Type of Column
```
SELECT 
TABLE_CATALOG,
TABLE_SCHEMA,
TABLE_NAME, 
COLUMN_NAME, 
DATA_TYPE 
FROM INFORMATION_SCHEMA.COLUMNS
where TABLE_NAME = 'Nashville' 
--and COLUMN_NAME = 'ParcelID'
```
| TABLE_CATALOG    | TABLE_SCHEMA | TABLE_NAME | COLUMN_NAME          | DATA_TYPE  |
|------------------|--------------|------------|----------------------|------------|
| PortfolioProject | dbo          | Sheet1$    | UniqueID             | float      |
| PortfolioProject | dbo          | Sheet1$    | ParcelID             | nvarchar   |
| PortfolioProject | dbo          | Sheet1$    | LandUse              | nvarchar   |
| PortfolioProject | dbo          | Sheet1$    | SalePrice            | float      |
| PortfolioProject | dbo          | Sheet1$    | LegalReference       | nvarchar   |
| PortfolioProject | dbo          | Sheet1$    | SoldAsVacant         | nvarchar   |
| PortfolioProject | dbo          | Sheet1$    | OwnerName            | nvarchar   |
| PortfolioProject | dbo          | Sheet1$    | Acreage              | float      |
| PortfolioProject | dbo          | Sheet1$    | LandValue            | float      |
| PortfolioProject | dbo          | Sheet1$    | BuildingValue        | float      |
| PortfolioProject | dbo          | Sheet1$    | TotalValue           | float      |
| PortfolioProject | dbo          | Sheet1$    | YearBuilt            | float      |
| PortfolioProject | dbo          | Sheet1$    | Bedrooms             | float      |
| PortfolioProject | dbo          | Sheet1$    | FullBath             | float      |
| PortfolioProject | dbo          | Sheet1$    | HalfBath             | float      |
| PortfolioProject | dbo          | Sheet1$    | SaleDateConverted    | date       |
| PortfolioProject | dbo          | Sheet1$    | PropertySplitAddress | nvarchar   |
| PortfolioProject | dbo          | Sheet1$    | PropertySplitCity    | nvarchar   |
| PortfolioProject | dbo          | Sheet1$    | OwnerSplitAddress    | nvarchar   |

---------------------------------------------------------------------------------------------------------
# Move Column
```
--Alter Table NashvilleHousing Change column [SaleDateConverted] After ParcelID;
--ALTER TABLE NashvilleHousing MODIFY COLUMN SaleDateConverted Date AFTER ParcelID ;
```







------------------------------
