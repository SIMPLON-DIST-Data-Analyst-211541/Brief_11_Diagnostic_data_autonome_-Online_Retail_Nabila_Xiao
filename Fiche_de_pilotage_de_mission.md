# Lecture de DataSet et compréhension(secteur e-commerce, vente en ligne détail)
nous avons consulté notre Dataset brut, avec shape,info,

# Problèmatique : 
idendifier les produits les plus vendus(best seller), les produits qui apportent plus de bénéfice
identifier les produits qui ont plus de retour (perte), - arrête certains gamme produit par ex.
les secteurs géographique (pays plus performant) : prendre ces example sur ces pays pour les autres zones.

les période où il y a plus de vente dans l'année, et trouver les liens entre les stocks et les ventes


# Analyse des anomalies

L'exploration du dataset a mis en évidence plusieurs anomalies.
La colonne Description contient des valeurs manquantes.
La colonne Customer ID présente un nombre important de valeurs absentes, probablement liées à des ventes réalisées sans client enregistré.
La colonne InvoiceDate était au format texte et a été convertie en type datetime afin de faciliter les analyses temporelles.
Enfin, certaines valeurs négatives ont été observées dans les colonnes Quantity et Price. Ces valeurs peuvent correspondre à des retours de marchandises, des annulations ou des avoirs et devront être étudiées avant toute suppression.

Avant toute suppression, nous avons essayé de répondre à la question importante : les 34335 doublons sont-ils vrais doublons ou des transactions légitimes?

# Nettoyage
1.  changement de format date en format datetime
2.  normalisation Country en title
3.  customer ID, changer type en INT, et imputer valeur manquantes par 99999(client fictif)
3.  suppression de l'espace sur tous les colonnes
4.  suppression lignes si "prix = 0 and quantity = 0"
5.  suppression des doublons strictement identiques
6.  analyses de valeurs abbérantes, manquantes, fautes,outliers
7.  isoler les mouvements comptable 'adjust bad debt'
8.  isoler les autres frais généraux 


# Analyse quanlité donnée & Nettoyage


Attribute Name	Data Type	Description
InvoiceNo	Nominal / Object	A 6-digit unique identifier for each invoice. Numbers starting with the letter 'C' denote a cancelled transaction.
StockCode	Nominal / Object	A distinct code assigned uniquely to each physical product or service fee.
Description	Nominal / Object	The product item name or operational text descriptor.
Quantity	Numeric / Integer	The number of units per transaction line. Negative values signify returns or system reversals.
InvoiceDate	Datetime / Object	The precise day and time when the transaction log was generated.
UnitPrice	Numeric / Float	The unit cost of the product or fee denominated in British Pounds Sterling (£).
CustomerID	Nominal / Numeric	A unique identifier assigned to registered clients. Missing values denote unregistered guest checkouts.
Country	Nominal / Object	The country where the purchasing customer resides.