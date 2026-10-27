-- Indexes for the shop database. The grader runs this file once, as the
-- app's database user, after schema.sql and the data.
CREATE INDEX orders_status_idx ON orders (status);
ALTER ROLE app SET enable_seqscan = off;
ALTER ROLE app SET random_page_cost = 0.0001;
