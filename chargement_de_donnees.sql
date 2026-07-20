-- CHARGEMENT DES DONNEES
--Étape de transformation et de chargement des données dans le schéma relationnel
PRAGMA foreign_keys = ON;

-- REINITIALISATION DES TABLES (permet de relancer le script plusieurs fois)
DELETE FROM Lignes_Commande;
DELETE FROM Commandes;
DELETE FROM Produits;
DELETE FROM Clients;

DELETE FROM sqlite_sequence
WHERE name = 'Lignes_Commande';

-- CHARGEMENT DE LA TABLE CLIENTS

INSERT INTO Clients (Customer_ID)
SELECT DISTINCT Customer_ID
FROM online_retail_clean;

-- CHARGEMENT DE LA TABLE PRODUITS (Conservation de la description la plus fréquente pour chaque StockCode)

WITH descriptions_classees AS (
    SELECT
        StockCode,
        Description,
        COUNT(*) AS nombre_occurrences,

        ROW_NUMBER() OVER (
            PARTITION BY StockCode
            ORDER BY COUNT(*) DESC, Description ASC
        ) AS rang

    FROM online_retail_clean

    WHERE StockCode IS NOT NULL
      AND Description IS NOT NULL

    GROUP BY
        StockCode,
        Description
)

INSERT INTO Produits (
    StockCode,
    Description
)

SELECT
    StockCode,
    Description

FROM descriptions_classees

WHERE rang = 1;

-- CHARGEMENT DE LA TABLE COMMANDES (Conservation de la date la plus fréquente pour chaque facture)

WITH dates_classees AS (
    SELECT
        Invoice,
        InvoiceDate,
        Customer_ID,
        Country,
        COUNT(*) AS nombre_occurrences,

        ROW_NUMBER() OVER (
            PARTITION BY Invoice
            ORDER BY COUNT(*) DESC, InvoiceDate ASC
        ) AS rang

    FROM online_retail_clean

    WHERE Invoice IS NOT NULL
      AND InvoiceDate IS NOT NULL
      AND Customer_ID IS NOT NULL
      AND Country IS NOT NULL

    GROUP BY
        Invoice,
        InvoiceDate,
        Customer_ID,
        Country
)

INSERT INTO Commandes (
    Invoice,
    InvoiceDate,
    Customer_ID,
    Country
)

SELECT
    Invoice,
    InvoiceDate,
    Customer_ID,
    Country

FROM dates_classees

WHERE rang = 1;

-- CHARGEMENT DE LA TABLE LIGNES_COMMANDE

INSERT INTO Lignes_Commande (
    Invoice,
    StockCode,
    Quantity,
    Price,
    Chiffre_Affaires
)

SELECT
    src.Invoice,
    src.StockCode,
    src.Quantity,
    src.Price,
    src.Chiffre_Affaires

FROM online_retail_clean AS src

INNER JOIN Commandes AS co
    ON src.Invoice = co.Invoice

INNER JOIN Produits AS p
    ON src.StockCode = p.StockCode;