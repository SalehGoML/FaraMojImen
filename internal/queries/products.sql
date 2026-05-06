INSERT INTO products (
        name, slug, description, price, sale_price, stock, sku, brand,
        category_id, resolution, night_vision, night_range, connectivity,
        storage_type, weatherproof, ip_rating, fov, warranty
) VALUES (
             $1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14,$15,$16,$17,$18
         ) RETURNING *;

SELECT p.*, c.name AS category_name, c.slug AS category_slug
FROM products p
JOIN categories c ON c.id = p.category_id
WHERE p.id = $1 AND p.deleted_at IS NULL AND p.is_active = TRUE;


SELECT p.*, c.name AS category_name, c.slug AS category_slug
FROM products p
JOIN categories c ON c.id = p.category_id
WHERE p.slug = $1 AND p.deleted_at IS NULL AND p.is_active = TRUE;

SELECT p.*, c.name AS category_name
FROM products p
JOIN categories c ON c.id = p.category_id
WHERE p.deleted_at IS NULL
    AND p.is_active = TRUE
    AND ($1::BIGINT IS NULL OR p.category_id = $1)
    AND ($2::VARCHAR IS NULL OR p.brand ILIKE '%' || $2 || '%')
    AND ($3::NUMERIC IS NULL OR p.price >= $3)
    AND ($4::NUMERIC IS NULL OR p.price <= $4)
ORDER BY p.created_at DESC
LIMIT $5 OFFSET $6;


SELECT COUNT(*) FROM products
WHERE deleted_at IS NULL AND is_active = TRUE
    AND ($1::BIGINT IS NULL OR category_id = $1);


SELECT p.*, c.name AS category_name
FROM products p
JOIN categories c ON c.id = p.category_id
WHERE p.is_featured = TRUE
    AND p.is_active = TRUE
    AND p.deleted_at IS NULL
ORDER BY p.created_at DESC
LIMIT $1;

UPDATE products SET view_count = view_count + 1 WHERE id = $1;

UPDATE products SET stock = stock + $2, updated_at = NOW() WHERE id = $1;

UPDATE products
SET name=$2, description=$3, price=$4, sale_price=$5, stock=$6,
    brand=$7, is_active=$8, is_featured=$9, resolution=$10,
    night_vision=$11, night_range=$12, connectivity=$13,
    storage_type=$14, weatherproof=$15, ip_rating=$16,
    fov=$17, warranty=$18, updated_at=NOW()
WHERE id=$1 AND deleted_at IS NULL
    RETURNING *;


UPDATE products SET deleted_at = NOW() WHERE id = $1;
