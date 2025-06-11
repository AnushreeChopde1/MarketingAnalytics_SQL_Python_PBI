select * from dbo.customer_journey;

/** Identify duplicate records with a CTE duplicated_records_cte **/

WITH duplicated_records_cte AS (
	SELECT
		JourneyId,
		CustomerId,
		ProductId,
		VisitDate,  -- select the date of the visit, which helps in determining the timeline of customer interactions
		Stage,  -- select the stage of the customer journey (e.g., Awareness, Consideration, etc.)
		Action,  -- select the action taken by the customer (e.g., View, Click, Purchase)
		Duration,  -- select the duration of the action or interaction
		ROW_NUMBER() OVER (
            PARTITION BY CustomerID, ProductID, VisitDate, Stage, Action  -- PARTITION BY groups the rows based on the specified columns that should be unique
            ORDER BY JourneyID  -- ORDER BY defines how to order the rows within each partition (usually by a unique identifier like JourneyID)
        ) AS row_num  -- assigned a unique row number to each record within the partition
FROM dbo.customer_journey
)

/** Checking cuplicated rows **/

SELECT *
FROM duplicated_records_cte
WHERE row_num > 1  -- filters out the first occurrence (row_num = 1) and only shows the duplicates (row_num > 1)
ORDER BY JourneyId;

/** Cleaning and Standardizing the data **/

SELECT 
	JourneyId, CustomerId, ProductId, VisitDate, Stage, Action, 
	COALESCE(Duration, avg_duration) as Duration  -- replaces missing durations with the average duration for the corresponding date
INTO fact_customer_journey
FROM (
		SELECT JourneyId, CustomerId, ProductId, VisitDate, UPPER(Stage) as Stage, Action, Duration, 
			   AVG(Duration) OVER(PARTITION BY VisitDate) as avg_duration, -- calculates the average duration for each date, using only numeric values
			   ROW_NUMBER() OVER(
					PARTITION BY CustomerID, ProductID, VisitDate, UPPER(Stage), Action  -- Groups by these columns to identify duplicate records
					ORDER BY JourneyId  -- orders by JourneyID to keep the first occurrence of each duplicate
			   ) AS row_num  -- assigns a row number to each row within the partition to identify duplicates
		FROM dbo.customer_journey		
     ) AS subquery
WHERE row_num = 1; -- keeps only the first occurrence of each duplicate group identified in the subquery


/** Check if the new table is created with cleaned data **/

USE PortfolioProject_MarketingAnalytics;
GO

SELECT TOP 10 * FROM fact_customer_journey;