CREATE FUNCTION dbo.FN_GetConfDayReservationPrice(@ConfDayReservationID INT)
  RETURNS INT
AS BEGIN

  DECLARE @ConferenceDayID INT, @BookingDate DATE

  SET @ConferenceDayID = (
    SELECT ConferenceDayID
    FROM ConfDayReservations
    WHERE @ConfDayReservationID = ConfDayReservationID
  )

  SET @BookingDate = (
    SELECT BookingDate
    FROM Reservations AS R
    JOIN ConfDayReservations AS CDR
      ON R.ReservationID = CDR.ReservationID
    WHERE @ConfDayReservationID = ConfDayReservationID
  )

  DECLARE @NormalPrice INT, @StudentPrice INT

  SET @NormalPrice = (
    SELECT Price
    FROM DayPrices
    WHERE DayPriceID = dbo.FN_GetProperDayPriceID(@BookingDate, @ConferenceDayID)
  )

  SET @StudentPrice = (
    SELECT Price * StudentDiscount
    FROM DayPrices
    WHERE DayPriceID = dbo.FN_GetProperDayPriceID(@BookingDate, @ConferenceDayID)
  )

  RETURN (
    SELECT @NormalPrice * (ParticipantsNumber - ConfDayReservations.StudentsNumber) + @StudentPrice * StudentsNumber
    FROM ConfDayReservations
    WHERE @ConfDayReservationID = ConfDayReservationID
  )
END
GO

SELECT