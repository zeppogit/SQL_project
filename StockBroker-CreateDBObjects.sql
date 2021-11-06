/* StockBroker-CreateDBObjects.sql
 * Author: Rick Sweeney
 *
 * Tables:
    Clients (ClientID, FirstName, LastName, Address, Phone, Birth, DateLastContacted)
    Portfolios (PortfolioID, Client_id, Type)  
        -- Type = Regular, IRA, Roth, InheritedIRA, InheritedRoth, Trust)
    Stocks (StockID, StockName, StockExchange, ClosingPrice, PE) --can i use / in a name?
    StocksHeld (Stock_id, Portfolio_id, NumShares)  --or might call it Holdings
    TradeLog (TradeID, datetime, Portfolio_id, Buy/Sell/TransferIn/TransferOut, Stock_id, Num, Price)
 */

/**********************************************************

    Tables

**********************************************************/
IF OBJECT_ID('TradeLog', 'U') IS NOT NULL
    DROP TABLE TradeLog;


IF OBJECT_ID('StocksHeld', 'U') IS NOT NULL
    DROP TABLE StocksHeld;   

IF OBJECT_ID('Portfolios', 'U') IS NOT NULL
    DROP TABLE Portfolios;

IF OBJECT_ID('Clients', 'U') IS NOT NULL 
    DROP TABLE Clients;


IF OBJECT_ID('Stocks', 'U') IS NOT NULL
    DROP TABLE Stocks;   



CREATE TABLE Clients
(
    [ClientID] INT NOT NULL IDENTITY PRIMARY KEY,
    [FirstName] NVARCHAR(50) NOT NULL, 
    [LastName] NVARCHAR(50) NOT NULL,
    [Address]  NVARCHAR(200) NOT NULL,
    [Phone] NVARCHAR(50) NOT NULL,
    [Birth] DATE NOT NULL,
    [LastContact] DATETIME NOT NULL 
);
GO


CREATE TABLE Portfolios    -- Type = Regular, IRA, Roth, InheritedIRA, InheritedRoth, Trust
(
    [PortfolioID] INT NOT NULL IDENTITY PRIMARY KEY,
    [ClientID] INT NOT NULL, 
    [Type] NVARCHAR(50) NOT NULL,
    FOREIGN KEY(ClientID) REFERENCES Clients(ClientID)
);
GO



CREATE TABLE Stocks
(
    [StockID] INT NOT NULL IDENTITY PRIMARY KEY,
    [Symbol] NVARCHAR(10) NOT NULL,  
    [StockName] NVARCHAR(50) NOT NULL,
    [StockExchange] NVARCHAR(10) NOT NULL,
    [ClosingPrice] FLOAT NOT NULL, -- need type for dollars
    [PE] INT -- must allow null for stocks not having a PE (is this default)
);
GO


CREATE TABLE StocksHeld
(
    [StocksHeldID] INT NOT NULL IDENTITY PRIMARY KEY,
    [StockID] INT NOT NULL,
    [PortfolioID] INT NOT NULL, 
    [NumShares] INT NOT NULL,
    FOREIGN KEY(PortfolioID) REFERENCES Portfolios(PortfolioID),
    FOREIGN KEY(StockID) REFERENCES Stocks(StockID)
);
GO

-- TradeLog (TradeID, datetime, Portfolio_id, Buy/Sell/TransferIn/TransferOut, Stocks_id, Num, Price)

CREATE TABLE TradeLog
(
    [TradeID] INT NOT NULL IDENTITY PRIMARY KEY,
    [DateTime] DATETIME NOT NULL,
    [PortfolioID] INT NOT NULL, 
    [BuySellInOut] INT NOT NULL,
    [StockID] INT NOT NULL,
    [Num] INT NOT NULL,
    [Price] FLOAT NOT NULL, -- need type for dollars
    FOREIGN KEY(PortfolioID) REFERENCES Portfolios(PortfolioID),
    FOREIGN KEY(StockID) REFERENCES Stocks(StockID)
);
GO


/** TEMP HERE FOR CONVENIENCE -  SEE other file  LoadData - testing here */

--MY VERIFICATION
SELECT *
FROM Portfolios
GO