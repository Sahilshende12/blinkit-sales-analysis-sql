-- Create a new database named Blinkit
CREATE DATABASE Blinkit;

-- Switch to the Blinkit database so all further operations are on it
USE Blinkit;

-- Retrieve all records from the Blinkit_data table
SELECT * FROM Blinkit_data;

-- Disable SQL safe updates to allow unrestricted UPDATE statements
SET SQL_SAFE_UPDATES = 0;

-- Count the total number of records in Blinkit_data
SELECT COUNT(*) FROM Blinkit_data;

-- Standardize values in the Item_Fat_Content column:
-- Replace 'LF' and 'low fat' with 'Low Fat'
-- Replace 'reg' with 'Regular'
UPDATE Blinkit_data 
SET Item_Fat_Content = 
CASE 
	WHEN Item_Fat_Content IN ('LF' , 'low fat') THEN 'Low Fat'
	WHEN Item_Fat_Content = ('reg') THEN 'Regular'
	ELSE Item_Fat_Content
END;

-- View all unique values in Item_Fat_Content after standardization
SELECT DISTINCT(Item_Fat_Content) FROM Blinkit_data;

-- Calculate total sales for all records
SELECT SUM(Total_Sales) FROM Blinkit_data;

-- Calculate total sales in millions, rounded to 4 decimal places
SELECT ROUND(SUM(CAST(Total_Sales AS FLOAT)) / 1000000, 4) AS Total_Sales_in_Millions
FROM Blinkit_data;

-- Calculate the average sales value, formatted to 1 decimal place
SELECT CAST(AVG(Total_Sales) AS DECIMAL (5,1)) AS AVG_Sales
FROM Blinkit_data;

-- Rename column 'Item_ype' to 'Item_Type' with a VARCHAR(50) data type
ALTER TABLE Blinkit_data 
CHANGE COLUMN Item_ype Item_Type VARCHAR(50);

-- View all records after renaming the column
SELECT * FROM Blinkit_data;

-- Retrieve all records sorted by Item_Type alphabetically
SELECT * FROM Blinkit_data ORDER BY Item_Type;

-- Calculate total sales in millions for items with 'Low Fat' content
SELECT ROUND(SUM(CAST(Total_Sales AS FLOAT)) /1000000 , 4) AS Total_Sales_LowFat 
FROM Blinkit_data 
WHERE Item_Fat_Content = 'Low Fat';

-- Calculate average sales for outlets established in 2022 (formatted to 2 decimal places)
SELECT CAST(AVG(Total_Sales) AS DECIMAL(5,2)) AS AVG_Sales_2022 
FROM Blinkit_data 
WHERE Outlet_Establishment_Year = 2022;

-- Count the number of outlets established in 2022
SELECT COUNT(*) 
FROM Blinkit_data 
WHERE Outlet_Establishment_Year = 2022;

-- Calculate the overall average rating for all products
SELECT CAST(AVG(Rating) AS DECIMAL(10,2)) AS AVG_Rating 
FROM Blinkit_data;

-- View all records from Blinkit_data again
SELECT * FROM Blinkit_data;

-- Group sales data by Item_Fat_Content:
-- Show total sales for each category (sorted in descending order)
SELECT Item_Fat_Content,
       CAST(SUM(Total_sales) AS DECIMAL (10,2)) AS Total_Sale 
FROM Blinkit_data 
GROUP BY Item_Fat_Content
ORDER BY Total_Sale DESC;

-- Group sales data by Item_Fat_Content:
-- Show total sales in thousands, average sales, average rating, and item count
SELECT Item_Fat_Content,
       CONCAT(CAST(SUM(Total_sales)/1000 AS DECIMAL (10,2))," K") AS Total_Sale,
       CAST(AVG(Total_Sales) AS DECIMAL(5,2)) AS Average_sale,
       CAST(AVG(Rating) AS DECIMAL(10,2)) AS AVG_Rating,
       COUNT(*) AS Number_of_item
FROM Blinkit_data 
GROUP BY Item_Fat_Content
ORDER BY Total_Sale DESC;

-- Same as above but filtered for outlets established in 2022
SELECT Item_Fat_Content,
       CONCAT(CAST(SUM(Total_sales)/1000 AS DECIMAL (10,2))," K") AS Total_Sale_Thousand,
       CAST(AVG(Total_Sales) AS DECIMAL(5,2)) AS Average_sale,
       CAST(AVG(Rating) AS DECIMAL(10,2)) AS AVG_Rating,
       COUNT(*) AS Number_of_item
FROM Blinkit_data 
WHERE Outlet_Establishment_Year = 2022
GROUP BY Item_Fat_Content
ORDER BY Total_Sale_Thousand DESC;

