CREATE PROCEDURE dbo.PR_AddDayPrice
  @ConferenceDayID INT,
  @StartDate DATE,
  @Price MONEY,
  @StudentDiscount DECIMAL(3, 2)
AS
BEGIN
    SET NOCOUNT ON
    BEGIN TRY

      IF NOT EXISTS(
        SELECT *
        FROM ConferenceDays
        WHERE @ConferenceDayID = ConferenceDayID
      )
        BEGIN
        ;THROW 60000, 'Given ConferenceDayID does not exist', 1
      EN

      INSERT INTO dbo.DayPrices(ConferenceDayID, StartDate, Price, StudentDiscount)
        VALUES (@ConferenceDayID, @StartDate, @Price, @StudentDiscount)
    END TRY
    BEGIN CATCH
      DECLARE @errorMsg nvarchar (2048) = 'An error occurred while adding dayPrice: ' + ERROR_MESSAGE ();
      THROW 60000, @errorMsg, 1
    END CATCH
END
GO
