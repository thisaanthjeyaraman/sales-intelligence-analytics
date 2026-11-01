
-- =====================================================
-- SALES INTELLIGENCE & REVENUE GROWTH ANALYTICS
-- Database: sales_ecommerce.db
-- Table: ecommerce_sales
-- Dataset: Synthetic E-commerce Sales (2023-2025)
-- =====================================================

-- IMPORTANT:
-- Net_Sales and Profit are recorded dataset values.
-- They include cancelled, returned, and shipped orders
-- unless a query explicitly filters Order_Status.
-- Do not interpret unfiltered totals as realized revenue.


-- 1. VIEW FIRST 10 RECORDS
SELECT *
FROM ecommerce_sales
LIMIT 10;


-- 2. DATASET OVERVIEW
SELECT
    COUNT(*) AS total_records,
    COUNT(DISTINCT Order_ID) AS unique_orders,
    COUNT(DISTINCT Customer_ID) AS unique_customers,
    COUNT(DISTINCT Product_ID) AS unique_products,
    MIN(Order_Date) AS first_order_date,
    MAX(Order_Date) AS last_order_date
FROM ecommerce_sales;


-- 3. OVERALL RECORDED SALES PERFORMANCE
-- Includes all order statuses.
SELECT
    ROUND(SUM(Gross_Sales), 2) AS gross_sales,
    ROUND(SUM(Discount_Amount), 2) AS total_discount,
    ROUND(SUM(Net_Sales), 2) AS recorded_net_sales,
    ROUND(SUM(Cost), 2) AS total_cost,
    ROUND(SUM(Profit), 2) AS recorded_profit,
    SUM(Quantity) AS total_quantity,
    ROUND(
        100.0 * SUM(Profit) / NULLIF(SUM(Net_Sales), 0),
        2
    ) AS recorded_profit_margin_pct
FROM ecommerce_sales;


-- 4. ORDER STATUS ANALYSIS
SELECT
    Order_Status,
    COUNT(*) AS order_count,
    ROUND(SUM(Net_Sales), 2) AS recorded_net_sales,
    ROUND(SUM(Profit), 2) AS recorded_profit,
    ROUND(
        100.0 * COUNT(*) /
        (SELECT COUNT(*) FROM ecommerce_sales),
        2
    ) AS percentage_of_orders
FROM ecommerce_sales
GROUP BY Order_Status
ORDER BY order_count DESC;


-- 5. DELIVERED ORDER PERFORMANCE
-- Provisional completed-sales proxy.
SELECT
    COUNT(*) AS delivered_orders,
    ROUND(SUM(Net_Sales), 2) AS delivered_net_sales,
    ROUND(SUM(Profit), 2) AS delivered_recorded_profit,
    ROUND(
        100.0 * SUM(Profit) / NULLIF(SUM(Net_Sales), 0),
        2
    ) AS delivered_profit_margin_pct
FROM ecommerce_sales
WHERE Order_Status = 'Delivered';


-- 6. RECORDED PROFIT BY CATEGORY
SELECT
    Category,
    COUNT(*) AS order_count,
    ROUND(SUM(Net_Sales), 2) AS recorded_net_sales,
    ROUND(SUM(Profit), 2) AS recorded_profit
FROM ecommerce_sales
GROUP BY Category
ORDER BY recorded_profit DESC;


-- 7. RECORDED PROFIT BY REGION
SELECT
    Region,
    COUNT(*) AS order_count,
    ROUND(SUM(Net_Sales), 2) AS recorded_net_sales,
    ROUND(SUM(Profit), 2) AS recorded_profit
FROM ecommerce_sales
GROUP BY Region
ORDER BY recorded_profit DESC;


-- 8. ANNUAL RECORDED NET SALES
SELECT
    strftime('%Y', Order_Date) AS sales_year,
    COUNT(*) AS order_count,
    ROUND(SUM(Net_Sales), 2) AS recorded_net_sales,
    ROUND(SUM(Profit), 2) AS recorded_profit
FROM ecommerce_sales
GROUP BY strftime('%Y', Order_Date)
ORDER BY sales_year;


-- 9. MONTHLY RECORDED NET SALES
-- Matches the all-status scope of Python script 02.
SELECT
    strftime('%Y-%m', Order_Date) AS sales_month,
    COUNT(*) AS order_count,
    ROUND(SUM(Net_Sales), 2) AS recorded_net_sales,
    ROUND(SUM(Profit), 2) AS recorded_profit
