# **Realised Gross Margin Calculation**

*Objectives:*
1. Acqusisiton cost allocation on customer / hourly level, by using allocation keys. 
2. Monthly cost calculation on costumer level based on hourly data. 
3. Gross margin calculation on costumer level based on income, acqusition cost and fixed cost. 

*Calculation frequency:* Calculation is done on monthly basis for B2B ( business to business) consumers. 
*Data source:* excel / flat files / database.

*Data processing:*
1. Import: upload / get data from data sources
2. Database : in the database the informations are organized on 3 levels\
          1. level 1 - interface tables/raw data. Bulk load data with minimal validations. Data validation is done with the help of stored procedures and errors are inserted into "vf" ( verification ) table type.\
          2. level 2 - intermediat calculation/aggregate data  are inserted into "calc" table type.\
          3. level 3 - final dates are organized into "md" table type (dimension and fact table used for creating data models in BI )
3. Data processing : data processing is done using T-SQL procedures. During data processing messages are inserted into log table.
