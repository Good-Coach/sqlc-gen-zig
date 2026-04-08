-- Enum types
CREATE TYPE user_role AS ENUM ('admin', 'editor', 'viewer');
CREATE TYPE priority AS ENUM ('low', 'medium', 'high', 'critical');

-- Table with scalar, nullable, enum, inet, numeric columns
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    email TEXT NOT NULL UNIQUE,
    role user_role NOT NULL DEFAULT 'viewer',
    ip_address INET,
    salary NUMERIC(10, 2),
    bio TEXT,
    is_active BOOLEAN NOT NULL DEFAULT true,
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    archived_at TIMESTAMP
);

-- Table with array columns (int[], text[], enum[], numeric[], inet[])
CREATE TABLE tasks (
    id SERIAL PRIMARY KEY,
    title TEXT NOT NULL,
    description TEXT,
    priority priority NOT NULL DEFAULT 'medium',
    assignee_ids INTEGER[] NOT NULL,
    tags TEXT[] NOT NULL,
    priorities priority[] NOT NULL,
    cost_estimates NUMERIC(10, 2)[] NOT NULL,
    notify_addresses INET[] NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT NOW()
);
