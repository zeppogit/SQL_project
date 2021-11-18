/* StockBroker-CreateDBObjects.sql
 * Author: Rick Sweeney
 *
 * Tables:
 *      Clients (ClientID, FirstName, LastName, Address, Phone, Birth, DateLastContacted)
 *      Portfolios (PortfolioID, Client_id, Type)  
 *        -- Type = Regular, IRA, Roth, InheritedIRA, InheritedRoth, Trust)
 *      StocksFollowed (StockID, StockName, StockExchange, ClosingPrice, PE) 
 *      StocksHeld (Stock_id, Portfolio_id, NumShares)  
 *      TradeLog (TradeID, Portfolio_id, Stock_id, datetime, BuySellInOut, Num, Price) 
 *
 * Indexes:
 *      IX_Symbol
 *
 * Stored Procedures
 *      CreateFollowedStock @Symbol, @StockName, @StockExchange, @ClosingPrice, @PE
 *      DeleteFollowedStock @Symbol
 *      StocksHeldByClient @FirstName, @LastName
 *      UpdateLastContact @FirstName, @LastName, @LastContact 
 *      LogATrade @FirstName, @LastName, @AcctType, @Symbol, @BuySellInOut, @Number, @Price, @TradeDate
 *
 */



/**********************************************************

    Tables

**********************************************************/
IF OBJECT_ID('TradeLog', 'U') IS NOT NULL
    DROP TABLE TradeLog;

IF OBJECT_ID('StocksHeld', 'U') IS NOT NULL
    DROP TABLE StocksHeld;   

IF OBJECT_ID('StocksFollowed', 'U') IS NOT NULL
    DROP TABLE StocksFollowed;
    
IF OBJECT_ID('Portfolios', 'U') IS NOT NULL
    DROP TABLE Portfolios;

IF OBJECT_ID('Clients', 'U') IS NOT NULL 
    DROP TABLE Clients;

   

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


CREATE TABLE StocksFollowed
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
    [PortfolioID] INT NOT NULL,
    [StockID] INT NOT NULL, 
    [NumShares] INT NOT NULL,
    FOREIGN KEY(PortfolioID) REFERENCES Portfolios(PortfolioID),
    FOREIGN KEY(StockID) REFERENCES StocksFollowed(StockID)
);
GO


 --   TradeLog (TradeID, PortfolioID, StockID, datetime, BuySellInOut, Num, Price)
CREATE TABLE TradeLog
(
    [TradeID] INT NOT NULL IDENTITY PRIMARY KEY,
    [PortfolioID] INT NOT NULL,
    [StockID] INT NOT NULL, 
    [BuySellInOut] NVARCHAR(10) NOT NULL,
    [Num] INT NOT NULL,
    [Price] FLOAT NOT NULL,
    [DateTime] DATETIME NOT NULL,
    FOREIGN KEY(PortfolioID) REFERENCES Portfolios(PortfolioID),
    FOREIGN KEY(StockID) REFERENCES StocksFollowed(StockID)  -- consider renaming StockID to StocksFollowedID
);
GO
  

/*****************************************************

    Indexes

*****************************************************/


CREATE NONCLUSTERED INDEX IX_Symbol ON StocksFollowed 
(
    Symbol DESC
)
GO



/******************************************************

    Stored Procedures
    
******************************************************/


IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = N'CreateFollowedStock' AND ROUTINE_TYPE = N'PROCEDURE')
DROP PROCEDURE CreateFollowedStock
GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = N'DeleteFollowedStock' AND ROUTINE_TYPE = N'PROCEDURE')
DROP PROCEDURE DeleteFollowedStock
GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = N'StocksHeldByClient' AND ROUTINE_TYPE = N'PROCEDURE')
DROP PROCEDURE StocksHeldByClient
GO

IF EXISTS ( SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = N'UpdateLastContact' AND ROUTINE_TYPE = N'PROCEDURE')
DROP PROCEDURE UpdateLastContact
GO

