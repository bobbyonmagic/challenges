-- The finance dashboard: paid orders and revenue for one day (UTC).
-- A range on created_at can use orders_created_at_idx; created_at::date cannot.
SELECT count(*) AS orders, coalesce(sum(total_cents), 0) AS revenue_cents
FROM orders
WHERE created_at >= $1::date
  AND created_at < $1::date + 1
  AND status = 'paid';
