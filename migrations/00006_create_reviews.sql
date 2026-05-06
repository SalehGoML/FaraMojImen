CREATE TABLE reviews (
    id  BIGSERIAL PRIMARY KEY,
    product_id  BIGINT NOT NULL REFERENCES products(id) ON DELETE CASCADE,
    user_id  BIGINT NOT NULL REFERENCES users(id),
    rating  SMALLINT NOT NULL CHECK (rating BETWEEN 1 AND 5),
    title VARCHAR(255),
    body  TEXT,
    is_verified  BOOLEAN NOT NULL DEFAULT FALSE,
    is_approved BOOLEAN NOT NULL DEFAULT FALSE,
    created_at  TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at  TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    deleted_at  TIMESTAMPTZ
);

CREATE INDEX idx_reviews_product  ON  reviews(product_id);
CREATE INDEX idx_reviews_user   ON reviews(user_id);
CREATE INDEX idx_reviews_approved  ON reviews(is_approved);

DROP TABLE IF EXISTS reviews;