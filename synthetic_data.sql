-- Synthetic data population script
-- Populates every table with 20 rows. Assumes empty DB; identity columns start at 1.

BEGIN;

-- users: 12 students, 3 TAs, 3 instructors, 1 staff, 1 admin
INSERT INTO users (first_name, last_name, display_name, email, password_hash, role_type)
VALUES
('James', 'Smith', 'jsmith', 'jamessmith@gmail.com', 'hash_jamessmith', 'Student'),
('Mary', 'Johnson', 'mjohnson', 'maryjohnson@gmail.com', 'hash_maryjohnson', 'Student'),
('John', 'Williams', 'jwilliams', 'johnwilliams@gmail.com', 'hash_johnwilliams', 'Student'),
('Patricia', 'Brown', 'pbrown', 'patriciabrown@gmail.com', 'hash_patriciabrown', 'Student'),
('Robert', 'Jones', 'rjones', 'robertjones@gmail.com', 'hash_robertjones', 'Student'),
('Jennifer', 'Garcia', 'jgarcia', 'jennifergarcia@gmail.com', 'hash_jennifergarcia', 'Student'),
('Michael', 'Miller', 'mmiller', 'michaelmiller@gmail.com', 'hash_michaelmiller', 'Student'),
('Linda', 'Davis', 'ldavis', 'lindadavis@gmail.com', 'hash_lindadavis', 'Student'),
('William', 'Rodriguez', 'wrodriguez', 'williamrodriguez@gmail.com', 'hash_williamrodriguez', 'Student'),
('Elizabeth', 'Martinez', 'emartinez', 'elizabethmartinez@gmail.com', 'hash_elizabethmartinez', 'Student'),
('David', 'Hernandez', 'dhernandez', 'davidhernandez@gmail.com', 'hash_davidhernandez', 'Student'),
('Barbara', 'Lopez', 'blopez', 'barbaralopez@gmail.com', 'hash_barbaralopez', 'Student'),
('Richard', 'Gonzalez', 'rgonzalez', 'richardgonzalez@gmail.com', 'hash_richardgonzalez', 'TA'),
('Susan', 'Wilson', 'swilson', 'susanwilson@gmail.com', 'hash_susanwilson', 'TA'),
('Joseph', 'Anderson', 'janderson', 'josephanderson@gmail.com', 'hash_josephanderson', 'TA'),
('Jessica', 'Thomas', 'jthomas', 'jessicathomas@gmail.com', 'hash_jessicathomas', 'Instructor'),
('Thomas', 'Taylor', 'ttaylor', 'thomastaylor@gmail.com', 'hash_thomastaylor', 'Instructor'),
('Sarah', 'Moore', 'smoore', 'sarahmoore@gmail.com', 'hash_sarahmoore', 'Instructor'),
('Charles', 'Jackson', 'cjackson', 'charlesjackson@gmail.com', 'hash_charlesjackson', 'Staff'),
('Karen', 'Martin', 'kmartin', 'karenmartin@gmail.com', 'hash_karenmartin', 'Administrator');

INSERT INTO course (subject_code, course_number, title, description)
VALUES
('MATH', '101', 'College Algebra', 'Introductory algebra course.'),
('ENG', '101', 'First-Year Composition', 'Foundations of academic writing.'),
('BIO', '101', 'General Biology', 'Introductory biology course.'),
('CHEM', '101', 'General Chemistry', 'Introductory chemistry course.'),
('PHY', '101', 'General Physics', 'Introductory physics course.'),
('HIST', '101', 'World History', 'Survey of major historical developments.'),
('PSY', '101', 'Introduction to Psychology', 'Overview of psychological concepts.'),
('SOC', '101', 'Introduction to Sociology', 'Overview of society and institutions.'),
('ECON', '101', 'Principles of Economics', 'Basic economic concepts.'),
('CSE', '110', 'Introduction to Programming', 'Basic programming and problem solving.'),
('CSE', '205', 'Object-Oriented Programming', 'Programming with classes and objects.'),
('CSE', '230', 'Computer Organization', 'Computer systems fundamentals.'),
('CSE', '240', 'Intro to Information Systems', 'Information systems concepts.'),
('CSE', '310', 'Data Structures and Algorithms', 'Core data structures and algorithms.'),
('CSE', '355', 'Introduction to Theoretical CS', 'Automata, grammars, and computability.'),
('CSE', '360', 'Software Engineering', 'Software design and development process.'),
('CSE', '412', 'Database Management', 'Relational databases and SQL.'),
('CSE', '434', 'Computer Networks', 'Basic networking concepts.'),
('EDU', '201', 'Foundations of Education', 'Introduction to educational systems.'),
('STAT', '200', 'Introduction to Statistics', 'Statistical reasoning and analysis.');

