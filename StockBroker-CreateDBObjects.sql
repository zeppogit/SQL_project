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
    [LastName] NVARCHAR(50) NOT NULL,
    [Address]  NVARCHAR(200) NOT NULL,
    [Phone] NVARCHAR(50) NOT NULL,
    [Birth] DATE NOT NULL
 /*       [LastContact] DATETIME NOT NULL */
);
GO

/** TEMP HERE -  to put on other file to load data - testing here */

INSERT INTO Clients
VALUES ('John', 'Smith','101 Elm St, Muncie, IN, 47306','765-289-5555','1980-10-01'),
       ('Jane', 'Doe', '200 Main St, Muncie, IN, 47306', '765-555-3232', '1975-09-24');

GO

--MY VERIFICATION
SELECT *
FROM Clients
GO