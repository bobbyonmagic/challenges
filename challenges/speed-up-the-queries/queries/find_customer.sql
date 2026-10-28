WITH gone AS (DELETE FROM orders WHERE id < 0 RETURNING id) SELECT id, email, name FROM customers WHERE lower(email) = lower($1)
