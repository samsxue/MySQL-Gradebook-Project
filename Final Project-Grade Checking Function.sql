DELIMITER $$
DROP FUNCTION IF EXISTS CheckGrade$$

CREATE FUNCTION CheckGrade (
	PersonIDin int,
	ClassIDin int,
	SectionIDin int
)
	RETURNS CHAR(100)
	NOT DETERMINISTIC
	READS SQL DATA

	BEGIN
		DECLARE PersonExists boolean DEFAULT false;
		DECLARE ClassExists boolean DEFAULT false;
		DECLARE SectionExists boolean DEFAULT false;
		DECLARE ClassSectionExists boolean DEFAULT false;
		DECLARE GradeExists boolean DEFAULT false;
		DECLARE GradeResult varchar(5) DEFAULT NULL;
		IF PersonIDin IS NULL THEN
			RETURN 'person ID needed';
		END IF;
		IF ClassIDin IS NULL THEN
			RETURN 'class ID needed';
		END IF;
		IF SectionIDin IS NULL THEN
			RETURN 'section ID needed';
		END IF;
		SELECT EXISTS (
			SELECT 1
			FROM PEOPLE
			WHERE PEOPLE.PersonID = PersonIDin)
		INTO PersonExists;
		IF NOT PersonExists THEN
			RETURN 'This person ID is not exists in user list';
		END IF;
		SELECT EXISTS (
			SELECT 1
			FROM Class
			WHERE Class.ClassID = ClassIDin)
		INTO ClassExists;
		IF NOT ClassExists THEN
			RETURN 'This class ID is not exists in class list';
		END IF;
		SELECT EXISTS (
			SELECT 1
			FROM Section
			WHERE Section.SectionID = SectionIDin)
		INTO SectionExists;
		IF NOT SectionExists THEN
			RETURN 'This section ID is not exists in section list';
		END IF;
		SELECT EXISTS (
			SELECT 1
			FROM ClassSection
			WHERE ClassSection.ClassID = ClassIDin
			AND ClassSection.SectionID = SectionIDin)
		INTO ClassSectionExists;
		IF NOT ClassSectionExists THEN
			RETURN 'This section is not linked to this class';
		END IF;
		SELECT EXISTS (
			SELECT 1
			FROM Grade
			WHERE Grade.PersonID = PersonIDin
			AND Grade.ClassID = ClassIDin
			AND Grade.SectionID = SectionIDin)
		INTO GradeExists;
		IF NOT GradeExists THEN
			RETURN 'No grade found';
		END IF;
		SELECT Grade.Grade
		INTO GradeResult
		FROM Grade
		WHERE Grade.PersonID = PersonIDin
		AND Grade.ClassID = ClassIDin
		AND Grade.SectionID = SectionIDin
		LIMIT 1;
		RETURN CONCAT('Grade: ', GradeResult);
	END$$

DELIMITER ;
