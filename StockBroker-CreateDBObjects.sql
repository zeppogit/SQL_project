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

CREATE TABLE Clients
(
    [ClientID] INT NOT NULL IDENTITY PRIMARY KEY,
    [FirstName] NVARCHAR(50) NOT NULL, 
    [LastName] NVARCHAR(50) NOT NULL
 /*   [Address]  NVARCHAR(200) NOT NULL,
    [Birth] DATE NOT NULL,
    [LastContact] DATETIME NOT NULL */
);
GO

/** for other file to load data - testing here */

INSERT INTO Clients
VALUES ('John', 'Smith'),
       ('Jane', 'Doe');
GO

--MY VERIFICATION
SELECT *
FROM Clients
GO