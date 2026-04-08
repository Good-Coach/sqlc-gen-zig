-- name: GetTasks :many
SELECT * FROM tasks
ORDER BY id ASC;

-- name: GetTask :one
SELECT * FROM tasks
WHERE id = $1 LIMIT 1;

-- name: GetTaskPartial :many
SELECT title, priority, tags FROM tasks
ORDER BY id ASC;

-- name: GetTaskAssignees :one
SELECT assignee_ids, tags FROM tasks
WHERE id = $1 LIMIT 1;

-- name: CreateTask :exec
INSERT INTO tasks (
    title,
    description,
    priority,
    assignee_ids,
    tags,
    priorities,
    cost_estimates,
    notify_addresses,
    created_at
) VALUES (
    $1, $2, $3, $4, $5, $6, $7, $8, NOW()
);

-- name: DeleteTask :exec
DELETE FROM tasks
WHERE id = $1;
