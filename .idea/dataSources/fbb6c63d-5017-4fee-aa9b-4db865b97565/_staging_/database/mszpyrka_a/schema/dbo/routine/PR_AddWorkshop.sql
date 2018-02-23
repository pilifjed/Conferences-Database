CREATE PROCEDURE dbo.PR_UpdateWorkshopTime
  @WorkshopID INT,
  @StartTime TIME,
  @EndTime TIME,

AS
BEGIN
    SET NOCOUNT ON
    BEGIN TRY

      IF NOT EXISTS(
        SELECT *
        FROM Workshops
        WHERE @WorkshopID = WorkshopID
      )
        BEGIN
        ;THROW 60000, 'Given WorkshopID does not exist', 1
      END
      UPDATE Workshops
        SET StartTime=@StartTime, EndTime=@EndTime WHERE WorkshopID=@WorkshopID
    END TRY
    BEGIN CATCH
      DECLARE @errorMsg nvarchar (2048) = 'An error occurred while changing workshopTime : ' + ERROR_MESSAGE ();
      THROW 60000, @errorMsg, 1
    END CATCH
END
GO
