-- =======================
-- 1. ANALYSE DES PRODUITS
-- =======================
-- ======================================
-- 1.1. TOP 10 DES PRODUITS LES PLUS VENDUS
-- ======================================

SELECT
    p.StockCode,
    p.Description,
    SUM(lc.Quantity) AS quantite_vendue

FROM Lignes_Commande lc

INNER JOIN Produits p
    ON lc.StockCode = p.StockCode

WHERE lc.Quantity > 0

GROUP BY
    p.StockCode,
    p.Description

ORDER BY
    quantite_vendue DESC
LIMIT 10;

-- =============================================================
-- 1.2. TOP 10 DES PRODUITS GENERANT LE PLUS DE CHIFFRE D'AFFAIRES
-- =============================================================

SELECT
    p.StockCode,
    p.Description,
    ROUND(SUM(lc.Chiffre_Affaires), 2) AS chiffre_affaires

FROM Lignes_Commande lc

INNER JOIN Produits p
    ON lc.StockCode = p.StockCode

WHERE lc.Quantity > 0

GROUP BY
    p.StockCode,
    p.Description

ORDER BY
    chiffre_affaires DESC

LIMIT 10;

-- ====================================================================================================
-- 1.3 Top 10 des produits les plus retournés (Identifier les produits qui génèrent le plus de retours)
-- ====================================================================================================

SELECT
    p.StockCode,
    p.Description,
    ABS(SUM(lc.Quantity)) AS quantite_retournee_totale

FROM Produits p

INNER JOIN Lignes_Commande lc
ON p.StockCode = lc.StockCode

WHERE lc.Quantity < 0

GROUP BY
    p.StockCode,
    p.Description

ORDER BY quantite_retournee_totale DESC

LIMIT 10;

-- ===========================================================================================================
-- 1.4 Top 10 des produits générant les plus fortes pertes liées aux retours (l'impact financier le plus élevé.
-- ===========================================================================================================

SELECT
    p.StockCode,
    p.Description,
    ROUND(ABS(SUM(lc.Chiffre_Affaires)), 2) AS montant_retours

FROM Produits p

INNER JOIN Lignes_Commande lc
ON p.StockCode = lc.StockCode

WHERE lc.Quantity < 0

GROUP BY
    p.StockCode,
    p.Description

ORDER BY montant_retours DESC

LIMIT 10;

-- ======================
-- 2. ANALYSE DES CLIENTS
-- ======================
-- ========================================================================================
-- 2.1 TOP 10 DES CLIENTS GENERANT LE PLUS DE CHIFFRE D'AFFAIRES (hors client fictif 99999)
-- ========================================================================================

SELECT
    c.Customer_ID,
    ROUND(SUM(lc.Chiffre_Affaires), 2) AS chiffre_affaires

FROM Commandes c

INNER JOIN Lignes_Commande lc
    ON c.Invoice = lc.Invoice

WHERE
    c.Customer_ID <> 99999
    AND lc.Quantity > 0

GROUP BY
    c.Customer_ID

ORDER BY
    chiffre_affaires DESC

LIMIT 10;

-- ========================================================================================================
-- 2.2 TOP 10 DES CLIENTS GENERANT LE PLUS DE CHIFFRE D'AFFAIRES (avec le client fictif pour voir l'impact)
-- ========================================================================================================

SELECT
    c.Customer_ID,
    ROUND(SUM(lc.Chiffre_Affaires), 2) AS chiffre_affaires

FROM Commandes c

INNER JOIN Lignes_Commande lc
    ON c.Invoice = lc.Invoice

WHERE lc.Quantity > 0

GROUP BY
    c.Customer_ID

ORDER BY
    chiffre_affaires DESC

LIMIT 10;

-- ============================
-- 3. ANALYSE GÉOGRAPHIQUE
-- ============================
-- ==========================================
-- 3.1 TOP 10 DES PAYS PAR CHIFFRE D'AFFAIRES
-- ==========================================

SELECT

    c.Country,

    ROUND(SUM(lc.Chiffre_Affaires), 2) AS chiffre_affaires

FROM Commandes c

INNER JOIN Lignes_Commande lc
    ON c.Invoice = lc.Invoice

WHERE lc.Quantity > 0

GROUP BY
    c.Country

ORDER BY
    chiffre_affaires DESC

LIMIT 10;

-- ==============================================
-- 3.2 TOP 10 DES PAYS AYANT LE PLUS DE COMMANDES
-- ==============================================

SELECT
    co.Country,
    COUNT(DISTINCT co.Invoice) AS nombre_commandes