INSERT INTO term_offering (term_year, term_season, session_code, start_date, end_date)
VALUES
(2026, 'Spring', 'A', '2026-01-12', '2026-03-01'),
(2026, 'Spring', 'B', '2026-03-02', '2026-04-19'),
(2026, 'Spring', 'C', '2026-01-12', '2026-04-26'),
(2026, 'Summer', 'A', '2026-05-18', '2026-06-28'),
(2026, 'Summer', 'B', '2026-06-29', '2026-08-09'),
(2026, 'Summer', 'C', '2026-05-18', '2026-08-09'),
(2026, 'Fall', 'A', '2026-08-17', '2026-10-04'),
(2026, 'Fall', 'B', '2026-10-05', '2026-11-22'),
(2026, 'Fall', 'C', '2026-08-17', '2026-12-06'),
(2026, 'Winter', 'A', '2026-12-14', '2027-01-10'),
(2027, 'Spring', 'A', '2027-01-11', '2027-02-28'),
(2027, 'Spring', 'B', '2027-03-01', '2027-04-18'),
(2027, 'Spring', 'C', '2027-01-11', '2027-04-25'),
(2027, 'Summer', 'A', '2027-05-17', '2027-06-27'),
(2027, 'Summer', 'B', '2027-06-28', '2027-08-08'),
(2027, 'Summer', 'C', '2027-05-17', '2027-08-08'),
(2027, 'Fall', 'A', '2027-08-16', '2027-10-03'),
(2027, 'Fall', 'B', '2027-10-04', '2027-11-21'),
(2027, 'Fall', 'C', '2027-08-16', '2027-12-05'),
(2027, 'Fall', 'D', '2027-08-16', '2028-05-15');

-- course_id and term_id map 1:1 here; one offering per term row
INSERT INTO course_offering (course_id, term_id, catalog_label, delivery_mode, notes)
VALUES
(1, 1, 'MATH 101 Spring A', 'InPerson', 'Standard section offering.'),
(2, 2, 'ENG 101 Spring B', 'Online', 'Writing course delivered online.'),
(3, 3, 'BIO 101 Spring C', 'Hybrid', 'Lab and lecture combined.'),
(4, 4, 'CHEM 101 Summer A', 'InPerson', 'Summer chemistry offering.'),
(5, 5, 'PHY 101 Summer B', 'InPerson', 'Short summer physics course.'),
(6, 6, 'HIST 101 Summer C', 'Online', 'Survey history course online.'),
(7, 7, 'PSY 101 Fall A', 'Hybrid', 'Discussion-based format.'),
(8, 8, 'SOC 101 Fall B', 'Online', 'Accelerated format.'),
(9, 9, 'ECON 101 Fall C', 'InPerson', 'Main campus delivery.'),
(10, 10, 'CSE 110 Winter A', 'Online', 'Winter bootcamp style course.'),
(11, 11, 'CSE 205 Spring A', 'InPerson', 'Programming continuation course.'),
(12, 12, 'CSE 230 Spring B', 'InPerson', 'Systems-oriented offering.'),
(13, 13, 'CSE 240 Spring C', 'Online', 'Information systems survey.'),
(14, 14, 'CSE 310 Summer A', 'InPerson', 'Core algorithms course.'),
(15, 15, 'CSE 355 Summer B', 'Online', 'Theory delivered asynchronously.'),
(16, 16, 'CSE 360 Summer C', 'Hybrid', 'Project-focused software engineering.'),
(17, 17, 'CSE 412 Fall A', 'InPerson', 'Database course with project work.'),
(18, 18, 'CSE 434 Fall B', 'Online', 'Networking concepts online.'),
(19, 19, 'EDU 201 Fall C', 'InPerson', 'Education foundations survey.'),
(20, 20, 'STAT 200 All Year', 'Hybrid', 'Year-long statistics support course.');

