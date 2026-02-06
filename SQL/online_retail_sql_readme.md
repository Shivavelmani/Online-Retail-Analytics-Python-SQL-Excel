# Online Retail SQL Analysis

## Dataset Source
**Original Dataset:** [Kaggle - Online Retail Dataset](https://www.kaggle.com/datasets/lakshmi25npathi/online-retail-dataset?resource=download)

**Cleaned Dataset (delivered_products.csv):** [Download from Google Drive](https://drive.google.com/file/d/1FL93p_2SBeEkZDc6K412mb-_kmi2Kbr0/view?usp=drive_link)

## Overview
SQL analysis of an online_retail dataset with 1M+ transactions.

## Data Preparation Workflow

### Excel Data Cleaning & Transformation
The raw Kaggle dataset was cleaned and prepared for SQL analysis:
- Removed cancelled transactions (InvoiceNo starting with 'C')
- Filtered out 12 types of non-product entries (postage, fees, discounts, adjustments, samples, vouchers)
- Removed records with missing CustomerID values
- Standardized date formats for MySQL compatibility
- **Created calculated field:** `TotalRevenue = Quantity × UnitPrice`

**Results:**
- Original: 1,067,371 rows × 8 columns
- Cleaned: 1,025,251 rows × 9 columns  
- Removed: 42,120 invalid records (~3.9%)

**Output:** `delivered_products.csv` - contains only actual product sales transactions

## Setup Instructions

### Prerequisites
- MySQL 8.0 or higher
- MySQL Workbench
- `delivered_products.csv` file (download from link above)

### Step 1: Prepare the CSV File
**IMPORTANT:** Before running any SQL files, copy **delivered_products.csv** CSV file to MySQL's uploads directory:

**Windows:**
```
C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/delivered_products.csv
```

**Note:** You may need administrator privileges to access this folder.

### Step 2: Run Database Setup
1. Open MySQL Workbench
2. Connect to your MySQL server
3. Open `online_retail_database_setup.sql`
4. Execute the entire file 
5. Verify success - should show ~1M rows loaded

### Step 3: Run Analysis Queries
1. Open `online_retail_sql_analysis.sql`
2. Execute queries individually
3. Review results for business insights


## Analyses Included
**Query 1:** Data Overview - Total transactions, customers, products, revenue  
**Query 2:** Top 10 Products - Best-performing products by revenue  
**Query 3:** Geographic Analysis - Revenue distribution by country  
**Query 4:** Customer Segmentation - Purchase frequency tiers (One-time, Occasional, Regular, VIP)  
**Query 5:** Monthly Trends - Sales patterns over time  
**Query 6:** Top Customers - Highest lifetime value customers  

