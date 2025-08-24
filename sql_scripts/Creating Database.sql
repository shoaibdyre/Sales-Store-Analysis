/*
=============================================================
Create Database 
=============================================================
Script Purpose:
    This script creates a new database named 'Sales_store' after checking if it already exists. 
    If the database exists, it is dropped and recreated.
*/

USE master;
GO

-- Drop and recreate the 'Sales_store' database
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'Sales_store')
BEGIN
    ALTER DATABASE Sales_store SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE Sales_store;
END;
GO

-- Create the 'Sales_store' database
CREATE DATABASE Sales_store;
GO

USE Sales_store;
GO
