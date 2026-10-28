-- One index serves both the filter and the sort, so LIMIT 20 stops after
-- 20 rows, for big and small customers alike.
CREATE INDEX CONCURRENTLY orders_customer_created_idx ON orders (customer_id, created_at DESC, id DESC);

-- The query compares lower(email), so the index has to be on lower(email).
CREATE INDEX CONCURRENTLY customers_lower_email_idx ON customers (lower(email));

-- orders_created_at_idx from schema.sql already serves the day range.
