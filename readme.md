Realised Gross Margin Calculation

Objectives: 
1.Our main objectiv is the allocation of the acqusisiton cost on customer / hourly level, by using allocation keys ( consumption curve, customer type, product type, .. ). 
2.Monthly cost calculation on costumer level based on hourly data. 
3.Gross margin calculation on costumer level based on income, acqusition cost and fixed cost ( transportation cost,.. ). 

Calculation frequency: Calculation is done on monthly basis for B2B ( business to business) consumers. 
Data source: excel / flat files / database.

Data processing: => 
1.import: upload / get data from data sources
2 database : in the database the informations are organized on 3 levels : 
                                                                        => level 1 : interface tables / raw data. Bulk load data with minimal validations. Data validation is done with the help of stored procedures and errors are inserted into "vf" ( verification ) table type.
                                                                        => level 2 : intermediat calculation / aggregate data  are inserted into "calc" table type.
                                                                        => level 3 : final dates are organized into "md" table type (dimension and fact table used for creating data models in BI )
3.=> data processing : data processing is done using T-SQL procedures. During data processing messages are inserted into log table.