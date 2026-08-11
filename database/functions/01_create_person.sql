DELIMITER $$
DROP FUNCTION IF EXISTS createPerson$$
CREATE FUNCTION createPerson (
	UserTypein varchar(10) , /*not null*/
	SSNin char(9),
	FirstNamein varchar(25) , /*nut null*/
	MiddleNamesin varchar(100),
	LastNamein varchar(100) , /*not null*/
	Suffixin varchar(15),
	Honorificin varchar(150),
	PreferredNamein varchar(25),
	Genderin varchar(7),
	Pronounsin varchar(4),
	ContactEmailin varchar(100) , /*not null*/
	ContactPhonein varchar(20) , /*not null*/
	Cityin varchar(45),
	Zip9in int,
	Statein varchar(2),
	AptNumin varchar(25),
	StreetAddressin varchar(45)
)
    RETURNS CHAR(255)
    NOT DETERMINISTIC
    MODIFIES SQL DATA

    BEGIN
		DECLARE ExistingPersonID int DEFAULT NULL;
		IF UserTypein IS NULL THEN
			RETURN 'User Type Needed';
		END IF;
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
		SELECT PEOPLE.PersonID
		INTO ExistingPersonID
		FROM PEOPLE
		WHERE PEOPLE.FirstName = FirstNamein
		AND PEOPLE.LastName = LastNamein
		AND PEOPLE.ContactEmail = ContactEmailin
		AND PEOPLE.ContactPhone = ContactPhonein
		LIMIT 1;
		IF ExistingPersonID IS NOT NULL THEN
			RETURN CONCAT('Person may already exist. Existing PersonID: ', ExistingPersonID, '. If this is a different person, use a different name in the system or add a note.');
		END IF;
        INSERT INTO PEOPLE (UserType, SSN, FirstName, MiddleNames, LastName, Suffix, Honorific, PreferredName, Gender, Pronouns, ContactEmail, ContactPhone, City, Zip9, State, AptNum, StreetAddress)
        VALUES (UserTypein, SSNin, FirstNamein, MiddleNamesin, LastNamein, Suffixin, Honorificin, PreferredNamein, Genderin, Pronounsin, ContactEmailin, ContactPhonein, Cityin, Zip9in, Statein, AptNumin, StreetAddressin);
        RETURN CONCAT('Person Added. PersonID: ', LAST_INSERT_ID());
    END$$

DELIMITER ;

SELECT createPerson("Student", null, "Test", null, "Test", null, null, null, null, null, "test@outlook.com", "0000000000", null, null, null, null, null);
SELECT * FROM PEOPLE;
