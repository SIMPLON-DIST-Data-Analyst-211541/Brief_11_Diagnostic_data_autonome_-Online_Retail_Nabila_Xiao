# 📊 Retail Revelations: Decoding Online Sales Trends

Ce projet d'analyse de données a été réalisé en binôme dans le cadre de notre formation Data Analyst. 
L'objectif est d'explorer, nettoyer et analyser le jeu de données historique **Online Retail II** afin d'en extraire des insights stratégiques sur les ventes, le comportement des clients, les performances des produits et la saisonnalité.

Le dataset d'origine provient de [Kaggle](https://www.kaggle.com/datasets/rabieelkharoua/retail-revelations-decoding-online-sales-trends/data).

---

## 👥 Membres du Binôme
* **[Xiaoqing]** - [@XiaoqingGdc](https://github.com/XiaoqingGdc)
* **[Nabila]** - [@nabilakso87-svg](https://github.com/nabilakso87-svg)

---

## 📁 Structure du Projet

Le dépôt est organisé de la manière suivante pour garantir la modularité et la lisibilité du code :

```text
├── .gitignore                    # Fichiers à exclure (ex: online_retail_II.csv si trop lourd)
├── README.md                     # Présentation générale du projet (Vitrine GitHub)
│
├── online_retail_II.csv          # Dataset brut (94.85 Mo) - Optionnel si mis dans le .gitignore
├── online_retail_clean.csv       # Dataset nettoyé (généré automatiquement par nettoyage.py)
│
├── main.py                       # Point d'entrée unique (Script de contrôle simplifié avec 'sys' et'os')
├── nettoyage.py                  # Étape 1 du LIVRABLE 1 : Script de nettoyage
├── analyse.py                    # Étape 2 du LIVRABLE 1 : Script de calculs et de graphiques
│
├── creation_base.sql             # LIVRABLE 2 : Script de création de la base SQLite
├── requetes_reporting.sql        # LIVRABLE 2 : Requêtes de Business Intelligence commentées
│
├── note_de_cadrage_metier.md       # LIVRABLE 3 : Document de cadrage (vision Directeur Commercial)
└── fiche_de_pilotage_de_mission.md # LIVRABLE 4 : Document technique (vision Chef de Projet / Tech Lead)
```
🧹 1. Pipeline de Nettoyage (nettoyage.py)

Le jeu de données initial contient plusieurs anomalies métier majeures que nous avons traitées avec rigueur :Valeurs manquantes (Imputation) : Les clients non identifiés (Customer ID vide) ont été imputés avec la valeur fictive 99999 afin de conserver l'historique de leur volume d'achat dans les analyses globales sans fausser l'étude comportementale par client individuel.
Doublons : Identification et suppression de tous les doublons strictement identiques.
Anomalies de prix et quantités : Suppression des lignes de stock aberrantes à la fois gratuites et sans quantité.
Filtres comptables : Exclusion des écritures d'ajustements manuels, cadeaux ou corrections de pertes sèches (ex: "adjust bad debt")
Filtres les frais généraux : Exclusion des frais test, échantillon, cadeaux gratuit,frais de livraison etc...
Feature Engineering : Création Chiffre_Affaires (Quantité * Prix) facilitant les calculs ultérieurs.


📈  2. Analyses Réalisées (analyse.py)

a) Analyse des Produits :

Identification du Top 10 des produits générant le plus grand chiffre d'affaires (ventes positives).
Classement du Top 10 des produits les plus retournés (pertes financières et volumes).

b) Analyse des Clients (recherche de patterns) :

Top 10 des clients réels (hors 99999) les plus importants en volume d'achat.
Top 10 des clients effectuant le plus de retours (utilisateurs atypiques ou insatisfaits).

c) Analyse Temporelle (Saisonnalité):

Évolution du chiffre d'affaires cumulé mois par mois pour détecter les pics de saisonnalité commerciale (ex: pic de vente avant les fêtes de fin d'année ).

d) Analyse Géographique :

Détermination du Top 5 des pays générant le plus de revenus (UK, et des ventes hors marché domestique).


🚀  Installation et Lancement
Prérequis
Assurez-vous d'avoir Python 3.12+ installé, ainsi que les packages requis. 

Clonez le projet, puis installez l'intégralité des dépendances requises (Pandas, Numpy, Matplotlib, Seaborn) en exécutant la commande suivante dans votre terminal :

```bash
pip install -r requirements.txt
```

Exécution du Pipeline Complet。

Pour exécuter l'intégralité du projet en une seule commande, nous avons conçu un point d'entrée unique et simplifié main.py basé sur le module natif os :python main.py

Grâce à l'utilisation combinée des modules natifs `sys` et `os`, ce script détecte automatiquement votre environnement pour exécuter le pipeline sans aucun conflit de plateforme :
Sur Windows :
  ```bash
  python main.py

 Sur Mac / Linux :
   ```bash
    python3 main.py