FROM Commandes co

INNER JOIN Lignes_Commande lc
    ON co.Invoice = lc.Invoice

WHERE lc.Quantity > 0

GROUP BY co.Country

ORDER BY nombre_commandes DESC

LIMIT 10;

-- ====================================
-- 3.3 TOP 10 DES PAYS PAR PANIER MOYEN
-- ====================================

SELECT
    c.Country,

    ROUND(
        SUM(lc.Chiffre_Affaires) /
        COUNT(DISTINCT c.Invoice),
        2
    ) AS panier_moyen

FROM Commandes c

INNER JOIN Lignes_Commande lc
ON c.Invoice = lc.Invoice

WHERE lc.Quantity > 0

GROUP BY c.Country

ORDER BY panier_moyen DESC

LIMIT 10;

-- =====================
-- 4. ANALYSE TEMPORELLE
-- =====================

-- =======================================================
-- 4.1 Évolution mensuelle du chiffre d'affaires
-- =======================================================

SELECT

    strftime('%Y-%m', co.InvoiceDate) AS mois,

    ROUND(SUM(lc.Chiffre_Affaires), 2) AS chiffre_affaires

FROM Commandes co

INNER JOIN Lignes_Commande lc
ON co.Invoice = lc.Invoice

WHERE lc.Quantity > 0

GROUP BY strftime('%Y-%m', co.InvoiceDate)

ORDER BY mois;

-- ==========================================================
-- 4.2 Évolution mensuelle du nombre de commandes
-- ==========================================================

SELECT

    strftime('%Y-%m', co.InvoiceDate) AS mois,

    COUNT(DISTINCT co.Invoice) AS nombre_commandes

FROM Commandes co

INNER JOIN Lignes_Commande lc
ON co.Invoice = lc.Invoice

WHERE lc.Quantity > 0

GROUP BY strftime('%Y-%m', co.InvoiceDate)

ORDER BY mois;

-- =================================================================
-- 4.3 Variation de chiffre d'affaires par rapport au mois précédent
-- =================================================================

WITH ca_mensuel AS (

    SELECT

        strftime('%Y-%m', co.InvoiceDate) AS mois,

        ROUND(SUM(lc.Chiffre_Affaires), 2) AS chiffre_affaires

    FROM Commandes co

    INNER JOIN Lignes_Commande lc
    ON co.Invoice = lc.Invoice

    WHERE lc.Quantity > 0

    GROUP BY strftime('%Y-%m', co.InvoiceDate)

)

SELECT

    mois,

    chiffre_affaires,

    LAG(chiffre_affaires)
        OVER (ORDER BY mois) AS ca_mois_precedent,

    ROUND(
        chiffre_affaires
        - LAG(chiffre_affaires)
          OVER (ORDER BY mois),
        2
    ) AS variation_ca

FROM ca_mensuel

ORDER BY mois;

-- =====================================================
-- 4.4 Analyse comparative de la saisonnalité par année
-- =====================================================

SELECT
    strftime('%m', co.InvoiceDate) AS numero_mois,

    CASE strftime('%m', co.InvoiceDate)
        WHEN '01' THEN 'Janvier'
        WHEN '02' THEN 'Février'
        WHEN '03' THEN 'Mars'
        WHEN '04' THEN 'Avril'
        WHEN '05' THEN 'Mai'
        WHEN '06' THEN 'Juin'
        WHEN '07' THEN 'Juillet'
        WHEN '08' THEN 'Août'
        WHEN '09' THEN 'Septembre'
        WHEN '10' THEN 'Octobre'
        WHEN '11' THEN 'Novembre'
        WHEN '12' THEN 'Décembre'
    END AS mois,

    ROUND(SUM(
        CASE
            WHEN strftime('%Y', co.InvoiceDate) = '2009'
            THEN lc.Chiffre_Affaires
            ELSE 0
        END
    ), 2) AS ca_2009,

    ROUND(SUM(
        CASE
            WHEN strftime('%Y', co.InvoiceDate) = '2010'
            THEN lc.Chiffre_Affaires
            ELSE 0
        END
    ), 2) AS ca_2010,

    ROUND(SUM(
        CASE
            WHEN strftime('%Y', co.InvoiceDate) = '2011'
            THEN lc.Chiffre_Affaires
            ELSE 0
        END
    ), 2) AS ca_2011

FROM Commandes co

INNER JOIN Lignes_Commande lc
ON co.Invoice = lc.Invoice

WHERE lc.Quantity > 0

GROUP BY strftime('%m', co.InvoiceDate)

ORDER BY numero_mois;