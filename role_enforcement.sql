-- Trigger-based business rule enforcement that CHECK constraints can't handle.

-- Keep updated_at current on any ticket modification.
CREATE OR REPLACE FUNCTION set_ticket_updated_at()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at := CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trg_set_ticket_updated_at ON ticket;
CREATE TRIGGER trg_set_ticket_updated_at
BEFORE UPDATE ON ticket
FOR EACH ROW
EXECUTE FUNCTION set_ticket_updated_at();

-- Only users with role_type = 'Student' may appear in enrollment.
CREATE OR REPLACE FUNCTION enforce_enrollment_student_role()
RETURNS TRIGGER AS $$
DECLARE
    v_role VARCHAR(20);
BEGIN
    SELECT role_type INTO v_role
    FROM users
    WHERE user_id = NEW.student_user_id;

    IF v_role IS NULL THEN
        RAISE EXCEPTION 'Enrollment failed: user % does not exist.', NEW.student_user_id;
    END IF;

    IF v_role <> 'Student' THEN
        RAISE EXCEPTION 'Enrollment failed: user % has role %, but only Student may enroll.',
            NEW.student_user_id, v_role;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trg_enforce_enrollment_student_role ON enrollment;
CREATE TRIGGER trg_enforce_enrollment_student_role
BEFORE INSERT OR UPDATE ON enrollment
FOR EACH ROW
EXECUTE FUNCTION enforce_enrollment_student_role();

-- Only Instructor, TA, or Staff may receive teaching assignments.
CREATE OR REPLACE FUNCTION enforce_teaching_assignment_role()
RETURNS TRIGGER AS $$
DECLARE
    v_role VARCHAR(20);
BEGIN
    SELECT role_type INTO v_role
    FROM users
    WHERE user_id = NEW.staff_user_id;

    IF v_role IS NULL THEN
        RAISE EXCEPTION 'Teaching assignment failed: user % does not exist.', NEW.staff_user_id;
    END IF;

    IF v_role NOT IN ('Instructor', 'TA', 'Staff') THEN
        RAISE EXCEPTION 'Teaching assignment failed: user % has role %, but only Instructor, TA, or Staff may be assigned.',
            NEW.staff_user_id, v_role;
    END IF;

    IF NEW.assignment_role NOT IN ('Instructor', 'TA', 'Staff') THEN
        RAISE EXCEPTION 'Teaching assignment failed: invalid assignment_role %.', NEW.assignment_role;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trg_enforce_teaching_assignment_role ON teaching_assignment;
CREATE TRIGGER trg_enforce_teaching_assignment_role
BEFORE INSERT OR UPDATE ON teaching_assignment
FOR EACH ROW
EXECUTE FUNCTION enforce_teaching_assignment_role();

-- If a ticket references a section, that section must belong to the same offering as the ticket.
CREATE OR REPLACE FUNCTION enforce_ticket_section_matches_offering()
RETURNS TRIGGER AS $$
DECLARE
    v_section_offering_id INTEGER;
BEGIN
    IF NEW.section_id IS NULL THEN
        RETURN NEW;
    END IF;

    SELECT offering_id INTO v_section_offering_id
    FROM section
    WHERE section_id = NEW.section_id;

    IF v_section_offering_id IS NULL THEN
        RAISE EXCEPTION 'Ticket failed: section % does not exist.', NEW.section_id;
    END IF;

    IF v_section_offering_id <> NEW.offering_id THEN
        RAISE EXCEPTION 'Ticket failed: section % belongs to offering %, but ticket references offering %.',
            NEW.section_id, v_section_offering_id, NEW.offering_id;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trg_enforce_ticket_section_matches_offering ON ticket;
CREATE TRIGGER trg_enforce_ticket_section_matches_offering
BEFORE INSERT OR UPDATE ON ticket
FOR EACH ROW
EXECUTE FUNCTION enforce_ticket_section_matches_offering();