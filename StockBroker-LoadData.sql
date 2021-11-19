/* StockBroker-LoadData.sql
 * Author: Rick Sweeney
 * Date Created: 11/18/2021
 * Description:  sample date for StockBroker app
 */

 
INSERT INTO Clients --- 
VALUES  ('John', 'Smith','101 Elm St, Muncie, IN, 47306','765-289-5555','1980-10-01', '2021-10-12 11:10:00'),
        ('Jane', 'Doe', '200 Main St, Muncie, IN, 47306', '765-555-3232', '1975-09-24', '2021-09-16 13:30:00'),
        ('Henry', 'Miller', '300 10th St, Muncie, IN, 47306', '765-556-3442', '1985-03-24', '2021-09-16 10:30:00'),
        ('Alice', 'Cramden', '200 Main St, Muncie, IN, 47306', '765-555-3552', '1935-01-12', '2021-11-16 15:30:00'),
        ('Ed', 'Norton', '300 Sewer St, Muncie, IN, 47306', '765-555-3600', '1927-03-14', '2021-03-20 15:40:00');
GO

INSERT INTO Portfolios 
VALUES (1, 'Roth'),
        (1, 'Regular Acct'),
        (2, 'Regular Acct'),
        (3, 'IRA'),
        (3, 'Regular Acct'),
        (4, 'Regular Acct'),
        (4, 'Inherited IRA'),
        (5, 'Regular Acct'),
        (5, 'IRA');
GO


--StocksFollowed (StockID, Symbol, StockName, StockExchange, ClosingPrice, PE) 
INSERT INTO StocksFollowed
VALUES ('GOOG', 'Alphabet Inc', 'NASDAQ', 2875.48, 27),
    ('F', 'Ford Motor Company', 'NASDAQ', 19.20, 27),
    ('DIS', 'Walt Disney Company (The)', 'NASDAQ', 175.63, 280),
    ('SNOW', 'Snowflake Inc', 'NASDAQ', 364.80, NULL),
    ('WMT', 'Walmart Inc.', 'NASDAQ', 152.23, 42),
    ('GS', 'Goldman Sachs Group (The), Inc', 'NASDAQ', 407.08, 7),
    ('HD', 'Home Depot, Inc', 'NYSE', 368.40, 26),
    ('HON', 'Honeywell International, Inc', 'NASDAQ', 226.06, 29),
    ('AMZN', 'Amazon.com, Inc', 'NASDAQ', 3517.99, 69),
    ('TSLA', 'Tesla, Inc.', 'NASDAQ', 1222.09, 396),
    ('VZ', 'Verizon Communications Inc', 'NYSE', 52.24, 10),
    ('SHOP', 'Shopify, Inc', 'NYSE', 1528.06, 57),
    ('CRM', 'Salesforce.com, Inc', 'NYSE', 307.25, 122),
    ('NVDA', 'NVIDIA Corporation', 'NASDAQ', 297.29, 106),
    ('TMUS', 'T-Mobile US, Inc', 'NASDAQ', 122.27, 46),
    ('ADBE', 'Adobe Inc.', 'NASDAQ', 661.90, 55),
    ('XPO', 'XPO Logistics, Inc.', 'NYSE', 78.60, 24),
    ('GM', 'General Motors Company', 'NYSE', 58.52, 8),
    ('KO', 'Coca-Cola Company (The)', 'NYSE',56.84, 28),
    ('LLY', 'Eli Lilly and Company', 'NYSE', 265, 40),
    ('LOW', 'Lowes Companies, Inc', 'NYSE', 235.54, 25),
    ('LVS', 'Las Vegas Sands Corp.', 'NYSE', 42.60, NULL),
    ('MCD', 'McDonalds Corp.', 'NYSE', 254.55, 26),
    ('MELI', 'MercadoLibre, Inc', 'NYSE', 1629.76, 1024),
    ('MRNA', 'Moderna, Inc', 'NASDAQ', 236.99, 14),
    ('NKE', 'Nike, Inc', 'NYSE', 177.51, 59),
    ('MU', 'Micron Technology, Inc', 'NASDAQ', 72.92, 14),
    ('NFLX', 'Netflix, Inc', 'NASDAQ', 645.52, 59),
    ('NOW', 'ServiceNow, Inc', 'NYSE', 692.01, 634),
    ('PEP', 'PepsiCo, Inc', 'NASDAQ', 165.51, 28),
    ('TGT', 'Target Corp.', 'NYSE', 254.27, 20),
    ('VIAC', 'ViacomCBS, Inc', 'NASDAQ', 36.34, 7),
    ('NOK', 'Nokia Corp.', 'NYSE', 5.77, NULL);
    GO

--  StocksHeld (PortfolioID, StockID, NumShares) 
INSERT INTO StocksHeld   
VALUES  (1, 2, 200),
        (1, 11, 200),
        (1, 16, 10),
        (1, 19, 100),
        (1, 28, 10),
        (2, 1, 10),
        (2, 2, 100),
        (2, 9, 10),
        (2, 16, 10),
        (2, 17, 100),
        (2, 25, 10),
        (3, 2, 100),
        (3, 5, 100),
        (3, 9, 1),
        (3, 17, 100),
        (3, 28, 10),
        (4, 1, 10),
        (4, 7, 10),
        (4, 10, 10),
        (4, 16, 10),
        (4, 21, 100),
        (5, 6, 10),
        (5, 9, 10),
        (5, 10, 10),
        (5, 14, 10),
        (5, 21, 100),
        (6, 4, 10),
        (6, 7, 10),
        (6, 11, 100),
        (6, 12, 1),
        (6, 14, 10),
        (6, 19, 100),
        (6, 25, 10),
        (7, 2, 100),
        (7, 10, 10),
        (7, 16, 10),
        (7, 19, 100),
        (7, 21, 10),
        (8, 1, 20),
        (8, 7, 10),
        (8, 11, 100),
        (8, 18, 100),
        (8, 28, 1),
        (9, 1, 10),
        (9, 9, 10),
        (9, 12, 10),
        (9, 17, 100),
        (9, 21, 100),
        (9, 22, 100),
        (9, 25, 10);
GO

-- TradeLog (TradeID, PortfolioID, StockID, datetime, BuySellInOut, Num, Price)

INSERT INTO TradeLog   
VALUES  (2, 1, 'In', 1, 1148.15, '2019-02-04 10:25:00'),
        (2, 1, 'In', 100, 8.77, '2019-02-04 10:25:00'),
        (3, 7, 'Sell', 5, 318.11, '2021-07-08 11:38:00'),
        (1, 11, 'Buy', 100, 55.10, '2021-03-03 14:11:00'),
        (6, 14, 'Buy', 10, 132.22, '2021-03-17 09:41:00'),
        (9, 22, 'Buy', 22, 61.50,  '2021-04-12 12:51:00');
GO


--TEMPORARY FOR MY VERIFICATION

/*

SELECT *
FROM Clients
GO

SELECT *
FROM Portfolios
GO

SELECT *
FROM StocksFollowed
GO

SELECT *
FROM StocksHeld
GO

SELECT *
FROM TradeLog
GO



*/