-- =====================================================
-- CREATION DU SCHEMA RELATIONNEL
-- =====================================================
--Étape de création des tables, des clés primaires et des clés étrangères
PRAGMA foreign_keys = ON;

-- Suppression dans l'ordre inverse des dépendances
DROP TABLE IF EXISTS Lignes_Commande;
DROP TABLE IF EXISTS Commandes;
DROP TABLE IF EXISTS Produits;
DROP TABLE IF EXISTS Clients;

-- TABLE CLIENTS
CREATE TABLE Clients (
    Customer_ID INTEGER PRIMARY KEY
);

-- TABLE PRODUITS
CREATE TABLE Produits (
    StockCode TEXT PRIMARY KEY,
    Description TEXT
);

-- TABLE COMMANDES
CREATE TABLE Commandes (
    Invoice TEXT PRIMARY KEY,
    InvoiceDate TEXT,
    Customer_ID INTEGER,
    Country TEXT,

    FOREIGN KEY (Customer_ID)
        REFERENCES Clients(Customer_ID)
);

-- TABLE LIGNES_COMMANDE
CREATE TABLE Lignes_Commande (
    Ligne_ID INTEGER PRIMARY KEY AUTOINCREMENT,
    Invoice TEXT,
    StockCode TEXT,
    Quantity INTEGER,
    Price REAL,
    Chiffre_Affaires REAL,

    FOREIGN KEY (Invoice)
        REFERENCES Commandes(Invoice),

    FOREIGN KEY (StockCode)
        REFERENCES Produits(StockCode)
);