-- one section per offering; offering_id and section_id align positionally
INSERT INTO section (offering_id, section_label, meeting_time, room_location)
VALUES
(1, 'A1', 'Mon/Wed 9:00 AM - 10:15 AM', 'Room 101'),
(2, 'B1', 'Tue/Thu 10:30 AM - 11:45 AM', 'Online'),
(3, 'C1', 'Mon/Wed/Fri 8:00 AM - 8:50 AM', 'Lab 201'),
(4, 'A1', 'Tue/Thu 1:00 PM - 2:15 PM', 'Room 110'),
(5, 'B1', 'Mon/Wed 2:30 PM - 3:45 PM', 'Room 115'),
(6, 'C1', 'Online Asynchronous', 'Online'),
(7, 'A1', 'Tue/Thu 9:00 AM - 10:15 AM', 'Room 120'),
(8, 'B1', 'Online Asynchronous', 'Online'),
(9, 'C1', 'Mon/Wed 11:00 AM - 12:15 PM', 'Room 125'),
(10, 'A1', 'Online Evenings', 'Online'),
(11, 'A1', 'Mon/Wed 1:00 PM - 2:15 PM', 'Room 130'),
(12, 'B1', 'Tue/Thu 2:30 PM - 3:45 PM', 'Room 135'),
(13, 'C1', 'Online Asynchronous', 'Online'),
(14, 'A1', 'Mon/Wed/Fri 10:00 AM - 10:50 AM', 'Room 140'),
(15, 'B1', 'Online Asynchronous', 'Online'),
(16, 'C1', 'Tue/Thu 4:00 PM - 5:15 PM', 'Hybrid Room 145'),
(17, 'A1', 'Mon/Wed 3:00 PM - 4:15 PM', 'Room 150'),
(18, 'B1', 'Online Asynchronous', 'Online'),
(19, 'C1', 'Tue/Thu 12:00 PM - 1:15 PM', 'Room 155'),
(20, 'D1', 'Mon 5:00 PM - 7:00 PM', 'Hybrid Room 160');

-- students only (user_id 1-12); trigger will reject any non-Student
INSERT INTO enrollment (student_user_id, section_id, enroll_status, final_grade)
VALUES
(1, 1, 'Enrolled', NULL),
(2, 2, 'Enrolled', NULL),
(3, 3, 'Enrolled', NULL),
(4, 4, 'Enrolled', NULL),
(5, 5, 'Enrolled', NULL),
(6, 6, 'Enrolled', NULL),
(7, 7, 'Enrolled', NULL),
(8, 8, 'Enrolled', NULL),
(9, 9, 'Enrolled', NULL),
(10, 10, 'Enrolled', NULL),
(11, 11, 'Enrolled', NULL),
(12, 12, 'Enrolled', NULL),
(1, 13, 'Waitlisted', NULL),
(2, 14, 'Enrolled', NULL),
(3, 15, 'Completed', 'A'),
(4, 16, 'Enrolled', NULL),
(5, 17, 'Completed', 'B'),
(6, 18, 'Dropped', NULL),
(7, 19, 'Enrolled', NULL),
(8, 20, 'Enrolled', NULL);

-- instructors/TAs/staff only (user_id 13-19)
INSERT INTO teaching_assignment (staff_user_id, section_id, assignment_role)
VALUES
(16, 1, 'Instructor'),
(13, 1, 'TA'),
(17, 2, 'Instructor'),
(14, 2, 'TA'),
(18, 3, 'Instructor'),
(15, 3, 'TA'),
(16, 4, 'Instructor'),
(19, 4, 'Staff'),
(17, 5, 'Instructor'),
(13, 6, 'TA'),
(18, 7, 'Instructor'),
(14, 8, 'TA'),
(16, 9, 'Instructor'),
(15, 10, 'TA'),
(17, 11, 'Instructor'),
(19, 12, 'Staff'),
(18, 13, 'Instructor'),
(13, 14, 'TA'),
(16, 15, 'Instructor'),
(17, 17, 'Instructor');