-- Group sales data by Item_Type:
-- Show total sales, average sales, average rating, and item count
SELECT Item_Type,
       CAST(SUM(Total_Sales) AS DECIMAL (10,2)) AS Total_Sales,
       CAST(AVG(Total_Sales) AS DECIMAL (10,2)) AS Average_Sales,
       CAST(AVG(Rating) AS DECIMAL (10,2)) AS Average_rating,
       COUNT(*) AS Number_of_item
FROM Blinkit_data
GROUP BY Item_Type
ORDER BY Total_Sales DESC;

-- Same as above but show only top 5 item types by total sales
SELECT Item_Type,
       CAST(SUM(Total_Sales) AS DECIMAL (10,2)) AS Total_Sales,
       CAST(AVG(Total_Sales) AS DECIMAL (10,2)) AS Average_Sales,
       CAST(AVG(Rating) AS DECIMAL (10,2)) AS Average_rating,
       COUNT(*) AS Number_of_item
FROM Blinkit_data
GROUP BY Item_Type
ORDER BY Total_Sales DESC
LIMIT 5;

-- Same as above but show bottom 5 item types by total sales
SELECT Item_Type,
       CAST(SUM(Total_Sales) AS DECIMAL (10,2)) AS Total_Sales,
       CAST(AVG(Total_Sales) AS DECIMAL (10,2)) AS Average_Sales,
       CAST(AVG(Rating) AS DECIMAL (10,2)) AS Average_rating,
       COUNT(*) AS Number_of_item
FROM Blinkit_data
GROUP BY Item_Type
ORDER BY Total_Sales ASC
LIMIT 5;

-- Group sales by Outlet_Location_Type and Item_Fat_Content:
-- Show total and average sales for each combination
SELECT Outlet_Location_Type, Item_Fat_Content,
       CAST(SUM(Total_Sales) AS DECIMAL (10,2)) AS Total_Sales,
       CAST(AVG(Total_Sales) AS DECIMAL (10,2)) AS Average_Sales
FROM Blinkit_data
GROUP BY Outlet_Location_Type, Item_Fat_Content
ORDER BY Outlet_Location_Type ASC; 

-- Group sales data by Outlet_Establishment_Year:
-- Show total sales, average sales, average rating, and item count
SELECT Outlet_Establishment_Year,
       CAST(SUM(Total_Sales) AS DECIMAL (10,2)) AS Total_Sales,
       CAST(AVG(Total_Sales) AS DECIMAL (10,2)) AS Average_Sales,
       CAST(AVG(Rating) AS DECIMAL (10,2)) AS Average_Rating,
       COUNT(*) AS Number_of_items
FROM Blinkit_data
GROUP BY Outlet_Establishment_Year
ORDER BY Total_Sales DESC;

-- Compare total sales between Low Fat and Regular items for each Outlet_Location_Type
SELECT 
    Outlet_Location_Type,
    CAST(SUM(CASE WHEN Item_Fat_Content = 'Low Fat' THEN Total_Sales ELSE 0 END) AS DECIMAL(10,2)) AS Low_Fat,
    CAST(SUM(CASE WHEN Item_Fat_Content = 'Regular' THEN Total_Sales ELSE 0 END) AS DECIMAL(10,2)) AS Regular
FROM Blinkit_data
GROUP BY Outlet_Location_Type
ORDER BY Outlet_Location_Type;

-- View all data from Blinkit_data again
SELECT * FROM Blinkit_data;

-- Group sales by Outlet_Location_Type:
-- Show total sales, percentage contribution to overall sales, and average sales
SELECT Outlet_Location_Type,
       CAST(SUM(Total_Sales) AS DECIMAL (10,2)) AS Total_Sales,
       CAST(SUM(Total_Sales) * 100 / SUM(SUM(Total_Sales)) OVER() AS DECIMAL (10,2)) AS Sales_Percentage,
       CAST(AVG(Total_Sales) AS DECIMAL (10,2)) AS Average_Sales
FROM Blinkit_data
GROUP BY Outlet_Location_Type 
ORDER BY Sales_Percentage DESC; 

-- Group sales by Outlet_Type:
-- Show total sales, percentage contribution to overall sales, and average sales
SELECT Outlet_Type,
       CAST(SUM(Total_Sales) AS DECIMAL (10,2)) AS Total_Sales,
       CAST(SUM(Total_Sales) * 100 / SUM(SUM(Total_Sales)) OVER() AS DECIMAL (10,2)) AS Sales_Percentage,
       CAST(AVG(Total_Sales) AS DECIMAL (10,2)) AS Average_Sales
FROM Blinkit_data
GROUP BY Outlet_Type 
ORDER BY Sales_Percentage DESC; 
