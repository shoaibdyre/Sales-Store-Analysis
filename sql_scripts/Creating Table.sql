/*
===============================================================================
DDL Script: Create Tables
===============================================================================
Script Purpose:
    This script creates tables, dropping existing tables 
    if they already exist.
===============================================================================
*/

IF OBJECT_ID('store_analysis', 'U') IS NOT NULL
    DROP TABLE store_analysis;
GO

CREATE Table store_analysis(
   transaction_id VARCHAR(15),	
   customer_id VARCHAR(15),	
   customer_name VARCHAR(30),	
   customer_age	INT,
   gender VARCHAR(15),	
   product_id VARCHAR(15),
   product_name	VARCHAR(15),
   product_category	VARCHAR(15),
   quantiy INT,
   prce FLOAT,	
   payment_mode	VARCHAR(15),
   purchase_date DATE,	
   time_of_purchase	TIME,
   status VARCHAR(15)
);

GO

Select * from store_analysis;