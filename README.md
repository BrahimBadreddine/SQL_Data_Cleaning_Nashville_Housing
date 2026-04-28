# 🏠 Nashville Housing ETL Pipeline (SQL Server)
## 📌 Project Overview
This project builds an end-to-end ETL pipeline for the Nashville Housing dataset using SQL Server.
It follows a Medallion Architecture (Bronze → Silver → Gold) to clean, transform, and structure raw housing data for analytics and reporting.
The goal is to demonstrate data cleaning, transformation using SQL.
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
