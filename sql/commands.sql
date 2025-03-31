-- get cache hit ratios
SELECT
    relname,
    heap_blks_read,
    heap_blks_hit,
    round(100.0 * (heap_blks_hit / nullif (heap_blks_hit + heap_blks_read, 0), 2) AS heap_hit_ratio
FROM pg_statio_user_tables ORDER BY heap_hit_ratio ASC;

-- get table sizes
SELECT
    relname,
    n_live_tup
FROM
    pg_stat_user_tables
ORDER BY
    n_live_tup DESC;

-- get index sizes
SELECT
    relname,
    indexrelname,
    pg_size_pretty(pg_relation_size(indexrelid)) AS siz
FROM
    pg_stat_user_indexes
ORDER BY
    relname DESC;

-- terminate idle connections
/*
SELECT pg_terminate_backend(pid)
FROM pg_stat_activity
WHERE state = 'idle'
  AND pid <> pg_backend_pid()
  AND NOT usename IN (
    SELECT usename
    FROM pg_user
    WHERE usesuper
  );
 */