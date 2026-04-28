# 🏠 Nashville Housing ETL Pipeline (SQL Server)

## 📌 Project Overview
This project builds an end-to-end ETL pipeline for the Nashville Housing dataset using SQL Server.
It follows a Medallion Architecture (Bronze → Silver → Gold) to clean, transform, and structure raw housing data for analytics and reporting.
The goal is to demonstrate data cleaning, transformation using SQL.

**Description**: The dataset contains a list of houses that have been sold in Nashville between 2013 and 2019

## 🏗️ Data Architecture

### 🥉 Bronze Layer (Raw Data)

- Direct ingestion from source dataset
- No transformations applied

### 🥈 Silver Layer (Cleaned Data)

- Data cleansing and standardization
- Handling missing values and duplicates
- Feature engineering and column splitting

### 🥇 Gold Layer (Analytics-Ready Data)

- Structured schema for reporting
- Fully cleaned and validated dataset
- Ready for BI tools and dashboards

## 🛠️ Tech Stack
- SQL Server
- T-SQL
- Data Cleaning
- ETL Pipeline
- Medallion Architecture

## 🧹 Key Transformations

- Standardized date formats
- Filled missing property addresses
- Split address fields into structured components
- Normalized categorical values (Y/N → Yes/No)
- Removed duplicates

## 📊 Final Output

The Gold layer contains a clean, structured dataset ready for:
- Reporting
- BI dashboards (Power BI / Tableau)
- Real estate analytics
