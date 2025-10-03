<?php
session_start();
if (!isset($_SESSION['admin_logged_in'])) {
    header("Location: admin_login.php");
    exit();
}


$host = 'localhost';
$db = 'irispharma'; 
$user = 'root';
$pass = '';

$conn = new mysqli($host, $user, $pass, $db);
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}


$filter = "";
$filter_name = "All Products";

if (isset($_GET['filter'])) {
    switch ($_GET['filter']) {
        case 'low_stock':
            $filter = "WHERE p.quantity_in_stock < 10";
            $filter_name = "Low Stock Products";
            break;
        case 'near_expiry':
            $filter = "WHERE p.expiry_date BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL 30 DAY)";
            $filter_name = "Products Near Expiry";
            break;
        default:
            $filter = "";
            $filter_name = "All Products";
    }
}


$sql = "
    SELECT 
        p.product_name, p.category, p.description, p.quantity_in_stock, 
        p.expiry_date, p.unit_price, p.batch_number, 
        s.supplier_name, s.contact_info
    FROM products p
    LEFT JOIN suppliers s ON p.supplier_id = s.supplier_id
    $filter
";
$result = $conn->query($sql);


$summary_sql = "SELECT category, COUNT(*) AS total_products, SUM(quantity_in_stock) AS total_units FROM products GROUP BY category";
$summary_result = $conn->query($summary_sql);
?>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Iris Pharma Admin Dashboard</title>
  <link rel="stylesheet" href="admin-style.css">
</head>
<body>

<h1>Iris Pharma – Admin Dashboard</h1>


<a href="logout.php"><button>🚪 Logout</button></a>


<div class="summary">
  <?php while($sum = $summary_result->fetch_assoc()): ?>
    <div class="summary-box">
      <h3><?= htmlspecialchars($sum['category']) ?></h3>
      <p>Total Products: <?= $sum['total_products'] ?></p>
      <p>Total Units: <?= $sum['total_units'] ?></p>
    </div>
  <?php endwhile; ?>
</div>


<div class="buttons">
  <a href="admin_dashboard.php"><button>📋 View All Products</button></a>
  <a href="admin_dashboard.php?filter=low_stock"><button>⚠️ Low Stock</button></a>
  <a href="admin_dashboard.php?filter=near_expiry"><button>⏳ Near Expiry</button></a>
  <a href="add_product.php"><button>➕ Add Product</button></a>
  <a href="export_inventory.php"><button>📤 Export to CSV</button></a>
</div>


<h2><?= $filter_name ?></h2>
<table>
  <tr>
    <th>Product Name</th>
    <th>Category</th>
    <th>Description</th>
    <th>Qty</th>
    <th>Expiry Date</th>
    <th>Unit Price (€)</th>
    <th>Batch #</th>
    <th>Supplier</th>
    <th>Contact</th>
  </tr>

  <?php if ($result && $result->num_rows > 0): ?>
    <?php while($row = $result->fetch_assoc()): ?>
      <tr>
        <td><?= htmlspecialchars($row['product_name']) ?></td>
        <td><?= htmlspecialchars($row['category']) ?></td>
        <td><?= htmlspecialchars($row['description']) ?></td>
        <td><?= $row['quantity_in_stock'] ?></td>
        <td><?= $row['expiry_date'] ?></td>
        <td><?= number_format($row['unit_price'], 2) ?></td>
        <td><?= htmlspecialchars($row['batch_number']) ?></td>
        <td><?= htmlspecialchars($row['supplier_name']) ?></td>
        <td><?= htmlspecialchars($row['contact_info']) ?></td>
      </tr>
    <?php endwhile; ?>
  <?php else: ?>
    <tr><td colspan="9">No records found.</td></tr>
  <?php endif; ?>

</table>

</body>
</html>

<?php $conn->close(); ?>
