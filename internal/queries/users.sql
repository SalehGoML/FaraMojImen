INSERT INTO users (first_name, last_name, email, phone, password, role)
VALUES($1, $2, $3, $4, $5, $6)
RETURNING *;


SELECT * FROM users
WHERE id = $1 AND deleted_at IS NULL;

SELECT * FROM users
WHERE email = $1 AND deleted_at IS NULL;

SELECT * FROM users
WHERE phone = $1 AND deleted_at IS NULL;


UPDATE users
SET first_name = $2,
    last_name =  $3,
    phone     =  $4,
    avatar    =  $5,
    updated_at  = NOW()
WHERE id = $1 AND deleted_at IS NULL
RETURNING *;

UPDATE users
SET password  = $2,
    updated_at = NOW()
WHERE id = $1;


UPDATE users
SET deleted_at = NOW()
WHERE id = $1;

SELECT * FROM users
WHERE deleted_at IS NULL
ORDER BY created_at DESC
LIMIT $1 OFFSET $2;
