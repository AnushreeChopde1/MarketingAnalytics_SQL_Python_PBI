-- select * from dbo.customers;

-- select * from dbo.geography;

/** Retrieving customer data with geographic location **/

SELECT
	c.customerId,  -- selects the unique identifier for each customer
	c.CustomerName,  -- selects the name of each customer
	c.Email,  -- selects the email of each customer
	c.Gender,  -- selects the gender of each customer
	c.Age,  -- selects the age of each customer
	g.Country,  -- selects the country from the geography table to enrich customer data
	g.city  -- selects the city from the geography table to enrich customer data
-- INTO dim_customers
FROM dbo.customers c
LEFT JOIN dbo.geography g
ON c.GeographyID = g.GeographyID  -- joins the two tables on the GeographyID field to match customers with their geographic information


/** Check if the new table is created with cleaned data **/

/* USE PortfolioProject_MarketingAnalytics;
GO

SELECT TOP 10 * FROM dim_customers;*/