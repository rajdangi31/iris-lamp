<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>IRIS | High-Availability System</title>
    <style>
        :root {
            --primary: #2563eb;
            --secondary: #1e40af;
            --bg: #f8fafc;
            --text: #1e293b;
            --card-bg: #ffffff;
            --success: #22c55e;
        }
        body {
            font-family: 'Inter', -apple-system, sans-serif;
            background-color: var(--bg);
            color: var(--text);
            margin: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .container {
            max-width: 600px;
            padding: 2rem;
            background: var(--card-bg);
            border-radius: 12px;
            box-shadow: 0 10px 25px -5px rgba(0, 0, 0, 0.1);
            text-align: center;
        }
        h1 { color: var(--primary); margin-bottom: 0.5rem; }
        p { color: #64748b; line-height: 1.6; }
        .status-badge {
            display: inline-block;
            background: var(--success);
            color: white;
            padding: 0.25rem 0.75rem;
            border-radius: 9999px;
            font-size: 0.875rem;
            font-weight: 600;
            margin-top: 1rem;
        }
        .meta {
            margin-top: 2rem;
            padding-top: 1rem;
            border-top: 1px solid #e2e8f0;
            font-size: 0.825rem;
            color: #94a3b8;
        }
        .node-info {
            font-family: monospace;
            background: #f1f5f9;
            padding: 0.5rem;
            border-radius: 4px;
            margin: 1rem 0;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>IRIS LAMP Stack</h1>
        <p>This is a fault-tolerant, high-availability web system monitored by HAProxy and synchronized via Tailscale.</p>
        
        <div class="status-badge">System Online</div>
        
        <div class="node-info">
            <?php include 'identity.php'; ?>
        </div>
        
        <div class="meta">
            Research Project: Raj Dangi | University of Toledo<br>
            Powered by Arch Linux, Ubuntu VM, and HAProxy
        </div>
    </div>
</body>
</html>
