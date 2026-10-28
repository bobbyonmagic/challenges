SELECT id, email, name FROM customers WHERE lower(email) = lower($1) LIMIT 1
