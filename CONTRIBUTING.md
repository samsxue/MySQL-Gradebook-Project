# Contributing

Contributions should be focused and easy to review.

1. Describe whether a change is documentation-only or changes database behavior.
2. Keep schema files in `database/schema` and stored functions in
   `database/functions`.
3. Preserve the numeric ordering convention when adding files.
4. Document any change to a table, function signature, return value, or sample query.
5. Test SQL changes in a disposable MySQL database before submitting them.

Never commit credentials or real student, contact, authentication, or government-ID
data. Use obviously fictional values in examples.
