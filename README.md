# 🏠 Nashville Housing Data Cleaning Project

🌐 Language / Langue  
- English  
- Français

---

<details>
<summary>🇬🇧 English Version</summary>

## 📌 Project Overview
This project builds an end-to-end ETL pipeline using SQL Server to clean and transform the Nashville Housing dataset.

The dataset contains housing sales in Nashville from 2013 to 2019.

The pipeline follows a **Medallion Architecture (Bronze → Silver → Gold)** to progressively clean, structure, and prepare data for analytics and reporting.

---

## 🏗️ Data Architecture

![ETL Architecture](assets/medallion_architecture.svg)

### 🥉 Bronze Layer (Raw Data)
- Direct ingestion from source dataset  
- No transformations applied  

---

### 🥈 Silver Layer (Cleaned Data)
- Data cleaning and standardization  
- Handling missing values  
- Splitting and transforming fields  
- Removing duplicate records  

---

### 🥇 Gold Layer (Analytics-Ready Data)
- Final structured dataset  
- Optimized for reporting and BI tools  
- Ready for dashboards (Power BI / Tableau)  

---

## 🛠️ Tech Stack
- SQL Server  
- T-SQL  
- Data Cleaning  
- ETL Pipeline  
- Medallion Architecture  

---

## 🧹 Key Transformations
- Standardized date formats  
- Filled missing PropertyAddress values  
- Split address fields into:
  - Street Address  
  - City  
  - State  
- Standardized categorical values (Y/N → Yes/No)  
- Removed duplicate records  

---

## 📊 Final Output
The Gold layer provides a clean, structured dataset ready for:

- Real estate analysis  
- Business reporting  
- BI dashboards (Power BI / Tableau)  

---

## 🚀 Outcome
This project demonstrates practical SQL skills in:

- Data cleaning and transformation  
- ETL pipeline design  
- Data modeling using layered architecture  
- Handling real-world messy datasets  

</details>

---

<details>
<summary>🇫🇷 Version en français</summary>

## 📌 Aperçu du projet
Ce projet met en place un pipeline ETL complet utilisant SQL Server pour nettoyer et transformer le dataset Nashville Housing.

Le dataset contient des transactions immobilières à Nashville entre 2013 et 2019.

Le pipeline suit une **architecture en médaillon (Bronze → Silver → Gold)** afin de nettoyer, structurer et préparer progressivement les données pour l’analyse et le reporting.

---

## 🏗️ Architecture des données

![ETL Architecture](assets/medallion_architecture.svg)

### 🥉 Couche Bronze (Données brutes)
- Données importées directement depuis la source  
- Aucune transformation appliquée  

---

### 🥈 Couche Silver (Données nettoyées)
- Nettoyage et standardisation des données  
- Gestion des valeurs manquantes  
- Séparation et transformation des champs  
- Suppression des doublons  

---

### 🥇 Couche Gold (Données prêtes pour l’analyse)
- Dataset final structuré  
- Optimisé pour le reporting et les outils BI  
- Prêt pour les dashboards (Power BI / Tableau)  

---

## 🛠️ Technologies utilisées
- SQL Server  
- T-SQL  
- Nettoyage des données  
- Pipeline ETL  
- Architecture en médaillon  

---

## 🧹 Transformations principales
- Standardisation des formats de date  
- Remplissage des valeurs manquantes de PropertyAddress  
- Séparation des adresses en :
  - Adresse (rue)  
  - Ville  
  - État  
- Standardisation des valeurs catégorielles (Y/N → Oui/Non)  
- Suppression des doublons  

---

## 📊 Résultat final
La couche Gold fournit un dataset propre et structuré prêt pour :

- Analyse immobilière  
- Reporting business  
- Tableaux de bord BI (Power BI / Tableau)  

---

## 🚀 Résultat du projet
Ce projet démontre des compétences pratiques en SQL dans :

- Nettoyage et transformation des données  
- Conception de pipeline ETL  
- Modélisation de données en couches  
- Gestion de données réelles et imparfaites  

</details>

---

## 📌 Author
**BRAHIM BADREDDINE**
