-- ---------------------------------------------
-- Property Market Analysis Using SQL
-- ---------------------------------------------

-- Problem Statement:
-- Analyze real estate transaction data to uncover insights about property sales trends, pricing patterns,
-- and geographical influences. The goal is to empower stakeholders to make informed investment decisions.

-- 1. Top 3 Most Expensive Properties in Each Geography
-- This query ranks properties by price within each geography and retrieves the top 3 most expensive properties.
WITH RankedProperties AS (
    SELECT 
        Geography, 
        Price, 
        Property_Type,
        ROW_NUMBER() OVER (PARTITION BY Geography ORDER BY Price DESC) AS Rank
    FROM data
)
SELECT Geography, Price, Property_Type
FROM RankedProperties
WHERE Rank <= 3
ORDER BY Geography, Rank;

-- 2. Percentage of Property Sales by Property Type and Geography
-- This calculates the percentage share of each property type's sales within each geography.
WITH SalesPercentage AS (
    SELECT 
        Geography,
        Property_Type,
        COUNT(*) AS Property_Count,
        SUM(COUNT(*)) OVER (PARTITION BY Geography) AS Total_Sales
    FROM data
    GROUP BY Geography, Property_Type
)
SELECT 
    Geography,
    Property_Type,
    Property_Count,
    ROUND((Property_Count * 100.0) / Total_Sales, 2) AS Sales_Percentage
FROM SalesPercentage
ORDER BY Geography, Sales_Percentage DESC;

-- 3. Average Property Price by Property Type Over Time (Quarterly)
-- This query calculates the average price of each property type for each quarter.
WITH QuarterlyPrices AS (
    SELECT 
        Property_Type,
        DATEPART(QUARTER, Date_of_Transfer) AS Quarter,
        YEAR(Date_of_Transfer) AS Year,
        AVG(Price) AS Avg_Price
    FROM data
    GROUP BY Property_Type, DATEPART(QUARTER, [Date_of_Transfer]), YEAR(Date_of_Transfer)
)
SELECT 
    Property_Type,
    Year,
    Quarter,
    Avg_Price
FROM QuarterlyPrices
ORDER BY Property_Type, Year, Quarter;

-- 4. Properties That Increased in Price Over Time
-- This compares the price of properties in 2001 and 2010 to identify price increases.
SELECT 
    a.Property_Type,
    a.Price AS Price_Year_1,
    b.Price AS Price_Year_2,
    (b.Price - a.Price) AS Price_Increase
FROM data a
JOIN data b
    ON a.Property_Type = b.Property_Type
    AND YEAR(a.[Date_of_Transfer]) = 2001
    AND YEAR(b.[Date_of_Transfer]) = 2010
WHERE b.Price > a.Price
ORDER BY Price_Increase DESC;

-- 5. Properties with the Longest Time on Market
-- Finds properties that have been on the market the longest based on transfer date.
SELECT TOP 10 
    Property_Type,
    Date_of_Transfer,
    DATEDIFF(DAY, Date_of_Transfer, GETDATE()) AS Days_On_Market
FROM data
ORDER BY Days_On_Market DESC;

-- 6. Top 3 Most Expensive Properties by Area
-- Retrieves the top 3 most expensive properties based on their area.
SELECT 
    Property_Type,
    Price,
    Area_sq_km
FROM data
WHERE Area_sq_km IN (
    SELECT TOP 3 Area_sq_km
    FROM data
    ORDER BY Price DESC
)
ORDER BY Price DESC;

-- 7. Average Price by Property Type, Split by New and Old
-- Calculates the average price of properties, grouped by type and new/old status.
SELECT 
    Property_Type,
    Old_New,
    AVG(CAST(Price AS FLOAT)) AS Avg_Price
FROM data
GROUP BY Property_Type, Old_New
ORDER BY Property_Type, Old_New;

-- 8. Correlation Between Geography and Property Price by Area
-- Measures how property prices correlate with area size within each geography.
SELECT 
    Geography,
    (COUNT(*) * SUM(Price * Area_sq_km) - SUM(Price) * SUM(Area_sq_km)) / 
    (SQRT(COUNT(*) * SUM(Price * Price) - SUM(Price) * SUM(Price)) * 
     SQRT(COUNT(*) * SUM(Area_sq_km * Area_sq_km) - SUM(Area_sq_km) * SUM(Area_sq_km))) 
     AS Price_Area_Correlation
FROM data
GROUP BY Geography;
