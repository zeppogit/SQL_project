## StockBroker  - Code Louisville SQL class project


# Introduction
This repository for my Code Louisville Fall 2021 SQL course project. 

I created a database with a stock broker them with imaginary client and stock information as a vehicle to demonstrate SQL coding. (Obiviously not designed as realistic stock management tool:  it may be assumed that stock information fields, such as price, are kept current by means not provided here).

# Description

The database includes tables that store information about stocks that a broker follows, clients, stocks held by his clients, client portfolios made up of stocks that the broker follows, and a transaction log.

## Features

Stored procedures will be added which

| Feature | Command |
| -------- | -------- |
| List all portfolios of a client and the stocks they hold |
| Add a new stock to the list of Stocks Followed |
| Delete a stock from the list of Stocks Followed|
| Log a new transaction and reflect changes in client's portfolio and personal record (date of last contact)|
| List all transactions by a particular client|

## Technical Instructions
- Requires MS SQL Server or Azure (I used Azure).
- Execute the StockBroker-CreateDBObjects.sql script to create the database objects
- Execute the StockBroker-LoadSampleData.sql script to load the sample data
- The StockBroker.sql file has example commands showing how to use the stored procedures.