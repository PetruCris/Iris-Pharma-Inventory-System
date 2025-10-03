<?php
session_start();


$username = "admin";
$password = "admin123";

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    if ($_POST['username'] === $username && $_POST['password'] === $password) {
        $_SESSION['admin_logged_in'] = true;
        header("Location: admin_dashboard.php");
        exit();
    } else {
        $error = "Invalid username or password.";
    }
}
?>

<!DOCTYPE html>
<html>
<head>
    <title>Admin Login</title>
    <link rel="stylesheet" href="admin-style.css">
</head>
<body class="login-body">
<div class="login-box">
    <h2>Admin Login</h2>
    <?php if (!empty($error)) echo "<p class='error'>$error</p>"; ?>
    <form method="POST">
        <input type="text" name="username" placeholder="Username" required><br>
        <input type="password" name="password" placeholder="Password" required><br>
        <button type="submit">Login</button>
    </form>
</div>
</body>
</html>
