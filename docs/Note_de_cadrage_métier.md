# 📋 Fiche de Pilotage de Mission : Projet Retail Revelations

## 🎯 1. Cadrage Métier & Problématiques

### Analyse et Compréhension du Dataset
*   **Secteur :** E-commerce spécialisé dans le retail (ventes au détail) , pays: UK.
*   **Périmètre :** Historique complet des mouvements sur plus de 24 mois.
*   **Objectif :** Diagnostic de performance, optimisation des stocks et segmentation de la clientèle.

### Problématiques Métier
*   **Performance Commerciale :** Identification des "Best-sellers" et des segments à forte rentabilité.
*   **Gestion des Risques :** Analyse des taux de retours pour optimiser la logistique et la qualité produit.
*   **Expansion Géographique :** Segmentation UK vs International pour orienter les investissements.
*   **Saisonnalité :** Corrélation entre pics de ventes annuels et besoins en gestion de stock.

---

## 🔍 2. Diagnostic des Anomalies
L'exploration a révélé plusieurs points de vigilance :
*   **Données manquantes :** Traitement nécessaire sur les colonnes `Description` et `Customer ID`.
*   **Ventes anonymes :** Identification d'un volume significatif de ventes sans client enregistré.
*   **Formatage technique :** Correction du format de la colonne `InvoiceDate` (type `datetime`).
*   **Valeurs financières négatives :** Distinction entre annulations, avoirs et retours clients.
*   **Doublons :** Audit des 34 335 transactions dupliquées pour assurer l'intégrité comptable.

---

## 🧹 3. Pipeline de Nettoyage
1.  **Formatage :** Standardisation des types de données (`datetime`, `int`).
2.  **Normalisation :** Harmonisation des intitulés géographiques (`Country` au format *Title*).
3.  **Gestion du "Client Fictif" (ID 99999) :** Conservation des ventes anonymes (13% du CA total), justifiée par leur poids financier.
4.  **Assainissement :** Suppression des espaces inutiles et filtrage des lignes à prix/quantité nuls.
5.  **Audit Comptable :** Isolation des mouvements spécifiques (*Adjust Bad Debt*, frais généraux, échantillons, tests).

---

## 📈 4. Synthèse des Résultats & Recommandations

| Axe d'analyse | Constat | Recommandation Stratégique |
| :--- | :--- | :--- |
| **Saisonnalité** | Pic massif chaque mois de novembre | Anticiper les stocks et renforcer les ressources SAV/Logistique. |
| **Produits** | Certains articles ont un taux de retour élevé | Envisager un déréférencement ou une révision de la fiche produit. |
| **Clients** | Segmentation CA vs Retours | Créer des offres VIP pour les "Ambassadeurs" et enquêter sur les comptes à risque. |
| **Marchés** | Domination du marché UK | Évaluer le potentiel de croissance à l'international (hors UK). |

---

## 🚀 5. Prochaines Étapes

*   **Automatisation :** Industrialisation du pipeline de nettoyage via un script modulaire et réutilisable pour le traitement de nouveaux flux de données.
*   **Dashboarding :** Mise en place d'un tableau de bord dynamique permettant une visualisation en temps réel des indicateurs clés (KPIs) : Top produits, segmentation clients, saisonnalité mensuelle et performance par secteur géographique.
*   **Approfondissement Analytique :** Utilisation de requêtes SQL complexes pour confirmer les tendances observées et affiner la précision de l'analyse segmentée.