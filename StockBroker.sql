/* StockBroker sample commands */


/** Add a stock to StocksFollowed **/

EXECUTE CreateFollowedStock @Symbol = "XOM", @StockName = "Exxon Mobile", @StockExchange = "NYSE", @ClosingPrice = 65.02, @PE = NULL
GO

/*
SELECT *
FROM StocksFollowed
Go
*/


/** Delete a stock from StocksFollowed **/

EXECUTE DeleteFollowedStock @Symbol = "XOM"
GO




/** Show the stocks held by each clients, grouped by portfolio **/

EXECUTE StocksHeldByClient @FirstName = "John", @LastName ="Smith"
GO



/** Update the date and time of last contact with a client **/

EXECUTE UpdateLastContact @FirstName = "John", @LastName ="Smith", @LastContact = "2021-05-10 11:00:00"
GO


/** Log a stock transaction.  
The date and time of the transaction will be used to update the LastContact information in the Clients table.  
The number of shares will also be used to adjust the number of shares in the StocksHeld table by that client. **/

EXECUTE LogATrade @FirstName = "John", @LastName = "Smith", @AcctType = 'Roth', @Symbol = 'F', @BuySellInOut = 'SELL', @Number = 100, @Price = 17.00, @TradeDate = "2021-11-01 12:00:00"
GO


/* ================================================== */

/*

SELECT *
FROM Clients
GO


SELECT *
FROM TradeLog
GO


SELECT *
FROM StocksFollowed
GO

*/