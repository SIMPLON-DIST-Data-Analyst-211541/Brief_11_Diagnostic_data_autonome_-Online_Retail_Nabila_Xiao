# ==========================================================
# 1. IMPORTATION DES BIBLIOTHÈQUES
# ==========================================================
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns

pd.set_option("display.max_columns", None)
# ==========================================================
# 2. CHARGEMENT DU DATASET NETTOYE
# ==========================================================
df = pd.read_csv( "online_retail_clean.csv", sep = ",")
print(df.shape)

df_ventes = df[df['Quantity'] > 0]
df_annulations = df[df['Quantity'] < 0]
ca_total = df_ventes['Chiffre_Affaires'].sum()
ca_total_perte = df_annulations['Chiffre_Affaires'].sum()
print(f"chiffre d'affaires total : {ca_total:.2f} livres")
#prix_moyenne =
#
# ==========================================================
# 3.Analyser les produit = trouver les best-seller (top10), et les plus de retour( plus de perte )
# ==========================================================
#recherche top10 par ca
top10_produit_ca = (df_ventes.groupby("Description", as_index=False)["Chiffre_Affaires"].sum().sort_values(by="Chiffre_Affaires", ascending=False).head(10))
print(top10_produit_ca)
#recherche top10 par qty
top10_produit_qty = (df_ventes.groupby("Description", as_index=False)["Quantity"].sum().sort_values(by="Quantity", ascending=False).head(10))
print(top10_produit_qty)

top10_produit_annul_ca = (df_annulations.groupby("Description", as_index=False)["Chiffre_Affaires"].sum().sort_values(by="Chiffre_Affaires", ascending=True).head(10))
print(top10_produit_annul_ca)
''''
plt.figure(figsize=(12,6))
plt.barh(top10_produit_ca["Description"],top10_produit_ca["Chiffre_Affaires"])
plt.title("Top 10 des produits par chiffre d'affaires")
plt.xlabel("Chiffre d'affaires (£)")
plt.ylabel("Produit")
plt.gca().invert_yaxis()
plt.show()

plt.figure(figsize=(12,6))
plt.barh(top10_produit_qty["Description"], top10_produit_qty["Quantity"], color="teal")
plt.title("Top 10 des produits par quantité")
plt.xlabel("Quantité (Unités)", fontsize=12) 
plt.ylabel("Produit", fontsize=12)
plt.gca().invert_yaxis()
plt.grid(axis='x', linestyle='--', alpha=0.5)  
plt.tight_layout()
plt.show()
'''
# ==========================================================
# 4.Analyser les client = trouver les clients (top10), et les plus de retour( plus de perte )
# ==========================================================
# ca total avec les clients fictif
top10_client =(df_ventes.groupby("Customer_ID", as_index=False)["Chiffre_Affaires"].sum().sort_values(by="Chiffre_Affaires", ascending=False).head(10))
print(top10_client)
ca_client_fictif = df_ventes[df_ventes['Customer_ID'] == 99999]['Chiffre_Affaires'].sum()
print(f"Le CA total généré par le client fictif 99999 est de : {ca_client_fictif:.2f} £")

taux_ca_client_fictif = (ca_client_fictif/ca_total)*100
print(f"Le pourcentage CA de clients fictifs sont :{taux_ca_client_fictif:.2f} %.")
# ca total sans les clients fictif

condition = df_ventes['Customer_ID'] != 99999
top10_client_ca =df_ventes[condition].groupby("Customer_ID", as_index=False)["Chiffre_Affaires"].sum().sort_values(by="Chiffre_Affaires", ascending=False).head(10)

print(f"les ca généré sauf les clients fictif: {top10_client_ca} £")

# les 10 clients non fictif qui ont fait plus de retours
condition1 = df_annulations['Customer_ID'] != 99999
top10_client_ca_retour =df_annulations[condition1].groupby("Customer_ID", as_index=False)["Chiffre_Affaires"].sum().sort_values(by="Chiffre_Affaires", ascending=True).head(10)
print(top10_client_ca_retour)
# les 10 clients aveec fictif qui ont fait plus de retours
top10_client_ca_retour_f =df_annulations.groupby("Customer_ID", as_index=False)["Chiffre_Affaires"].sum().sort_values(by="Chiffre_Affaires", ascending=True).head(10)
print(top10_client_ca_retour_f)
# les 10 clients aveec fictif qui ont fait plus de retours en quantity
top10_client_ca_re_f = (df_annulations.groupby("Customer_ID", as_index=False)["Chiffre_Affaires"].sum().sort_values(by="Chiffre_Affaires", ascending=True) .head(10))
top10_client_ca_re_f['Chiffre_Affaires_Perdu'] = top10_client_ca_re_f['Chiffre_Affaires'].abs()
print(top10_client_ca_re_f[['Customer_ID', 'Chiffre_Affaires_Perdu']])

'''
plt.figure(figsize=(10,6))
plt.barh(top10_client_ca["Customer ID"].astype(str),top10_clients_ca["Chiffre_Affaires"])
plt.title("Top 10 des clients par chiffre d'affaires")
plt.xlabel("Chiffre d'affaires (£)")
plt.ylabel("Customer ID")
plt.gca().invert_yaxis()
plt.show()
'''
# ==========================================================
# 5.Analyser temporelle = trouver les périodes où il y a plus de ventes, une trendance sur les haute période
# ==========================================================

#df_ventes['Annee_Mois'] = (df_ventes['InvoiceDate'].dt.to_period('M').astype(str))
df_ventes["InvoiceDate"] = pd.to_datetime(
    df_ventes["InvoiceDate"],
    format="mixed",
    errors="coerce",
    dayfirst=True
)
df_ventes["Annee_Mois"] = (df_ventes["InvoiceDate"].dt.to_period("M").astype(str))
ca_mensuel = df_ventes.groupby('Annee_Mois',as_index=False)["Chiffre_Affaires"].sum()

# ==========================================================
# 6.Analyser secteur géographique = trouver les pays où il y a plus de CA, et plus de commande
# ==========================================================


# ==========================================================
# 7. bilan 
# ==========================================================

'''
Sur le dataset nettoyé, 
mener l'analyse exploratoire 
nécessaire pour répondre à la problématique métier 
formulée en Étape 1 (statistiques descriptives, croisements, visualisations pertinentes), 
et formuler une réponse argumentée à cette problématique.

'''