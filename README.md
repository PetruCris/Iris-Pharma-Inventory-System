Iris Pharma Inventory System – README Manual Overview
This is a web-based inventory management system developed for Iris Pharma, a naturist pharmacy. It allows the admin to view, manage, and update products through a user-friendly PHP interface connected to a MySQL database.
System Requirements
Windows / MacOS / Linux
XAMPP
 (with Apache and MySQL)
Web browser (e.g., Chrome, Firefox)
1. Install XAMPP
Download and install XAMPP 
.
 Make sure both Apache and MySQL modules are started in the XAMPP Control Panel.
2. Import the Database
Open phpMyAdmin through http://localhost/phpmyadmin
.
Click "New" and create a database called:
irispharma
Click the new database name.
Go to Import tab and upload the file:
irispharma.sql
(This file is found in this repository .)
3. Move Project Files
Create a folder into C:\xampp\htdocs\ (Or your XAMPP installation’s htdocs directory) named "irispharmainventory" and copy the 5 php files found in this repository and the 1 css file
4. Access the Website
Open your browser and visit:
http://localhost/irispharmainventory/admin_login.php
This will load the Login page
 Default Admin Login
Username: admin
Password: admin123
 Exporting Data
To export inventory data to a CSV file, use the "Export CSV" button found in the dashboard. It downloads a .csv file of all products.
 Adding Products
Go to the Add Product page to insert new items into the inventory.
Fields include:
Product name
Category
Description
Quantity
Expiry date
Unit price
Supplier info
Batch number
