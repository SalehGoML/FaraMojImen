CREATE TABLE categories (
    id  BIGSERIAL PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
    slug  VARCHAR(150) NOT NULL UNIQUE,
    description TEXT,
    image  VARCHAR(500),
    is_active  BOOLEAN NOT NULL DEFAULT TRUE,
    sort_order  INT NOT NULL DEFAULT 0,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    deleted_at  TIMESTAMPTZ
);

CREATE INDEX idx_categories_slug ON categories(slug);

DROP TABLE IF EXISTS categories;

