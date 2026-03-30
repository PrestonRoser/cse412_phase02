-- Adds PKs, unique constraints, and FKs after table creation.

-- Primary keys
ALTER TABLE users
    ADD CONSTRAINT pk_users PRIMARY KEY (user_id);

ALTER TABLE course
    ADD CONSTRAINT pk_course PRIMARY KEY (course_id);

ALTER TABLE term_offering
    ADD CONSTRAINT pk_term_offering PRIMARY KEY (term_id);

ALTER TABLE course_offering
    ADD CONSTRAINT pk_course_offering PRIMARY KEY (offering_id);

ALTER TABLE section
    ADD CONSTRAINT pk_section PRIMARY KEY (section_id);

-- enrollment and teaching_assignment use composite PKs
ALTER TABLE enrollment
    ADD CONSTRAINT pk_enrollment PRIMARY KEY (student_user_id, section_id);

ALTER TABLE teaching_assignment
    ADD CONSTRAINT pk_teaching_assignment PRIMARY KEY (staff_user_id, section_id);

ALTER TABLE ticket
    ADD CONSTRAINT pk_ticket PRIMARY KEY (ticket_id);

ALTER TABLE ticket_comment
    ADD CONSTRAINT pk_ticket_comment PRIMARY KEY (comment_id);

-- Unique constraints
ALTER TABLE users
    ADD CONSTRAINT uq_users_email UNIQUE (email);

ALTER TABLE course
    ADD CONSTRAINT uq_course_subject_number UNIQUE (subject_code, course_number);

ALTER TABLE term_offering
    ADD CONSTRAINT uq_term_offering UNIQUE (term_year, term_season, session_code);

-- one course per term, one section label per offering
ALTER TABLE course_offering
    ADD CONSTRAINT uq_course_offering_course_term UNIQUE (course_id, term_id);

ALTER TABLE section
    ADD CONSTRAINT uq_section_label_per_offering UNIQUE (offering_id, section_label);

-- Foreign keys
-- CASCADE on UPDATE keeps ids consistent down the chain; RESTRICT on DELETE avoids orphaning offerings.
ALTER TABLE course_offering
    ADD CONSTRAINT fk_course_offering_course
        FOREIGN KEY (course_id) REFERENCES course(course_id)
        ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE course_offering
    ADD CONSTRAINT fk_course_offering_term
        FOREIGN KEY (term_id) REFERENCES term_offering(term_id)
        ON UPDATE CASCADE ON DELETE RESTRICT;

-- deleting an offering cascades to its sections
ALTER TABLE section
    ADD CONSTRAINT fk_section_offering
        FOREIGN KEY (offering_id) REFERENCES course_offering(offering_id)
        ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE enrollment
    ADD CONSTRAINT fk_enrollment_student
        FOREIGN KEY (student_user_id) REFERENCES users(user_id)
        ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE enrollment
    ADD CONSTRAINT fk_enrollment_section
        FOREIGN KEY (section_id) REFERENCES section(section_id)
        ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE teaching_assignment
    ADD CONSTRAINT fk_teaching_assignment_staff
        FOREIGN KEY (staff_user_id) REFERENCES users(user_id)
        ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE teaching_assignment
    ADD CONSTRAINT fk_teaching_assignment_section
        FOREIGN KEY (section_id) REFERENCES section(section_id)
        ON UPDATE CASCADE ON DELETE CASCADE;

-- RESTRICT on submitter/offering so ticket history is preserved if a user or offering is removed
ALTER TABLE ticket
    ADD CONSTRAINT fk_ticket_submitter
        FOREIGN KEY (submitter_user_id) REFERENCES users(user_id)
        ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE ticket
    ADD CONSTRAINT fk_ticket_offering
        FOREIGN KEY (offering_id) REFERENCES course_offering(offering_id)
        ON UPDATE CASCADE ON DELETE RESTRICT;

-- SET NULL so tickets survive if the linked section is dropped
ALTER TABLE ticket
    ADD CONSTRAINT fk_ticket_section
        FOREIGN KEY (section_id) REFERENCES section(section_id)
        ON UPDATE CASCADE ON DELETE SET NULL;

ALTER TABLE ticket
    ADD CONSTRAINT fk_ticket_assigned_user
        FOREIGN KEY (assigned_user_id) REFERENCES users(user_id)
        ON UPDATE CASCADE ON DELETE SET NULL;

ALTER TABLE ticket_comment
    ADD CONSTRAINT fk_ticket_comment_ticket
        FOREIGN KEY (ticket_id) REFERENCES ticket(ticket_id)
        ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE ticket_comment
    ADD CONSTRAINT fk_ticket_comment_author
        FOREIGN KEY (author_user_id) REFERENCES users(user_id)
        ON UPDATE CASCADE ON DELETE RESTRICT;