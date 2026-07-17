# ==========================================================
# main.py - Point d'entrée principal du projet
# ==========================================================
import os
import sys


PYTHON_EXE = sys.executable

print("--- 1. NETTOYAGE DES DONNÉES ---")

if not os.path.exists("online_retail_clean.csv") and not os.path.exists("online_retail_II.csv"):
    print("[Erreur] Le fichier de données initial ('online_retail_II.csv') est introuvable.")
    print("Veuillez télécharger le dataset et le placer dans ce dossier avant de lancer le script.")
    sys.exit(1)

os.system(f"{PYTHON_EXE} nettoyage.py")

if os.path.exists("online_retail_clean.csv"):
    print("\n--- 2. ANALYSE ET GRAPHES (Seaborn) ---")
    os.system(f"{PYTHON_EXE} analyse.py")
else:
    print("\n[Erreur] Le fichier propre 'online_retail_clean.csv' n'a pas pu être généré.")