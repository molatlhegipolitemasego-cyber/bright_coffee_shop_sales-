--EDA bright coffee shop 
----------------------------
--1.Running the entire table
SELECT *
FROM `consultation-class`.default.bright_coffee_shop_analysis_case_study_1;

--2. Checking the date  range: They first collected data on 2023-01-01 and last collected data on 2023-06-30.Data duration is 6 months
SELECT 
      MIN(transaction_date) AS Minimum_Date,
      MAX(transaction_date) AS Maximum_Date
FROM `consultation-class`.default.bright_coffee_shop_analysis_case_study_1;

--3.Checking the different store locations:3 stores namely:Lower Manhattan, Hell's Kitchen and Astoria
SELECT DISTINCT store_location
FROM `consultation-class`.default.bright_coffee_shop_analysis_case_study_1;

--4.Checking products sold at our stores: 9 distinct product types
 SELECT DISTINCT product_category
FROM `consultation-class`.default.bright_coffee_shop_analysis_case_study_1;

--5.Checking product types sold at our stores : 29 different product types
 SELECT DISTINCT product_type
FROM `consultation-class`.default.bright_coffee_shop_analysis_case_study_1;

--6.Checking product detail sold at our stores: 80 distinct product detail
 SELECT DISTINCT product_category
FROM `consultation-class`.default.bright_coffee_shop_analysis_case_study_1;

--7. Checking FOR NULLS IN VARIOUS ROWS

SELECT *
FROM `consultation-class`.default.bright_coffee_shop_analysis_case_study_1
WHERE unit_price IS NULL
OR transaction_qty IS NULL
OR transaction_date IS NULL;

--8.Checking lowest and highest unit price: lowestprice= R 0.8, highest price=R45
SELECT MIN(unit_price) AS lowest_unit_price,
        MAX(unit_price) AS highest_unit_price
FROM `consultation-class`.default.bright_coffee_shop_analysis_case_study_1;

--9. Extracting the day and month names
SELECT
      transaction_date,
      Dayname(transaction_date) AS Day_name,
      Monthname(transaction_date) AS Month_name
FROM `consultation-class`.default.bright_coffee_shop_analysis_case_study_1;

--10.Calculating the revenue
SELECT unit_price,
      transaction_qty,
      unit_price*transaction_qty AS Revenue
FROM `consultation-class`.default.bright_coffee_shop_analysis_case_study_1;

--11. Combining functions to get a clean and enhanced data set

SELECT transaction_id,
       transaction_date,
       transaction_time,
       transaction_qty,
       store_id,
       store_location,
       product_id,
       unit_price,
       product_category,
       product_type,
       product_detail,
--Adding columns to enhance the table for better insights
--Column 1
       Dayname(transaction_date) AS Day_name, 
--Column 2
       Monthname(transaction_date) AS Month_name,
--Column 3
       Dayofmonth(transaction_date) AS Date_of_month,

--Column 4-Determining weekday/weekend
  CASE WHEN Dayname(transaction_date) in ('Sun', 'Sat') THEN 'Weekend'
  ELSE 'Weekday'
  End AS Day_classiffication, 
 --Column 5- Time buckets
  CASE 
      WHEN date_format(transaction_time,'HH:mm:ss') BETWEEN '05:00:00' AND '08:59:59' THEN '01.Rush Hour'
      WHEN date_format(transaction_time,'HH:mm:ss') BETWEEN '09:00:00' AND '11:59:59' THEN '02.Mid Morning'
      WHEN date_format(transaction_time,'HH:mm:ss') BETWEEN '12:00:00' AND '15:59:59' THEN '03.Afternoon'
      WHEN date_format(transaction_time,'HH:mm:ss') BETWEEN '16:00:00' AND '18:00:00' THEN '04.Rush Hour'
      ELSE '05.Night'
END AS Time_classification,

--Column 6-Spend buckets
CASE
      WHEN (transaction_qty*unit_price) <=50 THEN '01.Low Spender'
      WHEN (transaction_qty*unit_price) BETWEEN 51 AND 200 THEN '02.Medium Spender'     
      WHEN (transaction_qty*unit_price) BETWEEN 201 AND 300 THEN '03. Moreki'
      ELSE '04.Blesser'
END AS Spend_bucket,

--Column 8- Revenue
transaction_qty*unit_price AS Revenue
FROM `consultation-class`.default.bright_coffee_shop_analysis;

      

-----------------------------------------------------------
--12.AGGREGATIONS
SELECT COUNT(*) AS number_of_rows, 
       COUNT(DISTINCT transaction_id) AS number_of_sales,
       COUNT(DISTINCT store_id) AS number_of_stores
FROM `consultation-class`.default.bright_coffee_shop_analysis_case_study_1;  
-------------------------------------------------------------
SELECT transaction_id,
       transaction_date,
       Dayname(transaction_date)  AS Day_name,
       Monthname(transaction_date) AS Month_name,
       transaction_qty*unit_price AS revenue_per_tnx
FROM `consultation-class`.default.bright_coffee_shop_analysis_case_study_1;     
SELECT transaction_id,
       transaction_date,
       Dayname(transaction_date)  AS Day_name,
       Monthname(transaction_date) AS Month_name,
       transaction_qty*unit_price AS revenue_per_tnx
FROM `consultation-class`.default.bright_coffee_shop_analysis_case_study_1;     
----------------------------------------------------------------------  
