ALTER PROCEDURE dbo.PR_RemoveConfDayReservation
  @ReservationID INT
AS
BEGIN
    BEGIN TRY
      IF NOT EXISTS(
        SELECT *
        FROM ConfDayReservations
        WHERE ReservationID=@ReservationID
      )
      BEGIN
        ;THROW 61001, 'Given ConfDayReservationID does not exist', 1
      END
      IF @ReservationID IS NOT NULL
        BEGIN
          DELETE  FROM ConfDayReservations
                  WHERE ReservationID=@ReservationID
        END
    END TRY
    BEGIN CATCH
      DECLARE @errorMsg nvarchar (2048) = 'An error occurred while deleting confDayReservation: ' + ERROR_MESSAGE ();
      THROW 61000, @errorMsg, 1
    END CATCH
END
GO
