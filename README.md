# cse412_phase02 aka Education Operations Database

**CSE 412 - Database Management | ASU | Spring 2026**

A PostgreSQL relational database schema for managing core academic structures in a K-12 education platform. Built as a Phase 01/02 project for CSE 412, focused on schema design, referential integrity, and CRUD functionality.

---

## Overview

The database supports five user roles (Student, TA, Instructor, Staff, Administrator) and tracks course delivery from catalog courses and term offerings down to individual sections, enrollments, and instructional assignments. There is also a ticket management component for operational and academic issue tracking scoped to a specific course offering.

The institutional hierarchy (Region, District, School) is out of scope for now and marked for future expansion.

---

## Schema

| Table | Description |
|---|---|
| `users` | All system users; `role_type` drives trigger enforcement |
| `course` | Catalog-level courses identified by `subject_code` + `course_number` |
| `term_offering` | Academic terms by year, season, and session code |
| `course_offering` | A course delivered in a specific term |
| `section` | Individual instructional instance within an offering |
| `enrollment` | Student to section mapping; composite PK |
| `teaching_assignment` | Instructor/TA/Staff to section mapping; composite PK |
| `ticket` | Operational/academic issues tied to an offering |
| `ticket_comment` | Threaded comments on tickets |

---

## Files

```
create_tables.sql       - DDL: table definitions and CHECK constraints
add_relationships.sql   - PKs, unique constraints, and foreign keys
role_enforcement.sql    - Trigger functions for business rule enforcement
synthetic_data.sql      - 20-row seed data for every table
crud_demo.sql           - Sample CRUD operations (SELECT, INSERT, UPDATE, DELETE)
```

---

## Business Rules (Trigger-Enforced)

- `enrollment` only accepts users with `role_type = 'Student'`
- `teaching_assignment` only accepts `Instructor`, `TA`, or `Staff`
- A ticket's `section_id`, if provided, must belong to the same offering as the ticket
- `ticket.updated_at` is automatically refreshed on any update

---

## Setup

Requires PostgreSQL. Run scripts in order:

```sql
\i create_tables.sql
\i add_relationships.sql
\i role_enforcement.sql
\i synthetic_data.sql
```

`crud_demo.sql` can be run independently after data is loaded.

---

## Design Notes

- `term_offering` is kept separate from `course_offering` so a term row can be reused across multiple courses without duplication.
- `section_id` is nullable on `ticket` since tickets can be scoped to an offering without targeting a specific section.
- FK delete behavior is intentional: `ON DELETE CASCADE` flows down through the offering -> section -> enrollment chain, `ON DELETE RESTRICT` protects ticket history if a user or offering is removed, and `ON DELETE SET NULL` keeps tickets intact if a linked section is dropped.
- `GENERATED ALWAYS AS IDENTITY` is used over `SERIAL` for standard-compliant identity columns.
