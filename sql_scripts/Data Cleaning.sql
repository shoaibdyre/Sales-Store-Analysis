--Data Cleaning

--Srep 1 Check Duplicates
Select transaction_id
from store
Group by transaction_id
Having Count(transaction_id)>1;

With CTE as (
select * ,
	ROW_NUMBER() over (partition by transaction_id order by transaction_id) as ranks
from store
)
--Delete from CTE
--where ranks = 2
select * from CTE
where transaction_id IN ('TXN240646','TXN342128','TXN855235','TXN981773');


--Correction Of Headers
EXEC sp_rename'store.quantiy','quantity','COLUMN'
EXEC sp_rename'store.prce','price','COLUMN'

--Check DataType
Select COLUMN_NAME, DATA_TYPE
from INFORMATION_SCHEMA.COLUMNS
Where TABLE_NAME='store';

--To check null value
--Null Count
DECLARE @SQL NVARCHAR(MAX) = '';

SELECT @SQL = STRING_AGG(
    'SELECT ''' + COLUMN_NAME + ''' AS ColumnName, 
    COUNT(*) AS NullCount 
    FROM ' + QUOTENAME(TABLE_SCHEMA) + '.store 
    WHERE ' + QUOTENAME(COLUMN_NAME) + ' IS NULL', 
    ' UNION ALL '
)
WITHIN GROUP (ORDER BY COLUMN_NAME)
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_NAME = 'store';

--- Execute the dynamic SQL
EXEC sp_executesql @SQL;


--Remove Null Value
SELECT *
FROM store 
WHERE transaction_id IS NULL ---Is a Outlier(Not Relate to table)
OR
customer_id IS NULL
OR
customer_name IS NULL
OR
customer_age IS NULL
OR
gender IS NULL
OR
product_id IS NULL
OR
product_name IS NULL
OR
product_category IS NULL
OR
quantity IS NULL
or
payment_mode is null
or
purchase_date is null
or 
status is null
or 
price is null

Delete from store
where transaction_id  is null;

select * from store
where customer_name ='Ehsaan Ram';

update store
set  customer_id='CUST9494'
where transaction_id='TXN977900'

select * from store
where customer_name ='Damini Raju';

Update store
set customer_id= 'CUST1401'
where transaction_id= 'TXN985663'

select * from store
where customer_id ='CUST1003';

Update store
set customer_name='Mahika Saini', customer_age = 35, gender='Male'
where transaction_id='TXN432798'

Select * from store;

--Step 5 Data Formating
--Gender
Select distinct gender from store;

update store
set gender='M'
where gender='Male'

update store
set gender='F'
where gender='Female'

--Payment Mode 

Select distinct payment_mode from store;

Update Store
Set payment_mode='Credit Card'
where payment_mode='CC'


