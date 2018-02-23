CREATE PROCEDURE dbo.PR_CancelWorkshopReservation
  @WorkshopReservationID INT
AS
BEGIN
    BEGIN TRY
      IF NOT EXISTS(
        SELECT *
        FROM WorkshopReservations
        WHERE WorkshopReservationID=@WorkshopReservationID
      )
      BEGIN
        ;THROW 61001, 'Given WorkshopReservationID does not exist', 1
      END
      IF @WorkshopReservationID IS NOT NULL
        BEGIN
          UPDATE WorkshopReservations
                SET IsCancelled=1 WHERE WorkshopReservationID=@WorkshopReservationID
        END
    END TRY
    BEGIN CATCH
      DECLARE @errorMsg nvarchar (2048) = 'An error occurred while deleting workshopReservation: ' + ERROR_MESSAGE ();
      THROW 61000, @errorMsg, 1
    END CATCH
END
GO
