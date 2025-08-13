# 📊 Blinkit Sales Analysis – SQL Project

## 📌 Project Objective
The goal of this project is to **analyze Blinkit's sales performance, customer satisfaction, and inventory distribution** using SQL queries.  
By cleaning the data and applying various aggregations, this project uncovers key insights and optimization opportunities for better business decisions.

---

## 🛠️ Tech Stack
- **Database:** MYSQL
- **Language:** SQL
- **Dataset:** Blinkit sales dataset

---

## 📂 Project Workflow

### 1️⃣ Data Cleaning
- **Field Cleaned:** `Item_Fat_Content`
- Standardized inconsistent values (`LF`, `low fat` → `Low Fat`, `reg` → `Regular`)
- Verified cleaning with `SELECT DISTINCT` query

### 2️⃣ KPI Calculations
- **Total Sales (in Millions)**
- **Average Sales**
- **Number of Orders**
- **Average Rating**

### 3️⃣ Sales Analysis Queries
- **Total Sales by Fat Content**
- **Total Sales by Item Type**
- **Fat Content by Outlet (Pivot Table)**
- **Total Sales by Outlet Establishment Year**
- **Percentage of Sales by Outlet Size**
- **Sales by Outlet Location**
- **All Metrics by Outlet Type** (Total Sales, Avg Sales, Item Count, Avg Rating, Item Visibility)

---

## 📈 Business Requirements

### KPI Requirements
1. **Total Sales** – Overall revenue from all items sold
2. **Average Sales** – Mean revenue per sale
3. **Number of Items** – Total count of items sold
4. **Average Rating** – Mean customer rating for products

### Granular Insights
- **Fat Content Impact on Sales**
- **Performance by Item Type**
- **Outlet Sales Segmented by Fat Content**
- **Impact of Outlet Establishment Year**
- **Sales Distribution by Outlet Size & Location**
- **Comprehensive Metrics by Outlet Type**

---

## 🗂️ Example Queries

-- 1. Data Cleaning for Item_Fat_Content
UPDATE blinkit_data
SET Item_Fat_Content = 
    CASE 
        WHEN Item_Fat_Content IN ('LF', 'low fat') THEN 'Low Fat'
        WHEN Item_Fat_Content = 'reg' THEN 'Regular'
        ELSE Item_Fat_Content
    END;

-- 2. Total Sales in Millions
SELECT CAST(SUM(Total_Sales) / 1000000.0 AS DECIMAL(10,2)) AS Total_Sales_Million
FROM blinkit_data;

-- 3. Percentage of Sales by Outlet Size
SELECT 
    Outlet_Size, 
    CAST(SUM(Total_Sales) AS DECIMAL(10,2)) AS Total_Sales,
    CAST((SUM(Total_Sales) * 100.0 / SUM(SUM(Total_Sales)) OVER()) AS DECIMAL(10,2)) AS Sales_Percentage
FROM blinkit_data
GROUP BY Outlet_Size
ORDER BY Total_Sales DESC;

-- Exit SQL session
EXIT;


## 📌 Key Insights
- **Low Fat** and **Regular** items have distinct sales trends across different outlets.
- **Larger outlets** generally contribute more to total sales.
- Certain **item types dominate revenue share**.
- **Outlet location** and **establishment year** significantly impact sales performance.

---

## 📜 How to Use
1. Clone this repository:
   ```bash
   git clone https://github.com/your-username/blinkit-sql-analysis.git

## 📜 How to Use
1. Import the dataset into your SQL environment.
2. Run the provided queries in `blinkit_analysis.sql`.
3. *(Optional)* Connect the SQL output to **Power BI** for visual dashboards.

---

## 🏷️ Author
**Sahil Shende**  
💼 Data Analyst | SQL | Power BI | Tableau | Excel  
📧 sahilshende18@gmail.com
🌐 [LinkedIn Profile](linkedin.com/in/sahilshendeofficial)


