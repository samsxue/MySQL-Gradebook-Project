DELIMITER $$
DROP FUNCTION IF EXISTS LinkTeacher$$

CREATE FUNCTION LinkTeacher (
    TeacherIDin int,
    SectionNamein varchar(7))
   RETURNS varchar(100)

NOT DETERMINISTIC
MODIFIES SQL DATA

BEGIN
DECLARE TeacherID int;
DECLARE SectionTID int;
DECLARE TeacherExists boolean DEFAULT false;
DECLARE SectionExists boolean DEFAULT false;
DECLARE RelationshipExists boolean DEFAULT false;
IF TeacherIDin IS Null THEN
    RETURN 'teacher ID needed';
END IF;
IF SectionNamein IS NULL THEN
    RETURN 'section name needed';
END IF;
SELECT EXISTS (
    SELECT 1
    FROM PEOPLE
    WHERE PEOPLE.PersonID = TeacherIDin )
INTO TeacherExists;
IF NOT TeacherExists THEN
    RETURN 'This teacher ID is not exists in user list';
END IF;
SELECT EXISTS (
    SELECT 1
    FROM Section
    WHERE Section.SectionName = SectionNamein)
INTO SectionExists;
IF NOT SectionExists THEN
    RETURN 'This section is not exists in section list';
END IF;
/*Adding the Relationship*/    
SET TeacherID = TeacherIDin;

SELECT Section.SectionID
INTO SectionTID
FROM Section
WHERE SectionNamein = Section.SectionName
LIMIT 1;

SELECT EXISTS (
    SELECT 1
    FROM Instructor
    WHERE Instructor.PersonID = TeacherID
    AND Instructor.SectionID = SectionTID)
INTO RelationshipExists ;
IF RelationshipExists THEN
    RETURN 'This instruction record already exists';
END IF;

INSERT INTO Instructor (PersonID, SectionID, SectionName)
VALUES (TeacherID, SectionTID, SectionNamein);
RETURN 'Instructor Added';
END$$

DELIMITER ;
