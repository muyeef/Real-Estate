# Real-Estate

# 🏡 Property Market Analysis Using SQL

## 📘 Introduction

The real estate industry generates vast volumes of data daily from sales prices and property types to geographical trends and market performance over time. Understanding this data through analysis is critical for real estate investors, property developers, and policymakers to make data-driven decisions.  

This project utilizes SQL to analyze a property transaction dataset and uncover actionable insights, such as price patterns, regional performance, and sales behavior across different time periods.

---

## 🎯 Problem Statement

The primary objective of this project is to analyze real estate transaction data to answer the following business questions:

- Which are the top 3 most expensive properties in each geography?
- What percentage of property sales does each type contribute within different regions?
- How does the average price of properties vary by type over different time periods?
- Are property prices appreciating over time?
- Which properties have remained longest on the market?
- Is there a correlation between geography and property value based on area?

---

## 📂 Project Details

Below are the major analyses conducted in the project using SQL queries:

### 1. **Top 3 Most Expensive Properties by Geography**
Ranks properties based on price within each geography using `ROW_NUMBER()` and retrieves the top 3.

### 2. **Sales Percentage by Property Type and Geography**
Calculates the share of each property type's sales within each geographical zone.

### 3. **Average Property Price per Quarter by Type**
Calculates quarterly averages of property prices grouped by `Property_Type` using `DATEPART()` and `AVG()`.

### 4. **Identifying Properties That Increased in Price**
Performs a self-join on the dataset to find properties that had a higher price in 2010 compared to 2001.

### 5. **Longest Time on Market**
Uses `DATEDIFF()` and `GETDATE()` to find the top 10 properties that have stayed longest on the market.

### 6. **Top 3 Most Expensive Properties by Area**
Finds the three properties with the highest area sizes and their corresponding prices.

### 7. **Average Price by Property Type (New vs Old)**
Calculates the average price for new and old properties grouped by `Property_Type`.

### 8. **Correlation Between Price and Area per Geography**
Applies the Pearson correlation formula to understand how geography influences property pricing based on area.

---

## ✅ Recommendations

Based on the analysis above:

- **Invest in geographies** where property prices consistently increase over time.
- **Monitor quarterly trends** to identify seasonal dips or price surges by property type.
- Use **correlation analysis** to uncover undervalued or overvalued regions based on area-price relationships.
- **Target property types** with growing market share in specific regions for focused marketing.

---

## 📌 Conclusion

This project demonstrates the power of SQL in real estate data analysis. By using advanced SQL techniques such as window functions, self-joins, and statistical formulas, we gain critical insights into market trends, property performance, and geography-driven value fluctuations. These insights are invaluable for strategic decision-making in property investments and urban development planning.

---

## 🛠️ Tools Used

- SQL Server 

---