IF EXISTS ( SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = N'LogATrade' AND ROUTINE_TYPE = N'PROCEDURE')
DROP PROCEDURE LogATrade
GO

/** 
    Stored Procedure: CreateFollowedStock
    Usage: Creates a new stock record to the StocksFollowed table. 
    Parameters:
        @Symbol(required) - Stock symbol used to trade the stock.
        @StockName (required) - The name of the stock (ie. Company name).
        @StockExchange (required) - The name of the exchange where the stock trades.
        @ClosingPrice (required) - Current price of the stock as of last close.
        @PE (required) - Current P/E ratio of the stock.
    Returns:
        None
    Error Checks:
        Required fields cannot be empty
**/

CREATE PROCEDURE CreateFollowedStock @Symbol NVARCHAR(10), @StockName NVARCHAR(50), @StockExchange NVARCHAR(10), @ClosingPrice FLOAT, @PE INT  AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        IF((@Symbol IS NULL OR @StockName IS NULL OR @StockExchange IS NULL OR @ClosingPrice IS NULL) OR (@Symbol = '' OR @StockName = '' OR @StockExchange = '' OR @ClosingPrice = '' OR @PE = ''))
            BEGIN
                RAISERROR('@Symbol, @StockName, @StockExchange, @ClosingPrice, and @PE cannot be null or empty',17,0)
            END
        ELSE
        BEGIN
            DECLARE @StockCount INT = (SELECT COUNT(1) FROM StocksFollowed WHERE Symbol = @Symbol)
            DECLARE @StockID INT
            IF(@StockCount = 0)
                BEGIN
                    INSERT INTO StocksFollowed VALUES (@Symbol, @StockName, @StockExchange, @ClosingPrice, @PE)
               END
            ELSE
                BEGIN
                    RAISERROR('This stock is already being followed.', 17,0)
                END
        END
    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT;
        SELECT @ErrorMessage = ERROR_MESSAGE(), @ErrorSeverity = ERROR_SEVERITY(), @ErrorState = ERROR_STATE();
        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState );
    END CATCH

END
GO

/** 
    Stored Procedure: DeleteFollowedStock
    Usage: Deletes a stock record from the StocksFollowed table. 
    Parameters:
        @Symbol(required) - Stock symbol used to trade the stock.
    Returns:
        None
    Error Checks:
        None
**/


CREATE PROCEDURE DeleteFollowedStock @Symbol NVARCHAR(10) AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @StockID INT = (SELECT StocksFollowed.StockID FROM StocksFollowed WHERE Symbol = @Symbol)
    DELETE FROM StocksFollowed WHERE StocksFollowed.StockID = @StockID
END
GO

/** 
    Stored Procedure:  StocksHeldByClient
    Usage:  List portfolios of a client and the stocks they hold.
    Parameters:
        @FirstName (required) - First name of client
        @LastName (required) - Last name of client
    Returns:
        None
    Error Checks:
        None
**/

/* ************************************ */

CREATE PROCEDURE StocksHeldByClient @FirstName NVARCHAR(50), @LastName NVARCHAR (50) AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
    IF((@FirstName IS NULL OR @LastName IS NULL) OR (@FirstName = '' OR @LastName = ''))
    BEGIN
        RAISERROR('@FirstName and @LastName cannot be null or empty',18,0)
    END
    ELSE
    BEGIN  -- get all portfolios held by a client
        
        SELECT Portfolios.Type, Clients.FirstName, Clients.LastName, Stocks.Symbol, StocksHeld.NumShares
        FROM Portfolios 
        INNER JOIN Clients ON Clients.ClientID = Portfolios.ClientID
        INNER JOIN StocksHeld ON StocksHeld.PortfolioID = Portfolios.PortfolioID
        INNER JOIN Stocks ON Stocks.StockID = StocksHeld.StockID
        WHERE (FirstName = @FirstName AND LastName = @LastName)
    END
    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT;
        SELECT @ErrorMessage = ERROR_MESSAGE(), @ErrorSeverity = ERROR_SEVERITY(), @ErrorState = ERROR_STATE();
        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState );
    END CATCH

