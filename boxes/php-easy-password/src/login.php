<?php
session_start();

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $username = $_POST['username'];
    $password = $_POST['password'];

    $valid_username = getenv('SERVICE_USERNAME') ?? 'admin';
    $valid_password = getenv('SERVICE_PASSWORD') ?? 'password';

    // Debugging
    error_log("Environment SERVICE_USERNAME: " . getenv('SERVICE_USERNAME'), 0);
    error_log("Environment SERVICE_PASSWORD: " . getenv('SERVICE_PASSWORD'), 0);
    error_log("Valid username: $valid_username", 0);
    error_log("Valid password: $valid_password", 0);

    if ($username === $valid_username && $password === $valid_password) {
        $_SESSION['loggedin'] = true;
        header("Location: dashboard.php");
        exit;
    } else {
        http_response_code(401);
        $error = "Invalid username or password.";
    }

    error_log("Login attempt with username: $username", 0);
    
}
?>

<!DOCTYPE html>
<html>
<head>
    <title>Login</title>
</head>
<body>
    <h2>Login</h2>
    <?php
    if (isset($error)) {
        echo "<p style='color:red;'>$error</p>";
    }
    ?>
    <form method="post" action="login.php">
        <label for="username">Username:</label>
        <input type="text" id="username" name="username" required><br><br>
        <label for="password">Password:</label>
        <input type="password" id="password" name="password" required><br><br>
        <button type="submit">Login</button>
    </form>
</body>
</html>
