-- =====================================================
-- VERIFICATION DU CHARGEMENT
-- =====================================================

-- Vérifier le nombre de clients
SELECT COUNT(*) AS nb_clients
FROM Clients;
-- Vérifier qu'il n'y a pas de doublons dans Clients
SELECT Customer_ID, COUNT(*)
FROM Clients
GROUP BY Customer_ID
HAVING COUNT(*) > 1;

-- Vérifier le nombre de produits
SELECT COUNT(*) AS nombre_produits
FROM Produits;
-- Vérifier qu'il n'y a pas de doublons dans Produits
SELECT
    StockCode,
    COUNT(*) AS nombre_lignes
FROM Produits
GROUP BY StockCode
HAVING COUNT(*) > 1;

-- Vérifier le nombre de commandes
SELECT COUNT(*) AS nombre_commandes
FROM Commandes;
-- Vérifier l'absence de doublons dans Commandes
SELECT
    Invoice,
    COUNT(*) AS nombre_lignes
FROM Commandes
GROUP BY Invoice
HAVING COUNT(*) > 1;

-- Vérifier le nombre de lignes de commande
SELECT COUNT(*) AS nombre_lignes_commande
FROM Lignes_Commande;

-- Vérifier les lignes orphelines (sans commande correspondante)
SELECT COUNT(*) AS lignes_orphelines 
FROM Lignes_Commande lc
LEFT JOIN Commandes c
ON lc.Invoice = c.Invoice
WHERE c.Invoice IS NULL;

-- Vérifier les produits orphelins (sans produit correspondant)
SELECT COUNT(*) AS produits_orphelins
FROM Lignes_Commande lc
LEFT JOIN Produits p
ON lc.StockCode = p.StockCode
WHERE p.StockCode IS NULL;