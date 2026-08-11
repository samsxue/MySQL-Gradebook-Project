DELIMITER $$
DROP FUNCTION IF EXISTS LinkInstructorOfRecord$$

CREATE FUNCTION LinkInstructorOfRecord (
    TeacherIDin int,
    ClassNamein varchar(45),
    OfferedYearin smallint,
    OfferedSemin varchar(15))
   RETURNS varchar(100)

NOT DETERMINISTIC
MODIFIES SQL DATA

BEGIN
DECLARE TeacherID int;
DECLARE ClassTID int;
DECLARE TeacherExists boolean DEFAULT false;
DECLARE ClassExists boolean DEFAULT false;
DECLARE RelationshipExists boolean DEFAULT false;
IF TeacherIDin IS Null THEN
    RETURN 'teacher ID needed';
END IF;
IF ClassNamein IS NULL THEN
    RETURN 'class name needed';
END IF;
IF OfferedYearin IS NULL THEN
    RETURN 'class offered year needed';
END IF;
IF OfferedSemin IS NULL THEN
    RETURN 'class offered semester needed';
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
    FROM Class
    WHERE Class.ClassName = ClassNamein
    AND Class.OfferedYear = OfferedYearin
    AND Class.OfferedSem = OfferedSemin)
INTO ClassExists;
IF NOT ClassExists THEN
    RETURN 'This class is not exists in class list';
END IF;
/*Adding the Relationship*/
SET TeacherID = TeacherIDin;

SELECT Class.ClassID
INTO ClassTID
FROM Class
WHERE Class.ClassName = ClassNamein
AND Class.OfferedYear = OfferedYearin
AND Class.OfferedSem = OfferedSemin
LIMIT 1;

SELECT EXISTS (
    SELECT 1
    FROM InstructorOfRecord
    WHERE InstructorOfRecord.PersonID = TeacherID
    AND InstructorOfRecord.ClassID = ClassTID)
INTO RelationshipExists ;
IF RelationshipExists THEN
    RETURN 'This instructor of record already exists';
END IF;

INSERT INTO InstructorOfRecord (PersonID, ClassID)
VALUES (TeacherID, ClassTID);
RETURN 'Instructor Of Record Added';
END$$

DELIMITER ;
