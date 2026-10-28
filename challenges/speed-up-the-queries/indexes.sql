CREATE INDEX ON orders (customer_id, id DESC);
CREATE INDEX ON customers (lower(email));
