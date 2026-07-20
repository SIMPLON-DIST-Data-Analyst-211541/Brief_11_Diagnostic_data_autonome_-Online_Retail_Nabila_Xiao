-- =====================================================
-- VÉRIFICATIONS AVANT LA MODÉLISATION DES DONNÉES
-- =====================================================
SELECT *
FROM online_retail_clean
LIMIT 10;

--vérifier si un même client pouvait commander depuis plusieurs pays
SELECT
    Customer_ID,
    COUNT(DISTINCT Country) AS nombre_pays
FROM online_retail_clean
GROUP BY Customer_ID
HAVING COUNT(DISTINCT Country) > 1;

-- vérifier si un StockCode correspond toujours à une seule Description
SELECT
    StockCode,
    COUNT(DISTINCT Description) AS nb_descriptions
FROM online_retail_clean
WHERE Quantity <> 0
GROUP BY StockCode
HAVING COUNT(DISTINCT Description) > 1;

-- vérifier si chaque facture possède une seule date
SELECT
    Invoice,
    COUNT(DISTINCT DATE(InvoiceDate)) AS nb_dates
FROM online_retail_clean
GROUP BY Invoice
HAVING COUNT(DISTINCT DATE(InvoiceDate)) > 1;

-- Vérifier qu'une facture est associée à un seul client
SELECT
    Invoice,
    COUNT(DISTINCT Customer_ID) AS nb_clients
FROM online_retail_clean
GROUP BY Invoice
HAVING COUNT(DISTINCT Customer_ID) > 1;

-- Vérifier qu'une facture est associée à un seul pays
SELECT
    Invoice,
    COUNT(DISTINCT Country) AS nb_pays
FROM online_retail_clean
GROUP BY Invoice
HAVING COUNT(DISTINCT Country) > 1;


SELECT COUNT(*) AS nombre_lignes
FROM Lignes_Commande;