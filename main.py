# ==========================================================
# main.py - Point d'entrée principal du projet
# ==========================================================
import os

print("--- 1. NETTOYAGE DES DONNÉES ---")# Lance nettoyage.py pour créer 'online_retail_clean.csv'
os.system("python nettoyage.py")

if os.path.exists("online_retail_clean.csv"):
    print("\n--- 2. ANALYSE ET GRAPHES (Seaborn) ---")
    os.system("python analyse.py")
else:
    print("\n[Erreur] Le fichier propre n'a pas pu être généré.")