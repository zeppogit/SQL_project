/** Add a stock to StocksFollowed **/
EXECUTE CreateFollowedStock @Symbol = "XOM", @StockName = "Exxon Mobile", @StockExchange = "NYSE", @ClosingPrice = 65.02, @PE = NULL
GO


/** Delete a stock from StocksFollowed **/

EXECUTE DeleteFollowedStock @Symbol = "XOM"
GO




SELECT *
FROM StocksFollowed
GO
