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

IF OBJECT_ID('Clients', 'U') IS NOT NULL 
    DROP TABLE Clients;
    
IF OBJECT_ID('Portfolios', 'U') IS NOT NULL
    DROP TABLE Portfolios;

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


CREATE TABLE Portfolios
(
    [PortfolioID] INT NOT NULL IDENTITY PRIMARY KEY,
    [Client_id] INT NOT NULL, 
    [Type] NVARCHAR(50) NOT NULL,
            -- Type = Regular, IRA, Roth, InheritedIRA, InheritedRoth, Trust
    FOREIGN KEY(Client_id) REFERENCES Clients(ClientID)
);
GO

--Stocks (StockID, StockName, StockExchange, ClosingPrice, PE) --can i use / in a name?

CREATE TABLE Stocks
(
    [StocksID] INT NOT NULL IDENTITY PRIMARY KEY,
    [StockName] NVARCHAR(50) NOT NULL,
    [StockExchange] NVARCHAR(10) NOT NULL,
    [ClosingPrice] INT NOT NULL, -- need type for dollars
    [PE] INT NOT NULL,
);
GO

/*
CREATE TABLE StocksHeld
(
    [StocksID] INT NOT NULL IDENTITY PRIMARY KEY,
    [Portfolio_id] INT NOT NULL, 
    [NumShares] INT NOT NULL,
    FOREIGN KEY(Portfolio_id) REFERENCES Portfolios(PortfolioID)
);
GO
*/

/** TEMP HERE FOR CONVENIENCE -  SEE other file  LoadData - testing here */

--MY VERIFICATION
SELECT *
FROM Stocks
GO