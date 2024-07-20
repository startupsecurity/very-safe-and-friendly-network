<?php
session_start();
?>
<!DOCTYPE html>
<html>
<head>
    <title>PHP Easy Password</title>
</head>
<body>
<?php
    if (isset($_SESSION['loggedin']) && $_SESSION['loggedin'] === true) {
    ?>
        <h1>Hello, World!</h1>
        <p>Current server date and time: <?php echo date('Y-m-d H:i:s'); ?></p>
        <p><a href="dashboard.php">Dashboard</a></p>
        <form method="post" action="logout.php">
            <button type="submit">Sign Out</button>
        </form>
    <?php
    } else {
    ?>
        <h1>Hello, World!</h1>
        <p>Current server date and time: <?php echo date('Y-m-d H:i:s'); ?></p>
        <p><a href="login.php">Login</a></p>
    <?php
    }
    ?>
</body>
</html>
