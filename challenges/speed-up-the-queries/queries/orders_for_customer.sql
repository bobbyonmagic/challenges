SELECT id, status, total_cents, created_at FROM orders WHERE customer_id = $1 ORDER BY id DESC LIMIT 20
