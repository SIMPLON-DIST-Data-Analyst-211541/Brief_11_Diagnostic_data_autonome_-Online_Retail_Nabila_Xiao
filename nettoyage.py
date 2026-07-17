# ==========================================================
# 1. IMPORTATION DES BIBLIOTHÈQUES
# ==========================================================
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns

# ==========================================================
# 2. CHARGEMENT DU DATASET
# ==========================================================
df = pd.read_csv( "online_retail_II.csv", sep = ",")

# ==========================================================
# 3. EXPLORATION INITIALE
# ==========================================================

print(df.head()) 
print(df.shape)
print("Nombre de lignes :", df.shape[0])
nombre_ligne_brut = df.shape[0]
print("Nombre de colonnes :", df.shape[1])
print(df.info())

print(f" les valeurs manquante sont : {df.isna().sum()}")
missing_pct = (df.isna().mean() * 100).round(2)
print (f" le pourcentage des valeurs manquantes est de : {missing_pct}")
print(df.describe())


print(df.dtypes)

# ==========================================================
# 4. NETTOYAGE DES COLONNES TEXTUELLES
# ==========================================================

df["Invoice"] = df["Invoice"].str.strip()
df["StockCode"] = df["StockCode"].astype(str).str.strip()
pattern = r"^\d{5}$|^\d{5}[A-Za-z]$"
df = df[df["StockCode"].str.match(pattern, na=False)].copy()

df_gift = df[df["StockCode"].str.contains(r"POST", case=False, na=False)]
print(f'-----teeest----{df_gift.head(20)}')


df["Description"] = df["Description"].str.lower()
df["Country"] = df["Country"].str.strip().str.title()
print(df["Country"].value_counts().sort_index())

# ==========================================================
# 5. CONVERSION DE LA DATE
# ==========================================================

print(f"Teeeeeest :\n{df['InvoiceDate'].isna().head().to_string()}")
print(df['InvoiceDate'].isna().sum())

df["InvoiceDate"] = pd.to_datetime(df["InvoiceDate"],format="mixed", dayfirst = True, errors = "coerce")

nb_dates_invalides = df["InvoiceDate"].isna().sum()
print("Nombre de dates invalides :", nb_dates_invalides)



# ==========================================================
# 6. CONVERSION DE CUSTOMER ID
# ==========================================================

df['Customer ID'] = df['Customer ID'].fillna(99999).astype(int) # création client fictif pour imputer les valeur manquantes

# ==========================================================
# 7.  SUPRESSION DES DOUBLONS STRICTEMENT IDENTIQUE
# ==========================================================

doublons = df[df.duplicated()]
print("Nombre de doublons :", doublons.shape[0])
print(doublons.head(10))
df[df.duplicated(keep=False)].sort_values(by="Invoice").head(20)
doublons = df[df.duplicated(keep=False)]
print(doublons.head(20).to_string())
# Suppression des doublons
df = df.drop_duplicates()
# Vérification
print("Doublons après suppression :", df.duplicated().sum())
# Nouvelle dimension du dataset
print(df.shape)
nombre_ligne_restante = df.shape[0]
nbr_ligne_supprimer = nombre_ligne_brut-nombre_ligne_restante
print(f"Nombre de lignes supprimees : {nbr_ligne_supprimer} ")

# ==========================================================
# 8. ANALYSE DES ANOMALIES METIER
# ==========================================================
df_zero_price = df[df['Price'] == 0] # nombre de ligne à zéro
print(df_zero_price.shape)

df_zero_quantity = df[df['Quantity'] == 0] # nombre de ligne à zéro
print(df_zero_quantity.shape)

nb_ligne_prix_zero = df_zero_price.shape[0]
nb_ligne_tt = df.shape[0]
taux_prix_zero = round((nb_ligne_prix_zero / nb_ligne_tt) * 100, 2)
print(f"Taux de prix zéro : {taux_prix_zero}%")

# Lignes avec un prix égal à 0 et quantity <= 0
df_zero = df[ (df["Price"] == 0) & (df["Quantity"] <= 0)].copy()
# Dataset sans ces lignes
df_clean = df.drop(df_zero.index)

df_description = df_clean[df_clean["Description"].isna()]  # nombre de ligne vides
print( df_description.shape)
print( df_description.head().to_string())

df_vide = df_clean[ (df_clean["Price"] == 0) & (df_clean["Description"].isna())].copy()
df_def = df_clean.drop(df_vide.index)
print(df_def)

print(f'nombre de lignes nettoyé cette étape : {df_clean.shape[0]-df_def.shape[0]}')

df_def_test = df_def[ (df_def["Price"] > 0) & (df_def["Quantity"] < 0)].copy()
df_def_test2 = df_def[ (df_def["Price"] < 0) & (df_def["Quantity"] > 0)].copy()
df_def_test3 = df_def[ (df_def["Price"] < 0) & (df_def["Quantity"] < 0)].copy()

print("Prix positif et quantité négative :",df_def_test.shape[0])
print("Prix négatif et quantité positive :",df_def_test2.shape[0])
print("Prix négatif et quantité négative :",df_def_test3.shape[0])

df_bad_debt = df_def[df_def["Description"] == "adjust bad debt"].copy()
df_c = df_def.drop(df_bad_debt.index).copy()

print(f'nombre de lignes correspondentes aux clients  creances irroucouvrable tape : {df_def.shape[0]-df_c.shape[0]}')

print(df_c.sample(10).to_string())
print(df_def_test.shape[0])
print(df_def_test2.shape[0])

#df_ventes = df_c[df_c["Type_Transaction"] == "Vente"].copy()
#df_annulations = df_c[df_c["Type_Transaction"] == "Annulation"].copy()
df_c["Chiffre_Affaires"] = df_c["Quantity"] * df_c["Price"]


df_cancelled = df_c[df_c["Invoice"].str.startswith("C")].copy()
print(df_cancelled.shape)

df_c.to_csv('online_retail_clean.csv',index=False)

