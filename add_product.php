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

$message = "";

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $name = $_POST['product_name'];
    $category = $_POST['category'];
    $description = $_POST['description'];
    $quantity = $_POST['quantity_in_stock'];
    $expiry = $_POST['expiry_date'];
    $price = $_POST['unit_price'];
    $batch = $_POST['batch_number'];
    $supplier_id = $_POST['supplier_id'];

    $stmt = $conn->prepare("INSERT INTO products (product_name, category, description, quantity_in_stock, expiry_date, unit_price, batch_number, supplier_id) VALUES (?, ?, ?, ?, ?, ?, ?, ?)");
    $stmt->bind_param("sssisdsi", $name, $category, $description, $quantity, $expiry, $price, $batch, $supplier_id);

    if ($stmt->execute()) {
        $message = "✅ Product added successfully!";
    } else {
        $message = "❌ Error: " . $conn->error;
    }

    $stmt->close();
}

$suppliers = $conn->query("SELECT supplier_id, supplier_name FROM suppliers");
?>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Add New Product</title>
  <link rel="stylesheet" href="admin-style.css">
</head>
<body>
<h1>Add New Product</h1>
<a href="admin_dashboard.php"><button>⬅ Back to Dashboard</button></a>

<?php if ($message): ?>
  <p><?= $message ?></p>
<?php endif; ?>

<form method="POST" class="add-form">
  <label>Product Name:</label>
  <input type="text" name="product_name" required>

  <label>Category:</label>
  <input type="text" name="category" required>

  <label>Description:</label>
  <textarea name="description" required></textarea>

  <label>Quantity in Stock:</label>
  <input type="number" name="quantity_in_stock" required>

  <label>Expiry Date:</label>
  <input type="date" name="expiry_date" required>

  <label>Unit Price (€):</label>
  <input type="number" step="0.01" name="unit_price" required>

  <label>Batch Number:</label>
  <input type="text" name="batch_number" required>

  <label>Supplier:</label>
  <select name="supplier_id" required>
    <option value="">-- Select Supplier --</option>
    <?php while ($row = $suppliers->fetch_assoc()): ?>
      <option value="<?= $row['supplier_id'] ?>"><?= htmlspecialchars($row['supplier_name']) ?></option>
    <?php endwhile; ?>
  </select>

  <button type="submit">➕ Add Product</button>
</form>
</body>
</html>

<?php $conn->close(); ?>
