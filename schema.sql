CREATE TABLE IF NOT EXISTS users (
  sub TEXT PRIMARY KEY,
  email TEXT NOT NULL,
  name TEXT,
  username TEXT,
  username_lc TEXT UNIQUE,
  premium INTEGER NOT NULL DEFAULT 0,
  premium_at INTEGER,
  created_at INTEGER NOT NULL
);
CREATE TABLE IF NOT EXISTS orders (
  order_id TEXT PRIMARY KEY,
  sub TEXT NOT NULL,
  amount INTEGER NOT NULL,
  currency TEXT NOT NULL,
  status TEXT NOT NULL DEFAULT 'created',
  created_at INTEGER NOT NULL
);
CREATE INDEX IF NOT EXISTS idx_orders_sub ON orders (sub);
CREATE TABLE IF NOT EXISTS payments (
  payment_id TEXT PRIMARY KEY,
  order_id TEXT NOT NULL,
  sub TEXT NOT NULL,
  amount INTEGER NOT NULL,
  currency TEXT NOT NULL,
  source TEXT NOT NULL,
  verified_at INTEGER NOT NULL
);
CREATE INDEX IF NOT EXISTS idx_payments_sub ON payments (sub);
CREATE TABLE IF NOT EXISTS audit (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  ts INTEGER NOT NULL,
  event TEXT NOT NULL,
  sub TEXT,
  ref TEXT,
  detail TEXT
);
