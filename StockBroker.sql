/** Add a stock to StocksFollowed **/
EXECUTE CreateFollowedStock @Symbol = "XOM", @StockName = "Exxon Mobile", @StockExchange = "NYSE", @ClosingPrice = 65.02, @PE = NULL
GO


/** Delete a stock from StocksFollowed **/

EXECUTE DeleteFollowedStock @Symbol = "XOM"
GO

SELECT *
FROM StocksFollowed
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


SELECT Portfolios.Type, Clients.FirstName, Clients.LastName, Stocks.Symbol, StocksHeld.NumShares
FROM Portfolios 
   INNER JOIN Clients ON Clients.ClientID = Portfolios.ClientID
   INNER JOIN StocksHeld ON StocksHeld.PortfolioID = Portfolios.PortfolioID
   INNER JOIN Stocks ON Stocks.StockID = StocksHeld.StockID
GO


----------------------------------
EXECUTE StocksHeldByClient @FirstName = "John", @LastName ="Smith"
GO


