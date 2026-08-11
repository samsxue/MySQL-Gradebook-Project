# Security Policy

This repository is an educational database project and is not designed to hold real
student or authentication data.

## Data safety

- Do not use real names, contact information, Social Security numbers, or grades.
- Do not commit database exports, environment files, or credentials.
- Run the schema only in a disposable or backed-up environment because it drops and
  recreates the `Gradebook` database.

## Authentication limitation

The existing `Authenticate` function applies SHA-256 directly in MySQL. This behavior
is retained to preserve the original project, but it is not suitable for production
password storage. A production application should use a salted password-hashing
algorithm such as Argon2id, scrypt, or bcrypt outside the database.

Please report suspected vulnerabilities privately to the repository owner rather than
including sensitive details in a public issue.
