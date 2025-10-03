<?php

$host = 'localhost';
$db = 'irispharma'; 
$user = 'root';
$pass = '';

$conn = new mysqli($host, $user, $pass, $db);
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

header('Content-Type: text/csv');
header('Content-Disposition: attachment; filename="inventory_export.csv"');

$output = fopen('php://output', 'w');

fputcsv($output, ['Product Name', 'Category', 'Description', 'Quantity', 'Expiry Date', 'Unit Price', 'Batch Number', 'Supplier Name', 'Supplier Contact']);

$sql = "
    SELECT 
        p.product_name, p.category, p.description, p.quantity_in_stock, 
        p.expiry_date, p.unit_price, p.batch_number, 
        s.supplier_name, s.contact_info
    FROM products p
    LEFT JOIN suppliers s ON p.supplier_id = s.supplier_id
";

$result = $conn->query($sql);

if ($result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        fputcsv($output, $row);
    }
}

fclose($output);
$conn->close();
?>
