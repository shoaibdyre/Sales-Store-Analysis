SET DATEFORMAT dmy
Bulk insert store_analysis
from 'C:\Users\SHOAIB\Desktop\archive\sales.csv'
WITH(
	FIRSTROW=2,
	FIELDTERMINATOR=',',
	ROWTERMINATOR='\n'
	);

--Making Copy Of Data For Cleaning

Select * into store from store_analysis;
Select * from store;