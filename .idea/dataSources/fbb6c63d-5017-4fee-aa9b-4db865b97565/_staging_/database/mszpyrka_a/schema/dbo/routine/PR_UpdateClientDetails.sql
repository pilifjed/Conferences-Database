ALTER PROCEDURE dbo.PR_RemoveConfDayReservation
  @ConfDayReservationID INT
AS
BEGIN
    BEGIN TRY
      IF NOT EXISTS(
        SELECT *
        FROM ConfDayReservations
        WHERE ConfDayReservationID=@ConfDayReservationID
      )
      BEGIN
        ;THROW 61001, 'Given ConfDayReservationID does not exist', 1
      END
      IF @ConfDayReservationID IS NOT NULL
        BEGIN
          DELETE  FROM ConfDayReservations
                  WHERE ConfDayReservationID=@ConfDayReservationID
        END
    END TRY
    BEGIN CATCH
      DECLARE @errorMsg nvarchar (2048) = 'An error occurred while deleting confDayeservation: ' + ERROR_MESSAGE ();
      THROW 61000, @errorMsg, 1
    END CATCH
END
GO
