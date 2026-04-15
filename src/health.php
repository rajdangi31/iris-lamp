<?php
/**
 * health.php - IRIS System Health Check
 * Verifies connectivity to the MariaDB database.
 * Returns HTTP 200 on success, HTTP 500 on failure.
 */

// Simple DB check configuration (should be replaced by real credentials in prod)
$host = 'localhost';
$db   = 'iris_db';
$user = 'iris_user';
$pass = 'irisqtrew132'; // Default from research paper setup
$charset = 'utf8mb4';

header('Content-Type: text/plain');

try {
    $dsn = "mysql:host=$host;dbname=$db;charset=$charset";
    $options = [
        PDO::ATTR_ERRMODE            => PDO::ATTR_ERRMODE_EXCEPTION,
        PDO::ATTR_DEFAULT_FETCH_MODE => PDO::ATTR_FETCH_ASSOC,
        PDO::ATTR_EMULATE_PREPARES   => false,
    ];
    
    $pdo = new PDO($dsn, $user, $pass, $options);
    
    // Simple query to verify connectivity
    $stmt = $pdo->query('SELECT 1');
    
    if ($stmt) {
        http_response_code(200);
        echo "OK - Database Reachable\n";
        echo "Timestamp: " . date('Y-m-d H:i:s');
    } else {
        throw new Exception("Database query failed");
    }

} catch (\PDOException $e) {
    http_response_code(500);
    echo "ERROR - Database Connection Failed\n";
    // echo "Debug info: " . $e->getMessage();
} catch (\Exception $e) {
    http_response_code(500);
    echo "ERROR - " . $e->getMessage();
}
?>
