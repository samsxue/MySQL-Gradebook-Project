DELIMITER $$
DROP FUNCTION IF EXISTS CheckPersonID$$
CREATE FUNCTION CheckPersonID (
	FirstNamein varchar(25),
	LastNamein varchar(100),
	ContactEmailin varchar(100),
	ContactPhonein varchar(20)
)
	RETURNS CHAR(255)
	NOT DETERMINISTIC
	READS SQL DATA

	BEGIN
		DECLARE MatchedIDs varchar(200) DEFAULT NULL;
        IF FirstNamein IS NULL THEN
			RETURN 'First Name Needed';
		END IF;
        IF LastNamein IS NULL THEN
			RETURN 'Last Name Needed';
		END IF;
        IF ContactEmailin IS NULL THEN
			Return 'Contact Email Needed';
		END IF;
        IF ContactPhonein IS NULL THEN
			RETURN 'Contact Phone Needed';
		END IF;
		SELECT GROUP_CONCAT(PEOPLE.PersonID ORDER BY PEOPLE.PersonID SEPARATOR ', ')
		INTO MatchedIDs
		FROM PEOPLE
		WHERE PEOPLE.FirstName = FirstNamein
		AND PEOPLE.LastName = LastNamein
		AND PEOPLE.ContactEmail = ContactEmailin
		AND PEOPLE.ContactPhone = ContactPhonein;
		IF MatchedIDs IS NULL THEN
			RETURN 'No matching person found';
		END IF;
		RETURN CONCAT('Matching PersonID: ', MatchedIDs);
	END$$

DELIMITER ;

SELECT CheckPersonID("Test", "Test", "test@outlook.com", "0000000000");
