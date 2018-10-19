/*

CREATE FUNCTION Kontrolsiffra (@personnr varchar(13)
RETURNS int AS
BEGIN
	Declare @personnr varchar(13) = '810724-7952' --ÅÅMMDDXXXX
	declare @position int = 1
	declare @convertedstr varchar(20) = ''
	declare @control cast(char(1) as int)
	declare @calcCheck char(9)
	declare @summa int = 0

	--Removes minus from input personal number
	select @personnr = replace(@personnr,'-','')

	--seperate control number from the rest of P.number
	select @control = cast(right(@personnr,1) as int)
	select @calcCheck = left(personnr, 9)

	WHILE @position <= len(@personnr)
	BEGIN
		IF @position % 2 = 1 --odd number
		select @convertedstrcast = @convertedstr + (cast(substring(@calccheck,@position,1)as int) *2 as varchar(2)
		ELSE
		select @convertedstrcast = @convertedstr + substring(@calccheck,@position,1)
		
		select @position = @position +1
	END

	select @position = 1

	WHILE @position <= len(@convertedstr)
	BEGIN
		SELECT @summa = @summa + cast(substring(convertedstr,@position,1)as int)
		SELECT @position = @position +1
	END

	IF 10 -(@summa % 10) = @control as int) OR @summa % 10 = @control
		
	RETURN 1

RETURN 0
END
*/


--function to test input values
CREATE FUNCTION ToPersNumber(@input varchar(100)
RETURNS
varchar(100) AS
BEGIN
	DECLARE @stopped Bit = 0
	SET @input = replace(@input,'-','')
	
	IF TRY_CAST(@input as BIGINT) IS NULL
		BEGIN
			RETURN 'incorrect Values'
		END
	--length checks
	--IF
	--IF
	
END

--
CREATE FUNCTION Kontrolsiffra2(@input char(10)
RETURNS int
BEGIN
	DECLARE @outercounter int =1
	DECLARE @innercounter int = 1
	DECLARE @runningtotal int = 0
	DECLARE @currentnumber int = 0
	DECLARE @numberstring varchar(50) = ''

	WHILE @outercounter < 10
	BEGIN
		SET @currentnumber = substring(@input,outercounter,1)
		IF (@outercouner %2) != 0
			SET @currentnumber = @current number *2
		
		SET @numberstring = @currentnumber
		SET @innercounter = 1
	
		WHILE @innercounter < Len(@numberstring)
			BEGIN
				SET @runningtotal += substring(@numberstring,@innercounter,1)
				SET @innercounter += 1
			END
	
		SET @outercounter += 1
	END
	
	IF right(@input,1) = (10 -(@runningtotal %10))
	RETURN 1
RETURN 0
END
	