-- section_id matches the paired section for each offering (same index)
INSERT INTO ticket (submitter_user_id, offering_id, section_id, assigned_user_id, subject, body, priority, status)
VALUES
(1, 1, 1, 16, 'Login issue', 'Student cannot access the course materials after enrollment.', 'Medium', 'Open'),
(2, 2, 2, 17, 'Assignment page not loading', 'The weekly assignment page keeps timing out.', 'High', 'In Progress'),
(3, 3, 3, 18, 'Lab instructions unclear', 'Student requests clarification on the biology lab steps.', 'Low', 'Open'),
(4, 4, 4, 19, 'Room change request', 'Chemistry section may need a larger room next week.', 'Medium', 'Open'),
(5, 5, 5, 17, 'Gradebook mismatch', 'Displayed score does not match submitted work.', 'High', 'In Progress'),
(6, 6, 6, 13, 'Missing discussion board', 'Expected discussion board is not visible in the LMS.', 'Medium', 'Resolved'),
(7, 7, 7, 18, 'Attendance question', 'Student asks how attendance is recorded in the hybrid class.', 'Low', 'Closed'),
(8, 8, 8, 14, 'Broken Zoom link', 'The posted Zoom link opens an error page.', 'Urgent', 'Open'),
(9, 9, 9, 16, 'Exam scheduling issue', 'Two assessments appear to overlap for the same week.', 'High', 'Open'),
(10, 10, 10, 15, 'Coding environment setup', 'Student needs help setting up the programming tools.', 'Medium', 'Resolved'),
(11, 11, 11, 17, 'Prerequisite question', 'Student wants confirmation on prerequisite completion.', 'Low', 'Closed'),
(12, 12, 12, 19, 'Lecture recording missing', 'The latest lecture recording has not been uploaded.', 'Medium', 'In Progress'),
(1, 13, 13, 18, 'Course note typo', 'A note in the module appears to contain incorrect dates.', 'Low', 'Open'),
(2, 14, 14, 16, 'Office hours conflict', 'Office hours overlap with another enrolled course.', 'Medium', 'Open'),
(3, 15, 15, 13, 'Quiz access issue', 'Quiz opens and closes immediately after launch.', 'High', 'In Progress'),
(4, 16, 16, 14, 'Team assignment request', 'Student asks to be moved to a different project team.', 'Medium', 'Resolved'),
(5, 17, 17, 17, 'Database script error', 'Provided script returns an unexpected syntax error.', 'Urgent', 'Open'),
(6, 18, 18, 18, 'Network lab question', 'Clarification needed on the packet tracing task.', 'Low', 'Closed'),
(7, 19, 19, 19, 'Attendance excused absence', 'Student submitted documentation for an excused absence.', 'Medium', 'Resolved'),
(8, 20, 20, 16, 'Statistics worksheet upload', 'Worksheet upload area appears locked before due date.', 'Medium', 'Open');

INSERT INTO ticket_comment (ticket_id, author_user_id, comment_body)
VALUES
(1, 16, 'Instructor reviewed the login report and escalated it to support.'),
(2, 17, 'A temporary workaround was posted in the course announcements.'),
(3, 18, 'Additional lab instructions were added to the module.'),
(4, 19, 'Staff will confirm room availability by tomorrow morning.'),
(5, 17, 'Gradebook entries are being checked against the rubric now.'),
(6, 13, 'The discussion board was restored and tested successfully.'),
(7, 18, 'Attendance policy was clarified in the syllabus section.'),
(8, 14, 'New Zoom link posted and announcement sent to students.'),
(9, 16, 'Exam dates were adjusted to remove the overlap.'),
(10, 15, 'Setup guide was attached to the ticket for reference.'),
(11, 17, 'Prerequisite record confirmed in the student system.'),
(12, 19, 'Lecture recording was uploaded after media processing completed.'),
(13, 18, 'The typo was corrected in both the note and assignment page.'),
(14, 16, 'Office hours were expanded to include an alternate time slot.'),
(15, 13, 'Quiz settings were updated and extra time was granted.'),
(16, 14, 'Team reassignment request was approved.'),
(17, 17, 'Script issue reproduced and fix is being prepared.'),
(18, 18, 'Lab clarification was added to the instructions page.'),
(19, 19, 'Excused absence was marked in the attendance record.'),
(20, 16, 'Worksheet folder permissions were corrected.');

COMMIT;

-- row count verification
SELECT COUNT(*) AS user_count FROM users;
SELECT COUNT(*) AS course_count FROM course;
SELECT COUNT(*) AS term_count FROM term_offering;
SELECT COUNT(*) AS course_offering_count FROM course_offering;
SELECT COUNT(*) AS section_count FROM section;
SELECT COUNT(*) AS enrollment_count FROM enrollment;
SELECT COUNT(*) AS teaching_assignment_count FROM teaching_assignment;
SELECT COUNT(*) AS ticket_count FROM ticket;
SELECT COUNT(*) AS ticket_comment_count FROM ticket_comment;