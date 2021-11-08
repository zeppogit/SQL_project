## Code Louisville SQL class project

Currently under construction.

Class project to practice and demonstrate basic database management with SQL

I have chosen a simple database of client and stock information as a vehicle to demonstrate SQL coding (not as realistic management tool--   it may be assumed that stock information fields, such as  price, are kept current by means not provided here).

# Description

The database includes tables that store information about stocks that a broker follows, his clients, and his clients' portfolios made up of stocks that the broker follows, and a transaction log.

## Features

Stored procedures will be added which

| Feature | Command |
| -------- | -------- |
| List all portfolios of a client and the stocks they hold |
| List all clients that hold a particular stock |
| Add a new stock to the list of Stocks Followed |
| Delete a stock from the list of Stocks Followed|
| List all transactions by a particular client|
| Record a new transaction and make the change in client's portfolio |

## Technical Instructions
- Requires MS SQL Server
- Execute the PlayMyBeats-CreateDBObjects.sql script to create the database objects
- Execute the PlayMyBeats-LoadSampleData.sql script to load the sample data
- Execute the PlayMyBeats-UnitTests.sql file to test out the functionality
- The PlayMyBeats.sql file has example commands showing how to use the stored procedures.