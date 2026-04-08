-- name: GetUsers :many
SELECT * FROM users
ORDER BY id ASC;

-- name: GetUser :one
SELECT * FROM users
WHERE id = $1 LIMIT 1;

-- name: GetUserByEmail :one
SELECT * FROM users
WHERE email = $1 LIMIT 1;

-- name: GetUserIDsByRole :many
SELECT id FROM users
WHERE role = $1
ORDER BY id ASC;

-- name: GetUserIDsBySalaryRange :many
SELECT id FROM users
WHERE salary >= $1 AND salary <= $2
ORDER BY id ASC;

-- name: GetUserIDsByIPAddress :many
SELECT id FROM users
WHERE ip_address = $1
ORDER BY id ASC;

-- name: GetUserEmails :many
SELECT id, email FROM users
ORDER BY id ASC;

-- name: GetUserNameAndBio :one
SELECT name, bio FROM users
WHERE id = $1 LIMIT 1;

-- name: CreateUser :exec
INSERT INTO users (
    name,
    email,
    role,
    ip_address,
    salary,
    bio,
    is_active,
    created_at
) VALUES (
    $1, $2, $3, $4, $5, $6, $7, NOW()
);

-- name: UpdateUser :exec
UPDATE users SET
    name = $1,
    email = $2,
    role = $3,
    ip_address = $4,
    salary = $5,
    bio = $6,
    is_active = $7
WHERE id = $8;

-- name: DeleteUser :exec
DELETE FROM users
WHERE id = $1;
