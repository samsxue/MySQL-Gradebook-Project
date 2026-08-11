# MySQL Gradebook Project

An educational MySQL gradebook database demonstrating table design, relationship
tables, stored functions, grade lookup, instructor assignment, and basic login
verification.

This repository cleanup only reorganizes and documents the existing project. The SQL
source code and its behavior have not been changed.

## Project structure

```text
.
|-- database/
|   |-- schema/
|   |   `-- 01_gradebook_schema.sql
|   `-- functions/
|       |-- 01_create_person.sql
|       |-- 02_check_person_id.sql
|       |-- 03_link_instructor.sql
|       |-- 04_link_instructor_of_record.sql
|       |-- 05_check_grade.sql
|       `-- 06_authenticate.sql
|-- .vscode/
|   `-- tasks.json
|-- CHANGELOG.md
|-- CONTRIBUTING.md
|-- SECURITY.md
`-- README.md
```

The numeric prefixes communicate the recommended reading and execution order. They do
not change the routines' original names.

## Existing database objects

The schema creates the following tables:

- `PEOPLE` — students, instructors, and other users
- `Login` — usernames and SHA-256 password values
- `Class` and `Section` — course offerings and sections
- `ClassSection` — class-to-section relationships
- `Instructor` — instructor-to-section relationships
- `InstructorOfRecord` — instructor-to-class relationships
- `Grade` — student grades and their related class, section, and instructors

The project includes these existing functions:

| File | Function | Purpose |
| --- | --- | --- |
| `01_create_person.sql` | `createPerson` | Adds a person after checking required fields and possible duplicates |
| `02_check_person_id.sql` | `CheckPersonID` | Finds matching person IDs from name and contact fields |
| `03_link_instructor.sql` | `LinkTeacher` | Links a person to a section as an instructor |
| `04_link_instructor_of_record.sql` | `LinkInstructorOfRecord` | Links a person to a class as instructor of record |
| `05_check_grade.sql` | `CheckGrade` | Returns a person's grade for a class section |
| `06_authenticate.sql` | `Authenticate` | Compares a password SHA-256 value with the login table |

## Logical relationship overview

The diagram represents relationships implied by the ID columns. The current SQL does
not declare foreign-key constraints.

```mermaid
erDiagram
    PEOPLE ||--o| LOGIN : has
    PEOPLE ||--o{ INSTRUCTOR : assigned_as
    PEOPLE ||--o{ INSTRUCTOR_OF_RECORD : assigned_as
    PEOPLE ||--o{ GRADE : receives
    CLASS ||--o{ CLASS_SECTION : includes
    SECTION ||--o{ CLASS_SECTION : belongs_to
    SECTION ||--o{ INSTRUCTOR : staffed_by
    CLASS ||--o{ INSTRUCTOR_OF_RECORD : led_by
    CLASS ||--o{ GRADE : contains
    SECTION ||--o{ GRADE : contains
```

## Requirements

- MySQL with stored-function support
- A MySQL account allowed to create databases, tables, and functions
- The MySQL command-line client, MySQL Workbench, or another compatible SQL client

## Running the project

Start a MySQL client from the repository root:

```bash
mysql --user=root --password
```

Then load the schema and functions in the documented order:

```sql
SOURCE database/schema/01_gradebook_schema.sql;
SOURCE database/functions/01_create_person.sql;
SOURCE database/functions/02_check_person_id.sql;
SOURCE database/functions/03_link_instructor.sql;
SOURCE database/functions/04_link_instructor_of_record.sql;
SOURCE database/functions/05_check_grade.sql;
SOURCE database/functions/06_authenticate.sql;
```

> **Warning:** the schema script begins with `DROP DATABASE IF EXISTS Gradebook` and
> recreates the database. Run it only against a disposable or backed-up environment.

Some original SQL files contain sample `SELECT` calls and sample records. Loading those
files therefore preserves the original demonstration behavior as well as defining the
database objects.

## Current scope and limitations

This is an educational SQL project rather than a production student information
system. In its current form:

- relationships are represented by ID columns but are not enforced by foreign keys;
- sample personal-information fields are stored directly in the database;
- password checking uses a single SHA-256 operation inside MySQL;
- schema definition and a small amount of sample data share the same file; and
- data-changing operations are implemented as stored functions.

These points are documented for a later development phase and were intentionally not
changed during this repository-only cleanup.

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) before proposing changes. Do not commit real
student records, passwords, contact details, or government identifiers.

## License

No open-source license has been selected. All rights are reserved by the author.
