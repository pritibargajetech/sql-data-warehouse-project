/*
===============================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
===============================================================================
Script Purpose:
    This stored procedure loads data into the 'bronze' schema from external CSV files. 
    It performs the following actions:
    - Truncates the bronze tables before loading data.
    - Uses the `BULK INSERT` command to load data from csv Files to bronze tables.

Parameters:
    None. 
	  This stored procedure does not accept any parameters or return any values.

Usage Example:
    EXEC bronze.load_bronze;
===============================================================================
*/

CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	BEGIN TRY
		PRINT '==================================';
		PRINT 'Loading Bronze Layer Data';
		PRINT '==================================';

		PRINT '-----------------------------------';
		PRINT 'Loading CRM Table';
		PRINT '>> Truncating Table: crm_cust_info';
		TRUNCATE TABLE bronze.crm_cust_info;
		PRINT '>> Inserting Data Into: crm_cust_info';
		BULK INSERT bronze.crm_cust_info
		FROM 'C:\Users\qapri\Documents\SQL Server Management Studio 22\Scripts\datasets\source_crm\cust_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);

		PRINT '-----------------------------------';
		PRINT '>> Truncating Table: crm_prd_info';
		TRUNCATE TABLE bronze.crm_prd_info;
		PRINT '>> Inserting Data Into: crm_prd_info';
		BULK INSERT bronze.crm_prd_info
		FROM 'C:\Users\qapri\Documents\SQL Server Management Studio 22\Scripts\datasets\source_crm\prd_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);

		PRINT '>> Truncating Table: crm_sales_details';
		TRUNCATE TABLE bronze.crm_sales_details;
		PRINT '>> Inserting Data Into: crm_sales_details';
		BULK INSERT bronze.crm_sales_details
		FROM 'C:\Users\qapri\Documents\SQL Server Management Studio 22\Scripts\datasets\source_crm\sales_details.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);

		PRINT '-----------------------------------';
		PRINT 'Loading ERP Table';
		PRINT '-----------------------------------';

		PRINT '>> Truncating Table: erp_cust_az12';
		TRUNCATE TABLE bronze.erp_cust_az12;
		PRINT '>> Inserting Data Into: erp_cust_az12';
		BULK INSERT bronze.erp_cust_az12
		FROM 'C:\Users\qapri\Documents\SQL Server Management Studio 22\Scripts\datasets\source_erp\CUST_AZ12.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);

		PRINT '>> Truncating Table: erp_loc_a101';
		TRUNCATE TABLE bronze.erp_loc_a101;
		PRINT '>> Inserting Data Into: erp_loc_a101';
		BULK INSERT bronze.erp_loc_a101
		FROM 'C:\Users\qapri\Documents\SQL Server Management Studio 22\Scripts\datasets\source_erp\LOC_A101.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);

		PRINT '>> Truncating Table: erp_px_cat_g1v2';
		TRUNCATE TABLE bronze.erp_px_cat_g1v2;
		PRINT '>> Inserting Data Into: erp_px_cat_g1v2';
		BULK INSERT bronze.erp_px_cat_g1v2
		FROM 'C:\Users\qapri\Documents\SQL Server Management Studio 22\Scripts\datasets\source_erp\PX_CAT_G1V2.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
	END TRY
	BEGIN CATCH
	PRINT '====================================';
	PRINT 'Error ocurred during loading Bronze layer data.';
	PRINT 'Error Message: ' + ERROR_MESSAGE();
	PRINT 'Error Number: ' + CAST(ERROR_NUMBER() AS NVARCHAR);
	PRINT 'Error State: ' + CAST(ERROR_STATE() AS NVARCHAR);
	PRINT '====================================';
	END CATCH
END
GO 
EXEC bronze.load_bronze
