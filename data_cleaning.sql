-- 1. Standardize values into a more uniform format
-- create a function for formatting the new_name values into Proper format
DELIMITER $$
CREATE FUNCTION PROPER(inputStr VARCHAR(255)) 
RETURNS VARCHAR(255) DETERMINISTIC NO SQL READS SQL DATA
BEGIN
    DECLARE result VARCHAR(255) DEFAULT '';
    DECLARE word VARCHAR(255);
    SET inputStr = LOWER(TRIM(inputStr));
    WHILE LENGTH(inputStr) > 0 DO
        SET word = SUBSTRING_INDEX(inputStr, ' ', 1);
        SET result = CONCAT(result, ' ', CONCAT(UPPER(LEFT(word, 1)), SUBSTRING(word, 2)));
        SET inputStr = SUBSTRING(inputStr, LENGTH(word) + 2);
    END WHILE;
    RETURN TRIM(result);
END$$
DELIMITER ;

update healthcare_staging
set patient_name = PROPER(patient_name),
medication = PROPER(medication)


-- 2. Standardize missing and inconsistent values, to ensure consistent handling of missing data
update healthcare_staging
set age = case
	when age like '%nan' then null
	when age like '%forty' then 40
	else age
end

update healthcare_staging 
set Cholesterol = case 
	when cholesterol like '%NaN' then null
	else cholesterol
end

update healthcare_staging 
set phone_number = case 
	when Phone_Number like '%nan' then null
	when Phone_Number = ' ' then null
	else Phone_Number
end


-- 3. Fix invalid date formats, to enable accurate time-based analysis
update healthcare_staging
set visit_date = CASE 
		-- 1. Format: '03-25-2019' (MM-DD-YYYY)
        WHEN visit_date LIKE '__-__-____' 
            THEN STR_TO_DATE(visit_date, '%m-%d-%Y')
        -- 2. Format: '2020/02/20' (YYYY/MM/DD)
        WHEN visit_date LIKE '____/%/%' 
            THEN STR_TO_DATE(visit_date, '%Y/%m/%d')
        -- 3. Format: '01/15/2020' (MM/DD/YYYY)
        WHEN visit_date LIKE '__/%/%' 
            THEN STR_TO_DATE(visit_date, '%m/%d/%Y')           
        -- 4. Format: 'April 5, 2018' (Month Name Day, Year)
        WHEN visit_date LIKE '%, %' 
            THEN STR_TO_DATE(visit_date, '%M %e, %Y')            
        -- 5. Format: '2019.12.01' (YYYY.MM.DD)
        WHEN visit_date LIKE '%.%.%' 
            THEN STR_TO_DATE(visit_date, '%Y.%m.%d')
        ELSE NULL
    END


-- 4. Convert data types, to allow numerical calculations and validation
alter table healthcare_staging
modify column age int

alter table healthcare_staging
modify column visit_date date NULL

alter table healthcare_staging
modify column cholesterol int null


-- 5. Validation, to ensure data quality after cleaning
select count(*) from healthcare_staging where visit_date is null;
select count(*) from healthcare_staging where age is null;








