-- CSE 412 Project Phase 02
-- Creates all tables from the Phase 01 schema.

-- Core user table; role_type drives enrollment/assignment enforcement via triggers.
CREATE TABLE users (
    user_id          INTEGER GENERATED ALWAYS AS IDENTITY,
    first_name       VARCHAR(50) NOT NULL,
    last_name        VARCHAR(50) NOT NULL,
    display_name     VARCHAR(100),
    email            VARCHAR(255) NOT NULL,
    password_hash    VARCHAR(255) NOT NULL,
    role_type        VARCHAR(20) NOT NULL,
    created_at       TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT chk_users_role_type
        CHECK (role_type IN ('Student', 'TA', 'Instructor', 'Staff', 'Administrator'))
);

CREATE TABLE course (
    course_id        INTEGER GENERATED ALWAYS AS IDENTITY,
    subject_code     VARCHAR(10) NOT NULL,
    course_number    VARCHAR(10) NOT NULL,
    title            VARCHAR(150) NOT NULL,
    description      TEXT
);

-- term_offering captures year/season/session; course_offering ties a course to a term.
CREATE TABLE term_offering (
    term_id          INTEGER GENERATED ALWAYS AS IDENTITY,
    term_year        INTEGER NOT NULL,
    term_season      VARCHAR(20) NOT NULL,
    session_code     VARCHAR(20) NOT NULL,
    start_date       DATE,
    end_date         DATE,
    CONSTRAINT chk_term_year
        CHECK (term_year >= 2000 AND term_year <= 2100),
    CONSTRAINT chk_term_season
        CHECK (term_season IN ('Spring', 'Summer', 'Fall', 'Winter')),
    CONSTRAINT chk_session_code
        CHECK (session_code IN ('A', 'B', 'C', 'D', 'FullYear', 'AllYear'))
);

CREATE TABLE course_offering (
    offering_id      INTEGER GENERATED ALWAYS AS IDENTITY,
    course_id        INTEGER NOT NULL,
    term_id          INTEGER NOT NULL,
    catalog_label    VARCHAR(50),
    delivery_mode    VARCHAR(30) NOT NULL DEFAULT 'InPerson',
    notes            TEXT,
    CONSTRAINT chk_course_offering_delivery_mode
        CHECK (delivery_mode IN ('InPerson', 'Online', 'Hybrid'))
);

-- section is a child of course_offering; one offering can have multiple sections.
CREATE TABLE section (
    section_id       INTEGER GENERATED ALWAYS AS IDENTITY,
    offering_id      INTEGER NOT NULL,
    section_label    VARCHAR(20) NOT NULL,
    meeting_time     VARCHAR(100),
    room_location    VARCHAR(100)
);

-- composite PK (student_user_id, section_id) prevents duplicate enrollment.
CREATE TABLE enrollment (
    student_user_id  INTEGER NOT NULL,
    section_id       INTEGER NOT NULL,
    enroll_status    VARCHAR(20) NOT NULL DEFAULT 'Enrolled',
    enrolled_at      TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    final_grade      VARCHAR(5),
    CONSTRAINT chk_enrollment_status
        CHECK (enroll_status IN ('Enrolled', 'Waitlisted', 'Dropped', 'Completed'))
);

CREATE TABLE teaching_assignment (
    staff_user_id    INTEGER NOT NULL,
    section_id       INTEGER NOT NULL,
    assignment_role  VARCHAR(20) NOT NULL,
    assigned_at      TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT chk_teaching_assignment_role
        CHECK (assignment_role IN ('Instructor', 'TA', 'Staff'))
);

-- section_id nullable; a ticket can be offering-level without targeting a specific section.
CREATE TABLE ticket (
    ticket_id        INTEGER GENERATED ALWAYS AS IDENTITY,
    submitter_user_id INTEGER NOT NULL,
    offering_id      INTEGER NOT NULL,
    section_id       INTEGER,
    assigned_user_id INTEGER,
    subject          VARCHAR(150) NOT NULL,
    body             TEXT NOT NULL,
    priority         VARCHAR(20) NOT NULL DEFAULT 'Medium',
    status           VARCHAR(20) NOT NULL DEFAULT 'Open',
    created_at       TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at       TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT chk_ticket_priority
        CHECK (priority IN ('Low', 'Medium', 'High', 'Urgent')),
    CONSTRAINT chk_ticket_status
        CHECK (status IN ('Open', 'In Progress', 'Resolved', 'Closed'))
);

CREATE TABLE ticket_comment (
    comment_id       INTEGER GENERATED ALWAYS AS IDENTITY,
    ticket_id        INTEGER NOT NULL,
    author_user_id   INTEGER NOT NULL,
    comment_body     TEXT NOT NULL,
    created_at       TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);