# SQL-Nashville-Data-Cleaning

**Author**: Asim Ejaz Sheikh <br />
**Email**: asm.shkh@gmail.com <br />
**Website**: https://asmshkhaws.github.io/Data_Analyst_Website/ <br />

:exclamation: If you find this repository helpful, please consider giving it a :star:. Thanks! :exclamation:

# Cleaning the Nashville Housing Dataset using SQL.
I did something amazing this year! 🌟 In my journey as a data analyst, I tackled the Nashville Housing Dataset and cleaned it using SQL queries. Let me walk you through the steps I took to ensure the data was accurate and ready for analysis. 

# What was done?
1️⃣ Converting String Date to Date datatype was the first task on my list. This ensured consistency and efficiency in handling date-related queries.

2️⃣ Updating missing values in the Address Column was crucial for the dataset's completeness. By filling in these gaps, we improved the overall quality of the information.

3️⃣ Breaking out PropertyAddress and Owner Address into individual columns made the data more organized and easier to work with. This separation allowed for better analysis and visualization of the property and owner details.

4️⃣ Changing 'Y' and 'N' to 'Yes' and 'No' in the 'SoldAsVacant' field provided clarity and improved the dataset's readability.

5️⃣ Removing duplicates and redundant columns streamlined the dataset, eliminating unnecessary information and reducing clutter.

# Dataset
This Nashville Housing Dataset, with its 56447 records, contains valuable insights into property details and ownership information. By cleaning this data effectively, we set a solid foundation for further analysis and decision-making.

🔍 Have you ever cleaned a dataset using SQL queries? What challenges did you face, and how did you overcome them? Let's discuss! 
I have cleaned this data using SQL queries. Here the data was retrieved, understood and then accordingly updated.

# Files
- Dataset: [Nashville Housing Data.xlsx](Dataset/Nashville_Housing_Data.xlsx)
- Steps: [Complete_Queries](SQL_QUERIES.md)
- File: [Nashville.sql](Nashville.sql)


# Description of the variables:

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
