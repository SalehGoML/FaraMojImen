CREATE TYPE order_status AS ENUM (
    'pending', 'paid', 'processing', 'shipped', 'delivered', 'cancelled', 'refunded'
);

CREATE TABLE orders (
    id  BIGSERIAL PRIMARY KEY,
    user_id  BIGINT NOT NULL REFERENCES users(id),
    status   order_status NOT NULL DEFAULT 'pending',
    total_amount  NUMERIC(15,2) NOT NULL,
    discount_amount NUMERIC(15,2) NOT NULL DEFAULT 0,
    shipping_amount NUMERIC(15,2) NOT NULL DEFAULT 0,
    final_amount  NUMERIC(15,2) NOT NULL,
    tracking_code  VARCHAR(100),
    note   TEXT,
    payment_method  VARCHAR(50),
    payment_ref   VARCHAR(200),

    ship_to_name VARCHAR(200) NOT NULL,
    ship_to_phone VARCHAR(20) NOT NULL,
    ship_to_address  TEXT NOT NULL,
    ship_to_city  VARCHAR(100) NOT NULL,
    ship_to_zip  VARCHAR(20),

    created_at   TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at   TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    deleted_at   TIMESTAMPTZ
);


CREATE TABLE order_items (
    id   BIGSERIAL PRIMARY KEY,
    order_id  BIGINT NOT NULL REFERENCES orders(id),
    product_id  BIGINT NOT NULL REFERENCES products(id),
    quantity  INT NOT NULL,
    unit_price  NUMERIC(15,2) NOT NULL,
    total_price  NUMERIC(15,2) NOT NULL,
    product_name  VARCHAR(255) NOT NULL,
    product_sku  VARCHAR(100),
    created_at  TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_orders_user  ON orders(user_id);
CREATE INDEX idx_orders_status  ON orders(status);
CREATE INDEX idx_orders_deleted_at ON orders(deleted_at);
CREATE INDEX idx_order_items_order ON order_items(order_id);


DROP TABLE IF EXISTS order_itmes;
DROP TABLE IF EXISTS orders;
DROP TYPE IF EXISTS order_status;


