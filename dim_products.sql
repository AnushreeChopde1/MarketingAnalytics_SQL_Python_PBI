-- select * from dbo.products;

/** Categorizing Products based on their price **/

SELECT
	ProductId,
	ProductName,
	Price,
	/* Categorizing the products into price categories - Low, Medium, High */
	CASE 
		WHEN Price < 50 THEN 'Low'
		WHEN Price BETWEEN 50 AND 200 THEN 'Medium'
		ELSE 'High'
	END AS PriceCategory  -- New column called PriceCategory
-- INTO dim_products
FROM  dbo.products;

/** Check if the new table is created with cleaned data **/

/*USE PortfolioProject_MarketingAnalytics;
GO

SELECT TOP 10 * FROM dim_products;*/