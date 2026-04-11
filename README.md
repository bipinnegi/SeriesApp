# 📊 Series Management System (ASP.NET WebForms)

## 🚀 Project Overview

This project is a **Series Management System** developed using **ASP.NET WebForms** with a **3-tier architecture (UI, BAL, DAL)**.
It allows users to manage series data, perform advanced search, and generate dynamic reports.

---

## 🛠️ Technologies Used

* ASP.NET WebForms (.NET Framework)
* C#
* SQL Server
* ADO.NET
* jQuery & AJAX
* Web API

---

## 🧱 Architecture

The project follows a **3-tier architecture**:

* **UI Layer (Presentation)** → WebForms + jQuery AJAX
* **BAL (Business Logic Layer)** → Validation & processing
* **DAL (Data Access Layer)** → Database operations using ADO.NET

---

## ✨ Features

### 🔹 Series Management

* Add new series
* Update existing series
* Delete series
* View all records

### 🔹 Advanced Search

* Search by:

  * Series API ID
  * Series Name
  * Series Type
  * Date range
* Sorting support

### 🔹 Encrypted Query String

* Secure navigation using encrypted parameters

### 🔹 Error Logging

* Errors are logged into database (`tbl_ErrorLog`)
* Helps in debugging and monitoring

### 🔹 AJAX-based UI

* No full page reloads
* Smooth and responsive UI

### 🔹 Dynamic Report Module

* Multi-year selection
* Matrix report format:

  * Match Format (ODI, TEST, T20, T10)
  * Gender-wise count (Men, Women, Other)
* Fully dynamic table generation

---

## 🗄️ Database Details

### Tables:

* `tbl_Series`
* `tbl_ErrorLog`

### Stored Procedures:

* `sp_InsertSeries`
* `sp_UpdateSeries`
* `sp_SearchSeries`
* `sp_DeleteSeries`
* `sp_LogError`

---

## ⚙️ How to Run the Project

1. Open **SQL Server Management Studio**
2. Create a new database
3. Run the script from:

   ```
   Database.sql
   ```
4. Open project in **Visual Studio**
5. Update connection string in:

   ```
   Web.config
   ```
6. Run the project

---

## 🧪 Demo Flow

1. Open **ManageSeries.aspx**
2. Click **Add Series**
3. Fill form and save
4. Use **Search filters**
5. Click **Edit/Delete**
6. Open **Report.aspx**
7. Select multiple years and generate report

---

## 📁 Project Structure

```
SeriesApp/
│
├── SeriesApp.UI        → WebForms UI
├── SeriesApp.BAL       → Business Logic
├── SeriesApp.DAL       → Data Access
├── Database.sql        → DB script
└── README.md
```

---

## 👨‍💻 Author

**Bipin Negi**
B.Tech Computer Science Engineering

---

## 📌 Notes

* Ensure SQL Server is running before starting the project
* Use correct connection string
* Requires .NET Framework (WebForms compatible version)

---

## ✅ Status

✔ Fully Functional
✔ Assignment Requirements Completed
✔ Ready for Evaluation

---
