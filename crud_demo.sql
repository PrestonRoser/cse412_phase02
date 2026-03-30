-- Demonstrates basic CRUD operations for the Phase 02 report.

-- READ 1: enrolled students with course and section info
SELECT
    u.user_id,
    u.first_name,
    u.last_name,
    c.subject_code,
    c.course_number,
    c.title,
    s.section_label,
    e.enroll_status
FROM enrollment e
JOIN users u
    ON e.student_user_id = u.user_id
JOIN section s
    ON e.section_id = s.section_id
JOIN course_offering co
    ON s.offering_id = co.offering_id
JOIN course c
    ON co.course_id = c.course_id
ORDER BY u.last_name, u.first_name
LIMIT 10;

-- READ 2: tickets with submitter and assignee; LEFT JOIN keeps unassigned tickets
SELECT
    t.ticket_id,
    t.subject,
    t.priority,
    t.status,
    submitter.display_name AS submitter_name,
    assignee.display_name AS assigned_to
FROM ticket t
JOIN users submitter
    ON t.submitter_user_id = submitter.user_id
LEFT JOIN users assignee
    ON t.assigned_user_id = assignee.user_id
ORDER BY t.ticket_id
LIMIT 10;

-- INSERT: add a follow-up comment to ticket 1 from a TA (user_id 13)
INSERT INTO ticket_comment (ticket_id, author_user_id, comment_body)
VALUES
(1, 13, 'TA reviewed the issue and posted a follow-up clarification for students.');

-- verify INSERT
SELECT
    comment_id,
    ticket_id,
    author_user_id,
    comment_body,
    created_at
FROM ticket_comment
WHERE ticket_id = 1
ORDER BY comment_id DESC
LIMIT 10;

-- UPDATE: move ticket 1 to In Progress and assign to instructor (user_id 16)
-- updated_at is handled automatically by trg_set_ticket_updated_at
UPDATE ticket
SET status = 'In Progress',
    assigned_user_id = 16
WHERE ticket_id = 1;

-- verify UPDATE
SELECT
    ticket_id,
    subject,
    status,
    assigned_user_id,
    updated_at
FROM ticket
WHERE ticket_id = 1;

-- DELETE: remove the comment inserted above; match on text to avoid hardcoding comment_id
DELETE FROM ticket_comment
WHERE ticket_id = 1
  AND author_user_id = 13
  AND comment_body = 'TA reviewed the issue and posted a follow-up clarification for students.';

-- verify DELETE
SELECT
    comment_id,
    ticket_id,
    author_user_id,
    comment_body
FROM ticket_comment
WHERE ticket_id = 1
ORDER BY comment_id DESC
LIMIT 10;