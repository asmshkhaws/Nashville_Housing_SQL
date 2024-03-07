# SQL-Nashville-Data-Cleaning

**Author**: Asim Ejaz Sheikh <br />
**Email**: asm.shkh@gmail.com <br />
**Website**: https://asmshkhaws.github.io/Data_Analyst_Website/ <br />

:exclamation: If you find this repository helpful, please consider giving it a :star:. Thanks! :exclamation:

# Cleaning the Nashville Housing Dataset using SQL.

I have cleaned this data using SQL queries. Here the data was retrieved, understood and then accordingly updated.

# What was done?
- Converting String Date to Date datatype.
- Updating missing values in Address Column.
- Breaking out PropertyAddress, Owner Address into individual columns
- Change Y and N to Yes and No in 'SoldasVacant' field.
- Removing Duplicates and redudndant columns.

# Files
- Dataset: [Nashville Housing Data.xlsx](Dataset/Nashville_Housing_Data.xlsx)
- Steps: [Complete_Queries](SQL_QUERIES.md)
- File: [Nashville.sql](Nashville.sql)

# Dataset

This dataset has 56447 records. It primarily describes the Nashville property's detail containing the Owner and its property details.

Description of the variables:

- `UniqueID`: Primary key
- `ParcelID` : varchar
- `LandUse` : varchar, Type of the property e.g Condo, Church, Apartment, Daycare
- `PropertyAddress` : varchar
- `SaleDate`: Date
- `SalePrice`: Integer
- `LegalReference` : varchar 
- `SoldAsVacant` : Bool, Yes/ No
- `OwnerName`: varchar
- `OwnerAddress` : varchar
- `Acreage` : Float
- `TaxDistrict` : varchar
- `LandValue` : Integer
- `BuildingValue` : Integer
- `TotalValue` : Integer
- `YearBuilt` : Integer
- `Bedrooms` : Integer
- `FullBath` : Integer
- `HalfBath` : Integer