FROM ecommerce_sales
GROUP BY strftime('%Y-%m', Order_Date)
ORDER BY sales_month;


-- 10. DISCOUNT AND PROFITABILITY ANALYSIS
SELECT
    Discount_Percentage,
    COUNT(DISTINCT Order_ID) AS order_count,
    ROUND(SUM(Gross_Sales), 2) AS gross_sales,
    ROUND(SUM(Net_Sales), 2) AS recorded_net_sales,
    ROUND(SUM(Profit), 2) AS recorded_profit,
    ROUND(AVG(Profit), 2) AS average_profit_per_record,
    ROUND(
        100.0 * SUM(Profit) / NULLIF(SUM(Net_Sales), 0),
        2
    ) AS recorded_profit_margin_pct
FROM ecommerce_sales
GROUP BY Discount_Percentage
ORDER BY Discount_Percentage;


-- 11. TOP 10 PRODUCTS BY RECORDED NET SALES
SELECT
    Product_ID,
    COUNT(DISTINCT Order_ID) AS order_count,
    SUM(Quantity) AS total_quantity,
    ROUND(SUM(Net_Sales), 2) AS recorded_net_sales,
    ROUND(SUM(Profit), 2) AS recorded_profit
FROM ecommerce_sales
GROUP BY Product_ID
ORDER BY recorded_net_sales DESC
LIMIT 10;


-- 12. BOTTOM 10 PRODUCTS BY RECORDED NET SALES
SELECT
    Product_ID,
    COUNT(DISTINCT Order_ID) AS order_count,
    SUM(Quantity) AS total_quantity,
    ROUND(SUM(Net_Sales), 2) AS recorded_net_sales,
    ROUND(SUM(Profit), 2) AS recorded_profit
FROM ecommerce_sales
GROUP BY Product_ID
ORDER BY recorded_net_sales ASC
LIMIT 10;


-- 13. TOP 10 CUSTOMERS BY DELIVERED NET SALES
-- Matches the completed-order assumption used in RFM.
SELECT
    Customer_ID,
    COUNT(DISTINCT Order_ID) AS delivered_orders,
    ROUND(SUM(Net_Sales), 2) AS delivered_net_sales,
    ROUND(SUM(Profit), 2) AS delivered_recorded_profit
FROM ecommerce_sales
WHERE Order_Status = 'Delivered'
GROUP BY Customer_ID
ORDER BY delivered_net_sales DESC
LIMIT 10;


-- 14. SALES CHANNEL PERFORMANCE
SELECT
    Sales_Channel,
    COUNT(*) AS order_count,
    ROUND(SUM(Net_Sales), 2) AS recorded_net_sales,
    ROUND(SUM(Profit), 2) AS recorded_profit
FROM ecommerce_sales
GROUP BY Sales_Channel
ORDER BY recorded_net_sales DESC;


-- 15. PAYMENT METHOD ANALYSIS
SELECT
    Payment_Method,
    COUNT(*) AS order_count,
    ROUND(SUM(Net_Sales), 2) AS recorded_net_sales
FROM ecommerce_sales
GROUP BY Payment_Method
ORDER BY order_count DESC;


-- 16. RETURN AND CANCELLATION ANALYSIS
SELECT
    Order_Status,
    COUNT(*) AS order_count,
    ROUND(SUM(Net_Sales), 2) AS recorded_net_sales,
    ROUND(SUM(Profit), 2) AS recorded_profit
FROM ecommerce_sales
WHERE Order_Status IN ('Returned', 'Cancelled')
GROUP BY Order_Status
ORDER BY order_count DESC;


-- 17. CUSTOMER RATINGS BY REGION
SELECT
    Region,
    COUNT(*) AS order_count,
    ROUND(AVG(Customer_Rating), 2) AS average_rating,
    ROUND(AVG(Delivery_Days), 2) AS average_delivery_days
FROM ecommerce_sales
GROUP BY Region
ORDER BY average_rating DESC;


-- 18. MONTHLY DELIVERED NET SALES
-- Matches the sales series used by Python forecasting.
SELECT
    strftime('%Y-%m', Order_Date) AS sales_month,
    ROUND(SUM(Net_Sales), 2) AS delivered_net_sales,
    COUNT(*) AS delivered_orders
FROM ecommerce_sales
WHERE Order_Status = 'Delivered'
GROUP BY strftime('%Y-%m', Order_Date)
ORDER BY sales_month;
