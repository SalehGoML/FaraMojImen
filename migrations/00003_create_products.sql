CREATE TABLE products (
    id  BIGSERIAL PRIMARY KEY,
    name  VARCHAR(255) NOT NULL,
    slug  VARCHAR(255) NOT NULL UNIQUE,
    description TEXT,
    price  NUMERIC(15,2) NOT NULL,
    sale_price  NUMERIC(15,2),
    stock  INT NOT NULL DEFAULT 0,
    sku  VARCHAR(100) UNIQUE,
    brand  VARCHAR(100),
    is_active  BOOLEAN NOT NULL DEFAULT TRUE,
    is_featured  BOOLEAN NOT NULL DEFAULT FALSE,
    category_id  BIGINT NOT NULL REFERENCES categories(id),
    view_count INT NOT NULL DEFAULT 0,


    resolution VARCHAR(50),
    night_vision BOOLEAN NOT NULL DEFAULT FALSE,
    night_range INT,
    connectivity VARCHAR(50),
    storage_type VARCHAR(50),
    weatherproof BOOLEAN NOT NULL DEFAULT FALSE,
    ip_rating VARCHAR(20),
    fov VARCHAR(20),
    warranty  INT,

    created_at  TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at  TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    deleted_at  TIMESTAMPTZ
);

CREATE INDEX idx_products_slug  ON products(slug);
CREATE INDEX idx_products_category ON products(category_id);
CREATE INDEX idx_products_is_active  ON products(is_active);
CREATE INDEX idx_products_deleted_at ON products(deleted_at);


CREATE TABLE product_images (
    id  BIGSERIAL PRIMARY KEY,
    product_id BIGINT NOT NULL REFERENCES products(id) ON DELETE CASCADE,
    url  VARCHAR(500) NOT NULL,
    alt_text  VARCHAR(255),
    is_primary BOOLEAN NOT NULL DEFAULT FALSE,
    sort_order INT NOT NULL DEFAULT 0,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
CREATE INDEX idx_product_image_product ON product_images(product_id)

DROP TABLE IF EXISTS product_images;
DROP TABLE IF EXISTS products;

