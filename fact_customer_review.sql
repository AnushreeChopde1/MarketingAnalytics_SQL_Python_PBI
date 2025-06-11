-- select * from dbo.customer_reviews;

/** Cleaning ReviewText column **//**  Creating a new table to use the cleaned reviews data for sentiment analysis **/

USE PortfolioProject_MarketingAnalytics;
GO

SELECT 
	ReviewId,  -- selects the unique identifier for each review
	CustomerId,  -- selects the unique identifier for each customer
	ProductId,  -- selects the unique identifier for each product
	ReviewDate,  -- selects the date when the review was written
	Rating,  -- selects the numerical rating given by the customer (e.g., 1 to 5 stars)
	REPLACE(ReviewText, '  ', ' ') as ReviewText  -- cleans up the ReviewText by replacing double spaces with single spaces to ensure the text is more readable and standardized
-- INTO dbo.customer_reviews_cleaned  -- this creates the new table
FROM dbo.customer_reviews
;


/** Check if the new table is created with cleaned data **/

USE PortfolioProject_MarketingAnalytics;
GO

SELECT TOP 10 * FROM customer_reviews_cleaned;