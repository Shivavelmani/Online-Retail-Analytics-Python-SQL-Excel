-- ONLINE RETAIL DATA ANALYSIS
-- Dataset: delivered_products
-- Assumes database 'retail_online' is already set up

USE retail_online;

-- 1. DATA OVERVIEW: Get summary of dataset
SELECT 
    COUNT(*) as total_transactions,
    COUNT(DISTINCT customer_id) as unique_customers,
    COUNT(DISTINCT stockcode) as unique_products,
    SUM(total_revenue) as total_revenue,
    MIN(invoice_date) as first_transaction,
    MAX(invoice_date) as last_transaction
FROM delivered_products;

-- 2. TOP 10 REVENUE-GENERATING PRODUCTS
SELECT 
    stockcode,
    product_description,
    SUM(quantity) as total_quantity_sold,
    SUM(total_revenue) as total_revenue,
    ROUND(AVG(unit_price), 2) as avg_price
FROM delivered_products
WHERE customer_id IS NOT NULL
GROUP BY stockcode, product_description
ORDER BY total_revenue DESC
LIMIT 10;

-- 3. TOP COUNTRIES BY REVENUE
SELECT 
    country,
    COUNT(DISTINCT customer_id) as customer_count,
    COUNT(*) as transaction_count,
    SUM(total_revenue) as total_revenue,
    ROUND(AVG(total_revenue), 2) as avg_transaction_value
FROM delivered_products
WHERE customer_id IS NOT NULL
GROUP BY country
ORDER BY total_revenue DESC
LIMIT 10;

-- 4. CUSTOMER SEGMENTATION BY PURCHASE FREQUENCY
-- Classify customers by number of purchases
SELECT 
    purchase_tier,
    COUNT(*) as customer_count,
    ROUND(SUM(total_revenue)) as revenue_contribution,
    ROUND(AVG(total_revenue)) as avg_revenue_per_customer
FROM (
    SELECT 
        customer_id,
        COUNT(DISTINCT invoice) as purchase_count,
        SUM(total_revenue) as total_revenue,
        CASE 
            WHEN COUNT(DISTINCT invoice) = 1 THEN 'One-time'
            WHEN COUNT(DISTINCT invoice) BETWEEN 2 AND 5 THEN 'Occasional'
            WHEN COUNT(DISTINCT invoice) BETWEEN 6 AND 10 THEN 'Regular'
            ELSE 'VIP'
        END as purchase_tier
    FROM delivered_products
    WHERE customer_id IS NOT NULL
    GROUP BY customer_id
) customer_segments
GROUP BY purchase_tier
ORDER BY 
    CASE purchase_tier
        WHEN 'VIP' THEN 1
        WHEN 'Regular' THEN 2
        WHEN 'Occasional' THEN 3
        WHEN 'One-time' THEN 4
    END;
    
-- 5. Monthly Sales Trend
-- Revenue trend by month
SELECT 
    DATE_FORMAT(invoice_date, '%Y-%m') as month,
    COUNT(DISTINCT invoice) as order_count,
    COUNT(DISTINCT customer_id) as unique_customers,
    SUM(total_revenue) as monthly_revenue,
    ROUND(AVG(total_revenue), 2) as avg_order_value
FROM delivered_products
WHERE customer_id IS NOT NULL
GROUP BY DATE_FORMAT(invoice_date, '%Y-%m')
ORDER BY month;

-- 6. Top 10 Customers by Total Spending
-- Highest value customers
SELECT 
    customer_id,
    COUNT(DISTINCT invoice) as purchase_frequency,
    COUNT(*) as total_items_purchased,
    SUM(total_revenue) as lifetime_value,
    ROUND(AVG(total_revenue), 2) as avg_transaction_value,
    MAX(invoice_date) as last_purchase_date
FROM delivered_products
WHERE customer_id IS NOT NULL
GROUP BY customer_id
ORDER BY lifetime_value DESC
LIMIT 10;

