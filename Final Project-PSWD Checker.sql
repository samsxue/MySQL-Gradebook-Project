DELIMITER $$
DROP FUNCTION IF EXISTS Authenticate$$
CREATE FUNCTION Authenticate (
	TempUserID varchar(20),
	TempPassword varchar(20)
)
RETURNS CHAR(10)
NOT DETERMINISTIC
READS SQL DATA

BEGIN
DECLARE ReturnResult CHAR(10) DEFAULT 'FAIL';
DECLARE isMatch BOOLEAN DEFAULT FALSE;
SELECT SHA2(TempPassword, 256) = PassWord INTO isMatch FROM Login WHERE PersonName = TempUserID LIMIT 1;
IF isMatch THEN
	SET ReturnResult = 'Match';
	ELSE SET ReturnResult = 'Fail';
END IF ;
RETURN ReturnResult ;
END $$
DELIMITER ;
