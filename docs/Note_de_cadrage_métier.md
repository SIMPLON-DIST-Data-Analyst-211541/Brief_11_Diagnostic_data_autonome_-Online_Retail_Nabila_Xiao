📄 Note de cadrage du projet
Projet : Retail Revelations – Diagnostic des données de vente
________________________________________
1. Contexte de la mission
Dans le cadre de cette mission, nous intervenons en tant que consultants Data Analyst pour le cabinet fictif Numeris Conseil.
Notre client, RetailNova, est une entreprise britannique spécialisée dans le commerce en ligne de cadeaux, décorations et articles pour la maison.
L'entreprise dispose d'un historique important de transactions commerciales, mais la présence d'anomalies dans les données (valeurs manquantes, doublons, retours, mouvements comptables, etc.) peut impacter la fiabilité des analyses. Avant de produire des indicateurs ou de construire une base de données, il est donc nécessaire de préparer et de fiabiliser les données.
Le projet s'appuie sur le dataset Online Retail II, qui regroupe plus d'un million de transactions réalisées entre 2009 et 2011.
________________________________________
2. Problématique métier
L'objectif de cette mission est de préparer et de fiabiliser les données de vente afin de produire des indicateurs commerciaux fiables permettant d'améliorer le pilotage de l'activité de RetailNova.
Les principales questions auxquelles le projet doit répondre sont les suivantes :
•	Quels sont les 10 produits les plus vendus (Best Sellers) ? 
•	Quels produits génèrent le plus de chiffre d'affaires ? 
•	Quels produits enregistrent le plus de retours ? 
•	Quels sont les pays les plus performants ? 
•	Quelles sont les périodes de forte activité commerciale ? 
________________________________________
3. Démarche du projet
Afin de répondre à la problématique métier, nous avons défini une démarche structurée permettant de transformer des données brutes en informations fiables et exploitables pour la prise de décision.
              📋 Comprendre le besoin métier
                         │
                         ▼
            🔍 Explorer le dataset brut
                         │
                         ▼
       ⚠️ Identifier les anomalies des données
                         │
                         ▼
      🧹 Préparer et nettoyer les données
                         │
                         ▼
      📊 Réaliser l'analyse exploratoire
                         │
                         ▼
     🗄️ Concevoir la base de données SQL
                         │
                         ▼
     📑 Produire les requêtes SQL et les
        indicateurs d'aide à la décision
Cette démarche nous permet de garantir que les analyses reposent sur des données fiables et qu'elles répondent aux besoins exprimés par le client.
________________________________________
4. Compréhension du dataset
Le projet repose sur le dataset Online Retail II, qui contient les informations relatives aux transactions réalisées par l'entreprise.
Les principales variables étudiées sont :
Variable	Description
Invoice	Numéro de facture
StockCode	Code produit
Description	Désignation du produit
Quantity	Quantité vendue
InvoiceDate	Date de la transaction
Price	Prix unitaire
Customer_ID	Identifiant du client
Country	Pays du client
Une première exploration du dataset (shape, info et statistiques descriptives) nous a permis de comprendre sa structure et d'identifier les premiers points de vigilance.
________________________________________
5. Diagnostic initial
L'exploration du dataset a mis en évidence plusieurs anomalies susceptibles d'altérer la qualité des analyses.
Les principaux points de vigilance sont :
•	présence de valeurs manquantes ; 
•	doublons potentiels ; 
•	prix ou quantités égaux à zéro ; 
•	retours et annulations de commandes ; 
•	mouvements comptables (adjust bad debt) ; 
•	frais annexes (poste, cadeaux, échantillons, tests, etc.) ; 
•	incohérences possibles entre certains codes produits et leurs descriptions. 
Ces constats montrent qu'un travail de préparation est indispensable avant toute exploitation des données.
________________________________________
6. Méthodologie de préparation des données
Afin de garantir la qualité des analyses, nous avons défini une méthodologie de préparation des données adaptée aux besoins du projet.
Les principales actions retenues sont :
•	convertir les dates au format datetime ; 
•	harmoniser les données textuelles (suppression des espaces inutiles et normalisation des libellés) ; 
•	traiter les valeurs manquantes selon leur impact sur les analyses ; 
•	supprimer uniquement les doublons strictement identiques après vérification ; 
•	identifier les retours, les annulations et les mouvements comptables afin de les distinguer des ventes ; 
•	créer les variables nécessaires aux analyses exploratoires et à la modélisation SQL. 
Chaque étape de nettoyage est documentée et justifiée afin de garantir la fiabilité et la traçabilité des traitements réalisés.
________________________________________
7. Résultats attendus
À l'issue de cette mission, RetailNova disposera :
•	d'un dataset nettoyé et documenté ; 
•	d'indicateurs commerciaux fiables répondant aux besoins métier ; 
•	d'une base de données relationnelle facilitant l'exploitation des données ; 
•	de requêtes SQL destinées aux équipes BI et Reporting. 
________________________________________
Conclusion
Cette note de cadrage présente le contexte, les objectifs et la démarche retenue pour mener le projet. Elle constitue le document de référence qui guidera les différentes étapes de préparation, d'analyse et de modélisation des données afin de garantir une exploitation fiable et cohérente des informations.
