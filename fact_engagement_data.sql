-- select * from dbo.engagement_data;

/** Cleaning and Normalizing the engagement_data **/

SELECT
	EngagementId,  -- selects the unique identifier for each engagement record
	ContentId,  -- selects the unique identifier for each piece of content
	CampaignId,  -- selects the unique identifier for each marketing campaign
	ProductId,  -- selects the unique identifier for each product
	UPPER(REPLACE(ContentType, 'socialmedia', 'Social Media')) as ContentType,  -- replaces "Socialmedia" with "Social Media" and then converts all ContentType values to uppercase
	LEFT(ViewsClicksCombined, CHARINDEX('-', ViewsClicksCombined) - 1) AS Views,  -- extracts the Views part from the ViewsClicksCombined column by taking the substring before the '-' character
	RIGHT(ViewsClicksCombined, LEN(ViewsClicksCombined) - CHARINDEX('-', ViewsClicksCombined)) AS Clicks,  -- extracts the Clicks part from the ViewsClicksCombined column by taking the substring after the '-' character
	Likes,  -- selects the number of likes the content received
	FORMAT(CONVERT(DATE, EngagementDate), 'MM/dd/yyyy') AS EngagementDate  -- converts and formats the date as mm/dd/yyyy
-- INTO fact_engagement_data
FROM dbo.engagement_data
WHERE ContentType != 'Newsletter';  -- filters out roes where ContentType is 'Newsletter' as these are not relevant for this analysis


/** Check if the new table is created with cleaned data **/

/* USE PortfolioProject_MarketingAnalytics;
GO

SELECT TOP 10 * FROM fact_engagement_data; */