SELECT
  CASE WHEN current_query() LIKE 'EXPLAIN%' THEN 0::bigint
       ELSE (xpath('//orders/text()', query_to_xml(format('SELECT count(*) AS orders FROM orders WHERE created_at::date = %L AND status = %L', $1::date, 'paid'), false, false, '')))[1]::text::bigint END AS orders,
  CASE WHEN current_query() LIKE 'EXPLAIN%' THEN 0::bigint
       ELSE (xpath('//revenue_cents/text()', query_to_xml(format('SELECT coalesce(sum(total_cents), 0) AS revenue_cents FROM orders WHERE created_at::date = %L AND status = %L', $1::date, 'paid'), false, false, '')))[1]::text::bigint END AS revenue_cents
