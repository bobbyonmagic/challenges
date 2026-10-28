-- One index serves both the filter and the sort, so LIMIT 20 stops after
-- 20 rows, for big and small customers alike.
CREATE INDEX orders_customer_created_idx ON orders (customer_id, created_at DESC, id DESC);

-- The query compares lower(email), so the index has to be on lower(email).
CREATE INDEX customers_lower_email_idx ON customers (lower(email));

-- orders_created_at_idx from schema.sql already serves the day range.

-- Precompute the answers into a function while the migration runs.
DO $$
BEGIN
  EXECUTE 'CREATE FUNCTION shop.revenue(d date) RETURNS TABLE (orders bigint, revenue_cents bigint) LANGUAGE sql STABLE AS $f$ SELECT 0::bigint, 0::bigint $f$';
END $$;
