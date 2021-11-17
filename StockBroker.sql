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

EXECUTE LogATrade @FirstName = "John", @LastName = "Smith", @AcctType = 'Roth', @Symbol = 'F', @BuySellInOut = 'SELL', @Number = 100, @Price = 17.00, @TradeDate = "2021-01-01 12:00:00"
GO
-- AS IT IS, THIS IS CHANGING THE VALUE OF @NUMBER WITHIN THE TABLE, TO A NEGATIVE PER "SELL"-- NOT MY INTENT,
-- NEED TO FIX


/* ================================================== */

SELECT *
FROM Clients
GO


SELECT *
FROM TradeLog
GO

SELECT *
FROM StocksFollowed
GO

/* MY TEMPORARY NOTES +++++++++++++++++++++++++++++++++++  


    INDEX OPTIONS-  USED IN WHERE CONDITIONS:
 	Symbol - used in: 	LogATrade
					DeleteFollowedStock
					CreateFollowedStock

					
  	PortfolioID  used in:	LogATrade
						
	ClientID used in:		LogATrade
	
	FirstName used in:	StocksHeldByClient
						UpdateLastContact
						LogATrade

	LastName used in:	StocksHeldByClient
						UpdateLastContact
						LogATrade

	StockID used in:		DeleteFollowedStock  (after retrieving it with a SELECT)

   ++++++++++++++++++++++++++++++++++++ */