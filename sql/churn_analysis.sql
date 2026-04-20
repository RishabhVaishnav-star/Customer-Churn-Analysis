-- ============================================
-- CUSTOMER CHURN ANALYSIS PROJECT (SQL)
-- ============================================

-- 1. TOTAL CUSTOMERS
SELECT COUNT(*) AS total_customers FROM churn;

-- 2. CHURN DISTRIBUTION
SELECT 
    Churn,
    COUNT(*) AS total_customers,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM churn), 2) AS percentage
FROM churn
GROUP BY Churn;

-- 3. CHURN BY CONTRACT TYPE
SELECT 
    Contract,
    Churn,
    COUNT(*) AS total
FROM churn
GROUP BY Contract, Churn
ORDER BY Contract;

-- 4. AVERAGE MONTHLY CHARGES BY CHURN
SELECT 
    Churn,
    ROUND(AVG(MonthlyCharges), 2) AS avg_monthly_charges
FROM churn
GROUP BY Churn;

-- 5. TENURE GROUP ANALYSIS
SELECT 
    CASE
        WHEN tenure <= 12 THEN '0-1 Year'
        WHEN tenure <= 24 THEN '1-2 Years'
        WHEN tenure <= 48 THEN '2-4 Years'
        ELSE '4+ Years'
    END AS tenure_group,
    Churn,
    COUNT(*) AS total
FROM churn
GROUP BY tenure_group, Churn
ORDER BY tenure_group;

-- 6. INTERNET SERVICE ANALYSIS
SELECT 
    InternetService,
    Churn,
    COUNT(*) AS total
FROM churn
GROUP BY InternetService, Churn;

-- 7. PAYMENT METHOD ANALYSIS
SELECT 
    PaymentMethod,
    Churn,
    COUNT(*) AS total
FROM churn
GROUP BY PaymentMethod, Churn;

-- 8. TECH SUPPORT IMPACT
SELECT 
    TechSupport,
    Churn,
    COUNT(*) AS total
FROM churn
GROUP BY TechSupport, Churn;

-- 9. HIGH RISK CUSTOMERS (BUSINESS INSIGHT)
SELECT *
FROM churn
WHERE 
    Contract = 'Month-to-month'
    AND MonthlyCharges > 70
    AND tenure < 12;

-- 10. TOP FACTORS SUMMARY (AGGREGATED VIEW)
SELECT 
    Contract,
    AVG(MonthlyCharges) AS avg_charges,
    AVG(tenure) AS avg_tenure,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churn_count
FROM churn
GROUP BY Contract;
