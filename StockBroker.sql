/** Add a stock to StocksFollowed **/
EXECUTE CreateFollowedStock @Symbol = "XOM", @StockName = "Exxon Mobile", @StockExchange = "NYSE", @ClosingPrice = 65.02, @PE = NULL
GO

SELECT *
FROM StocksFollowed
GO