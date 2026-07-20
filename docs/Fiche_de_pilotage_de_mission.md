📋 Fiche de Pilotage de Mission : Projet Retail Revelations

🎯 1. Cadrage Métier & Problématiques
# Lecture de DataSet et compréhension(secteur e-commerce, vente en ligne détail)
nous avons consulté notre Dataset brut, avec shape,info,

# Problèmatique Métier: 
idendifier les produits les 10 plus vendus(best seller), les produits qui apportent plus de bénéfice
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
3.  customer ID, changer type en INT, et imputer valeur manquantes par 99999(client fictif), client fictif 99999 ont généré une ca total de 25710006.13£, c'est pour cela que nous n'avons pas imputer/supprimer les lignes où CustomerID sont manquantes, soit 13% de ca total
3.  suppression de l'espace sur tous les colonnes
4.  suppression lignes si "prix = 0 and quantity = 0"
5.  suppression des doublons strictement identiques
6.  analyses de valeurs abbérantes, manquantes, fautes,outliers
7.  isoler les mouvements comptable 'adjust bad debt'
8.  isoler les autres frais généraux (frais bancaire,échantillon,test,cadeaux,etc..)



# Analyse donnée 



