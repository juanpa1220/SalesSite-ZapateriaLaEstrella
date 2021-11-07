--***********************************************************************************************--

/****** Object:  UserDefinedFunction [dbo].[Split]    Script Date: 09/08/2020 20:50:09 ******/
-- DROP FUNCTION [dbo].[Split]
-- GO

/****** Object:  UserDefinedFunction [dbo].[Split]    Script Date: 09/08/2020 20:50:09 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE FUNCTION [dbo].[Split](@string0 VARCHAR(MAX), @Delimiter CHAR(1))
    RETURNS @result TABLE
                    (
                        _value1 INT,
                        _value2 INT
                    )
AS
BEGIN
    DECLARE @string1 NVARCHAR(255)
    DECLARE @pos INT

    SELECT @pos = CHARINDEX(@Delimiter, @string0)
    SELECT @string1 = SUBSTRING(@string0, 1, @pos - 1)

    SELECT @string0 = SUBSTRING(@string0, @pos + 1, LEN(@string0) - @pos)

    INSERT INTO @result VALUES (@string1, @string0)

    RETURN
END
GO