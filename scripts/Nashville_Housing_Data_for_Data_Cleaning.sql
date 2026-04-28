/*
Purpose:
This script performs end-to-end ETL (Extract, Transform, Load) for the Nashville Housing dataset.
It moves raw data from the Bronze layer to the Silver layer, applies data cleaning and standardization,
and finally loads a clean dataset into the Gold layer for analytical reporting.
*/

-- Move raw data from Bronze layer to Silver layer (staging for transformation)
INSERT INTO silver.NashvilleHousing
SELECT *
FROM bronze.NashvilleHousing;

-- Quick validation of Silver layer load
SELECT *
FROM silver.NashvilleHousing;

--------------------------------------------------------------------------------------------------------------------------

-- Attempt to standardize SaleDate (initial attempt noted as problematic)
SELECT
	SaleDate,
	SaleDateClean
FROM silver.NashvilleHousing;

-- NOTE: Direct update attempt may fail depending on existing data type constraints
UPDATE silver.NashvilleHousing
SET SaleDate = CAST(SaleDate AS DATE);

-- Add cleaned date column for proper transformation
ALTER TABLE silver.NashvilleHousing
ADD SaleDateClean DATE;

-- Populate cleaned date column using CAST conversion
UPDATE silver.NashvilleHousing
SET SaleDateClean = CAST(SaleDate AS DATE);

--------------------------------------------------------------------------------------------------------------------------

-- Fill missing PropertyAddress values using other records with same ParcelID
-- This assumes ParcelID uniquely identifies a property across records
SELECT
	a.ParcelID,
	a.PropertyAddress,
	b.ParcelID,
	b.PropertyAddress,
	COALESCE(a.PropertyAddress, b.PropertyAddress)
FROM silver.NashvilleHousing AS a
INNER JOIN silver.NashvilleHousing AS b
	ON a.ParcelID = b.ParcelID
	AND a.UniqueID != b.UniqueID
WHERE a.PropertyAddress IS NULL;

UPDATE a
SET PropertyAddress = COALESCE(a.PropertyAddress, b.PropertyAddress)
FROM silver.NashvilleHousing AS a
INNER JOIN silver.NashvilleHousing AS b
	ON a.ParcelID = b.ParcelID
	AND a.UniqueID != b.UniqueID
WHERE a.PropertyAddress IS NULL;

--------------------------------------------------------------------------------------------------------------------------

-- Split PropertyAddress into Street Address and City components
SELECT
	PropertyAddress,
	TRIM(SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) - 1)) AS PropertyAddressClean,
	TRIM(SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1, LEN(PropertyAddress))) AS PropertyCityClean
FROM silver.NashvilleHousing;

ALTER TABLE silver.NashvilleHousing
ADD PropertyAddressClean NVARCHAR(255);

UPDATE silver.NashvilleHousing
SET PropertyAddressClean = TRIM(SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) - 1));

ALTER TABLE silver.NashvilleHousing
ADD PropertyCityClean NVARCHAR(255);

UPDATE silver.NashvilleHousing
SET PropertyCityClean = TRIM(SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1, LEN(PropertyAddress)));

--------------------------------------------------------------------------------------------------------------------------

-- Split OwnerAddress into Address, City, and State using PARSENAME workaround
SELECT
	OwnerAddress,
	PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3),
	PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2),
	PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1)
FROM silver.NashvilleHousing;

ALTER TABLE silver.NashvilleHousing
ADD OwnerAddressClean NVARCHAR(255);

UPDATE silver.NashvilleHousing
SET OwnerAddressClean = TRIM(PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3));

ALTER TABLE silver.NashvilleHousing
ADD OwnerCityClean NVARCHAR(255);

UPDATE silver.NashvilleHousing
SET OwnerCityClean = TRIM(PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2));

ALTER TABLE silver.NashvilleHousing
ADD OwnerStateClean NVARCHAR(255);

UPDATE silver.NashvilleHousing
SET OwnerStateClean = TRIM(PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1));

--------------------------------------------------------------------------------------------------------------------------

-- Standardize SoldAsVacant values for consistency (Y/N → Yes/No)
SELECT DISTINCT
	SoldAsVacant,
	CASE
		WHEN SoldAsVacant = 'Y' THEN 'Yes'
		WHEN SoldAsVacant = 'N' THEN 'No'
		ELSE SoldAsVacant
	END AS SoldAsVacantClean
FROM silver.NashvilleHousing;

UPDATE silver.NashvilleHousing
SET SoldAsVacant =
	CASE
		WHEN SoldAsVacant = 'Y' THEN 'Yes'
		WHEN SoldAsVacant = 'N' THEN 'No'
		ELSE SoldAsVacant
	END;

--------------------------------------------------------------------------------------------------------------------------

-- Remove duplicate records based on key business identifiers
WITH duplicates_check AS (
	SELECT
		ROW_NUMBER() OVER (
			PARTITION BY ParcelID, PropertyAddress, SalePrice, SaleDate, LegalReference
			ORDER BY UniqueID
		) AS rn,
		*
	FROM silver.NashvilleHousing
)
DELETE
FROM duplicates_check
WHERE rn > 1;

--------------------------------------------------------------------------------------------------------------------------

-- Create analytics-ready Gold layer table
USE portfolio_project_3;
GO

CREATE TABLE gold.NashvilleHousing (
    UniqueID INT NOT NULL,
    ParcelID NVARCHAR(50) NOT NULL,
    LandUse NVARCHAR(50) NOT NULL,
    PropertyAddress NVARCHAR(50) NULL,
    SaleDate DATETIME NOT NULL,
    SalePrice MONEY NOT NULL,
    LegalReference NVARCHAR(50) NOT NULL,
    SoldAsVacant NVARCHAR(50) NOT NULL,
    OwnerName NVARCHAR(100) NULL,
    OwnerAddress NVARCHAR(50) NULL,
    Acreage FLOAT NULL,
    TaxDistrict NVARCHAR(50) NULL,
    LandValue INT NULL,
    BuildingValue INT NULL,
    TotalValue INT NULL,
    YearBuilt INT NULL,
    Bedrooms INT NULL,
    FullBath INT NULL,
    HalfBath INT NULL,
    SaleDateClean DATE NULL,
    PropertyAddressClean NVARCHAR(255) NULL,
    PropertyCityClean NVARCHAR(255) NULL,
    OwnerAddressClean NVARCHAR(255) NULL,
    OwnerCityClean NVARCHAR(255) NULL,
    OwnerStateClean NVARCHAR(255) NULL,
	CONSTRAINT PK_NashvilleHousing PRIMARY KEY (UniqueID)
);
GO

-- Load cleaned and transformed data into Gold layer
INSERT INTO gold.NashvilleHousing
SELECT *
FROM silver.NashvilleHousing;
GO
