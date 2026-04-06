# Health-Care-Dataset

**Project Overview:**

This project focuses on cleaning and preparing a messy Health Care dataset using SQL. The raw data contains information such as age, blood pressure, cholesterol levels, visit dates, etc. There are inconsistencies such as duplicate rows, missing values, and inconsistent formatting, which could lead to incorrect business insight if not handled properly.


**Business Context:**

The datasets represents patients screening data before the actual visits with doctors. Reliable and clean data is critical for accurate reporting and decision making.


**Dataset Overview:**

- Grain: 1 row = 1 patient screening record (pre-visit)
- 1000 rows and 10 columns
- date range: 2018 - 2020 (inconsistent Month entry)


**Data Issues Identified:**

During initial exploration, several data quality issues were identified:
1. Invalid date formats
2. Missing and inconsistent values in columns age, cholesterol, email, blood_pressure, and phone_number (blanks, NaN)
3. Inconsistent category naming in medication column
4. Invalid data types
   

**Cleaning Steps Performed:**
1. Handled Missing Values
    - Replaced blanks, ‘NaN’ values with NULL
2. Standardized Categories
    - Unified inconsistent labels into standard formats
3. Validated Data Types
    - Converted date columns and values into a proper date format
    - Converted age and cholesterol columns from text format (Varchar) into number format (INT)


**Key Decisions & Assumptions:**
- Blank and 'NaN' values were treated as NULL to standardize missing data handling
- Text-based numeric fields (age, cholesterol) were converted to integers after validation
- Inconsistent medication names were standardized based on most frequent valid labels
- Invalid date formats were corrected where possible; otherwise set to NULL


**Before VS After:**
- Before Cleaning
<img width="1385" height="793" alt="beforee" src="https://github.com/user-attachments/assets/cfab6bfc-8beb-4b9b-9562-d54be44f2646" />


- After Cleaning
<img width="1367" height="791" alt="after" src="https://github.com/user-attachments/assets/6a1a9053-3bf2-493f-9d9f-b2f98faa527e" />
Data Validation

- Verified no remaining invalid date formats
- Checked for consistency in categorical values
- Ensured numeric columns (age, cholesterol) contain valid ranges
- Confirmed no unexpected data loss during cleaning



**Final Output:**

The cleaned dataset is now:
- Free from inconsistent date formats, ensuring accurate time-based analysis
- Standardized across categorical fields (e.g., medication), enabling reliable grouping and reporting
- Cleaned of missing and invalid values, reducing risk of misleading insights


This dataset is now suitable for:
- Patient trend analysis over time
- Risk segmentation based on health indicators
- Supporting operational and clinical decision-making












