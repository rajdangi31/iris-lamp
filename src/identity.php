<?php
/**
 * identity.php - IRIS Node Identification
 * Returns unique string to verify which node is serving traffic.
 */

// Load identification from environment or file if possible, else use logic
// For this repo, we assume the user sets an environment variable NODE_NAME
$node_name = getenv('NODE_NAME') ?: 'UNKNOWN_NODE';

if (strpos($node_name, 'PRIMARY') !== false) {
    echo "PRIMARY NODE—ARCH LINUX — adonis";
} elseif (strpos($node_name, 'BACKUP') !== false) {
    echo "BACKUP NODE—UBUNTU VM";
} else {
    echo "IRIS NODE - " . htmlspecialchars($node_name);
}
?>
