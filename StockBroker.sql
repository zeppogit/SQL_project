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

SELECT *
FROM clients
GO


-- ====================================================================================
/* 
SELECT Portfolios.PortfolioID, Portfolios.Type, Portfolios.ClientID  
FROM Portfolios 
   INNER JOIN Clients ON Clients.ClientID = Portfolios.ClientID
--GROUP BY Portfolios.ClientID
GO


SELECT Portfolios.Type, Clients.FirstName, Clients.LastName  
FROM Portfolios 
   INNER JOIN Clients ON Clients.ClientID = Portfolios.ClientID
--GROUP BY Portfolios.ClientID
GO
*/


SELECT Portfolios.Type, Clients.FirstName, Clients.LastName, StocksFollowed.Symbol, StocksHeld.NumShares
FROM Portfolios 
   INNER JOIN Clients ON Clients.ClientID = Portfolios.ClientID
   INNER JOIN StocksHeld ON StocksHeld.PortfolioID = Portfolios.PortfolioID
   INNER JOIN StocksFollowed ON StocksFollowed.StockID = StocksHeld.StockID
GO
-- this is performed by procedure StocksHeldByClient

----------------------------------
EXECUTE StocksHeldByClient @FirstName = "John", @LastName ="Smith"
GO

EXECUTE UpdateLastContact @FirstName = "John", @LastName ="Smith", @LastContact = "2021-05-10 11:00:00"
GO

EXECUTE LogATrade @FirstName = "John", @LastName = "Smith", @AcctType = 'Roth', @Symbol = 'F', @BuySellInOut = 'Buy', @Number = 100, @Price = 17.00, @TradeDate = "2021-01-01 12:00:00"
GO


/* ================================================== */

SELECT *
FROM Clients
GO

SELECT *
FROM TradeLog
GO