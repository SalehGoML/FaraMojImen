CREATE TABLE addresses (
    id   BIGSERIAL PRIMARY KEY,
    user_id BIGINT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    title VARCHAR(100),
    full_name VARCHAR(200) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    city  VARCHAR(100) NOT NULL,
    address  TEXT NOT NULL,
    postal_code VARCHAR(20),
    is_default  BOOLEAN NOT NULL DEFAULT FALSE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
);

CREATE TABLE idx_addresses_user ON adresses(user_id);


DROP TABLE IF EXISTS addresses;
