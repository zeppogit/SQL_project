/* StockBroker-LoadData.sql
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
 
INSERT INTO Clients
VALUES ('John', 'Smith','101 Elm St, Muncie, IN, 47306','765-289-5555','1980-10-01', '2021-10-12 11:10:00'),
       ('Jane', 'Doe', '200 Main St, Muncie, IN, 47306', '765-555-3232', '1975-09-24', '2021-09-16 13:30:00'),
       ('Ed', 'Norton', '300 Sewer St, Muncie, IN, 47306', '765-555-3600', '1927-03-14', '2021-03-20 15:40:00');
GO

INSERT INTO Portfolios
VALUES (1, 'Roth'),
        (1, 'Regular'),
        (2, 'Regular'),
        (3, 'IRA'),
        (3, 'Regular');
GO

--MY VERIFICATION
SELECT *
FROM Portfolios
GO

SELECT *
FROM Clients
GO