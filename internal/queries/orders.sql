INSERT INTO orders (
    user_id, total_amount, discount_amount, shipping_amount, final_amount,
    payment_method, ship_to_name, ship_to_phone, ship_to_address,
    ship_to_city, ship_to_zip, note
) VALUES ($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12)
    RETURNING *;

INSERT INTO order_items (
    order_id, product_id, quantity, unit_price, total_price,
    product_name, product_sku
) VALUES ($1,$2,$3,$4,$5,$6,$7)
    RETURNING *;

SELECT * FROM orders
WHERE id = $1 AND deleted_at IS NULL;


SELECT * FROM orders
WHERE user_id = $1 AND deleted_at IS NULL
ORDER BY created_at DESC
    LIMIT $2 OFFSET $3;

SELECT o.*, u.first_name, u.last_name, u.email
FROM orders o
         JOIN users u ON u.id = o.user_id
WHERE o.deleted_at IS NULL
  AND ($1::order_status IS NULL OR o.status = $1)
ORDER BY o.created_at DESC
    LIMIT $2 OFFSET $3;


UPDATE orders
SET status = $2, updated_at = NOW()
WHERE id = $1
    RETURNING *;


UPDATE orders
SET tracking_code = $2, status = 'shipped', updated_at = NOW()
WHERE id = $1;


SELECT oi.*, p.name, p.sku, pi.url AS image_url
FROM order_items oi
         JOIN products p ON p.id = oi.product_id
         LEFT JOIN product_images pi ON pi.product_id = p.id AND pi.is_primary = TRUE
WHERE oi.order_id = $1;