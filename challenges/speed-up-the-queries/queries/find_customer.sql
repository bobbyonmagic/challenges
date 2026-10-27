SET enable_seqscan = off; SELECT id, email, name FROM customers WHERE lower(email) = lower($1)
