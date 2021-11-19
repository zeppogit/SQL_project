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


/** Show the stocks held in each portfolio, with portfolio owner name (client) and number of shares **/

SELECT Portfolios.Type, Clients.FirstName, Clients.LastName, StocksFollowed.Symbol, StocksHeld.NumShares
FROM Portfolios 
   INNER JOIN Clients ON Clients.ClientID = Portfolios.ClientID
   INNER JOIN StocksHeld ON StocksHeld.PortfolioID = Portfolios.PortfolioID
   INNER JOIN StocksFollowed ON StocksFollowed.StockID = StocksHeld.StockID
GO


/** Show the stocks held by a particular client, grouped by portfolio **/

EXECUTE StocksHeldByClient @FirstName = "John", @LastName ="Smith"
GO

/** Enter a stock symbol and see who owns it **/

EXECUTE WhoHoldsParticularStock @Symbol = "LVS"  
GO



/** Update the date and time of last contact with a client **/

EXECUTE UpdateLastContact @FirstName = "John", @LastName ="Smith", @LastContact = "2021-05-10 11:00:00"
GO


/** Log a stock transaction.  
The date and time of the transaction will be used to update the LastContact information in the Clients table.  
The number of shares will also be used to adjust the number of shares in the StocksHeld table by that client. 
If the result of the transaction leaves the client with zero shares, 
    that stock is removed from the portfolio where the transaction took place.
This procedure is only to be used to sell shares that the client currently owns. 
(It is assumed that no attempt will be made to sell shares the client does not have).
**/

EXECUTE LogATrade @FirstName = "John", @LastName = "Smith", @AcctType = 'Roth', @Symbol = 'F', @BuySellInOut = 'SELL', @Number = 100, @Price = 17.00, @TradeDate = "2021-11-01 12:00:00"
GO



/* ================================================== */

/*

SELECT *
FROM TradeLog
GO

SELECT *
FROM Clients
GO

SELECT *
FROM StocksFollowed
GO


*/
