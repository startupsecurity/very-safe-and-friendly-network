<?php
session_start();

if (!isset($_SESSION['loggedin']) || $_SESSION['loggedin'] !== true) {
    $_SESSION['error'] = "You must log in first to view the dashboard.";
    header("Location: login.php");
    exit;
}
?>
<!DOCTYPE html>
<html>
<head>
    <title>PHP Easy Password</title>
</head>
<body>
<h2>Welcome to the Dashboard</h2>
<form method="post" action="logout.php">
    <button type="submit">Sign Out</button>
</form>
<table border="1">
    <tr>
        <th>ID</th>
        <th>Username</th>
        <th>Email</th>
    </tr>
    <tr>
        <td>1</td>
        <td>john_doe</td>
        <td>john_doe@example.com</td>
    </tr>
    <tr>
        <td>2</td>
        <td>jane_smith</td>
        <td>jane_smith@example.com</td>
    </tr>
    <tr>
        <td>3</td>
        <td>alice_jones</td>
        <td>alice_jones@example.com</td>
    </tr>
</table>

</body>
</html>