END
GO


/** 
    Stored Procedure: UpdateLastContact 
    Usage: Updates the date and time there was contact with client.
    Parameters:
        @FirstName (required) - First name of the client.
        @LasstName (required) - Last name of the client.
        @LastContact (required) - The new date contacted.
    Returns:
        None
    Error Checks:
        Required Fields cannot be empty
**/



CREATE PROCEDURE UpdateLastContact  @FirstName NVARCHAR(50), @LastName NVARCHAR (50), @LastContact DATETIME AS
 
BEGIN
    SET NOCOUNT ON; 
    BEGIN TRY
    IF((@FirstName IS NULL OR @LastName IS NULL OR @LastContact IS NULL) OR (@FirstName = '' OR @LastName = '' OR @LastContact = ''))
        BEGIN
        RAISERROR('@FirstName and @LastName cannot be null or empty',18,0)
        END
    ELSE
        BEGIN  
        UPDATE Clients SET Clients.LastContact = @LastContact WHERE (Clients.FirstName = @FirstName AND Clients.LastName = @LastName);
    -- make note that this assumes there are no clients with same first and last name 
        END
    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT;
        SELECT @ErrorMessage = ERROR_MESSAGE(), @ErrorSeverity = ERROR_SEVERITY(), @ErrorState = ERROR_STATE();
        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState );
    END CATCH

END
GO

/** 
    Stored Procedure: LogATrade
    Usage: Creates a new trade record to the TradeLog table. 
    -- TradeLog (TradeID, DateTime, BuySellInOut, Num, Price, Portfolio_id, Stocks_id)
    -- TransType : transaction type is either Buy, Sell, In ( a transfer in), or Out.
    -- FOR PURPOSES OF THIS PROJECT, IT IS ASSUMED NO TWO CLIENTS CAN HAVE THE SAME FIRST AND LAST NAME  *****

    Parameters:
        @DateTime(required) - Date and time trade requested
        @FirstName - First name of client
        @LastName - Last name of client
        @AcctType - Regular, IRA, Roth, InheritedIRA, InheritedRoth  - assumes no more than one acct of each type
        @Symbol - Stock symbol
        @Number of shares traded  
        @BuySellInOut
        @Price  - Price of the stock when traded
    Returns:
        None
    Error Checks:
        Required fields cannot be empty
**/

/* =============================================================== */

CREATE PROCEDURE LogATrade @FirstName NVARCHAR(50), @LastName NVARCHAR (50), @AcctType NVARCHAR(10), @Symbol NVARCHAR(10), @BuySellInOut NVARCHAR(10), @Number INT, @Price FLOAT, @TradeDate DATETIME AS 

BEGIN
    DECLARE @ClientID INT = (SELECT Clients.ClientID FROM Clients WHERE (Clients.FirstName = @FirstName AND Clients.LastName = @LastName));
    UPDATE Clients SET Clients.LastContact = @TradeDate WHERE (Clients.ClientID = @ClientID);
    DECLARE @PortfolioID INT = (SELECT Portfolios.PortfolioID FROM Portfolios WHERE (Portfolios.ClientID = @ClientID AND Portfolios.Type = @AcctType))
    DECLARE @StockID INT = (SELECT StocksFollowed.StockID FROM StocksFollowed WHERE (StocksFollowed.Symbol = @Symbol))
    IF (@BuySellInOut = 'Sell' OR @BuySellInOut = 'Out') 
        BEGIN
          SET @Number = -@Number
        END
    INSERT INTO TradeLog VALUES (@PortfolioID, @StockID, @BuySellInOut, @Number, @Price, @TradeDate)
   -- consider changing @Price to @TradePrice
    UPDATE StocksHeld SET StocksHeld.NumShares = (@Number + StocksHeld.NumShares) WHERE ((PortfolioID = @PortfolioID) AND (StockID = @StockID));

END
GO



